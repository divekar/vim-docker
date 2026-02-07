#!/usr/bin/env python3
"""
Simple IWYU runner: reads a compile_commands.json and runs include-what-you-use
for each translation unit found. Prints IWYU output to stdout and can save per-file
outputs under a `iwyu_out/` folder.

This is a lightweight helper (not the official script). It assumes `include-what-you-use`
is available on PATH or at the path provided with `-b`.
"""
import argparse
import json
import os
import shlex
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed


def parse_args():
    p = argparse.ArgumentParser(description="Run include-what-you-use over a compile_commands.json")
    p.add_argument('-p', '--compile-commands', default='build/compile_commands.json',
                   help='Path to compile_commands.json')
    p.add_argument('-b', '--iwyu-binary', default='include-what-you-use',
                   help='Path to include-what-you-use binary')
    p.add_argument('-j', '--jobs', type=int, default=4, help='Parallel jobs')
    p.add_argument('--out-dir', default='iwyu_out', help='Directory to write per-file outputs')
    p.add_argument('--quiet', action='store_true')
    return p.parse_args()


def load_compdb(path):
    with open(path, 'r') as f:
        return json.load(f)


def build_command(iwyu_bin, entry):
    # entry: {file, directory, command|arguments}
    filename = entry.get('file')
    args = []
    if 'arguments' in entry:
        args = entry['arguments'].copy()
        # some compdbs put the compiler first; IWYU expects the source file as first arg
        # ensure the source filename is present (it usually is)
    else:
        # split command
        args = shlex.split(entry.get('command', ''))
    # remove the compiler executable if present at args[0]
    if args and os.path.basename(args[0]) in ('gcc', 'g++', 'clang', 'clang++', 'cc', 'c++'):
        args = args[1:]
    # Ensure file present; some entries include it, some don't
    if filename not in args:
        # append filename before flags
        args = [filename] + args
    cmd = [iwyu_bin] + args
    return cmd, filename


def run_iwyu(cmd, cwd=None):
    try:
        out = subprocess.run(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=False)
        return out.returncode, out.stdout, out.stderr
    except FileNotFoundError as e:
        return 127, '', str(e)


def worker(iwyu_bin, entry):
    cmd, filename = build_command(iwyu_bin, entry)
    cwd = entry.get('directory')
    code, sout, serr = run_iwyu(cmd, cwd=cwd)
    return filename, code, sout, serr


def main():
    args = parse_args()
    compdb_path = args.compile_commands
    if not os.path.exists(compdb_path):
        print(f"compile_commands.json not found at: {compdb_path}")
        raise SystemExit(2)
    compdb = load_compdb(compdb_path)
    os.makedirs(args.out_dir, exist_ok=True)

    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        futures = [ex.submit(worker, args.iwyu_binary, e) for e in compdb]
        for f in as_completed(futures):
            filename, code, sout, serr = f.result()
            safe_name = filename.replace(os.sep, '_').replace('..', '__')
            out_path = os.path.join(args.out_dir, safe_name + '.iwyu.txt')
            with open(out_path, 'w') as of:
                of.write('=== STDOUT ===\n')
                of.write(sout)
                of.write('\n=== STDERR ===\n')
                of.write(serr)
            if not args.quiet:
                print(f'[{filename}] exit={code} -> {out_path}')


if __name__ == '__main__':
    main()
