# Using include-what-you-use (IWYU) with this image

This folder contains a small helper `iwyu_tool.py` that runs `include-what-you-use`
over a `compile_commands.json` (CMake compile database) and saves per-file outputs
under `iwyu_out/`.

Quick examples

1) Generate `compile_commands.json` with CMake

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

2) Run IWYU from the container (project mounted at `/code`)

Build the image (if not already built):

```bash
docker build --platform linux/amd64 -t vim-centos10-dev ./vim/
```

Run the helper (mounts current repo to `/code`):

```bash
docker run --rm -v "$PWD":/code -w /code vim-centos10-dev \
  /usr/local/bin/iwyu_tool.py -p build/compile_commands.json -j 4
```

3) Interactive shell (manual runs / debugging)

```bash
docker run --rm -it -v "$PWD":/code -w /code vim-centos10-dev bash
# then inside container:
# /usr/local/bin/iwyu_tool.py -p build/compile_commands.json
```

Flags

- `-p/--compile-commands`: path to `compile_commands.json` (default `build/compile_commands.json`)
- `-b/--iwyu-binary`: path to the `include-what-you-use` binary (default `include-what-you-use`)
- `-j/--jobs`: parallel jobs
- `--out-dir`: output directory for per-file results (default `iwyu_out`)

Notes

- This script is a minimal helper and not a drop-in replacement for the official
  `iwyu_tool.py` in the upstream repo. It runs the IWYU binary for each translation
  unit and saves stdout/stderr for inspection.
- To automatically apply fixes, consider using the upstream `iwyu_tool.py` which
  can generate patch files from IWYU output.
# Using include-what-you-use (IWYU) with this image

This folder contains a small helper `iwyu_tool.py` that runs `include-what-you-use`
over a `compile_commands.json` (CMake compile database) and saves per-file outputs
under `iwyu_out/`.

Quick examples

- Build your project with CMake (generate compile_commands.json):

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

- Run IWYU using the image (mount your project directory):

```bash
docker run --rm -v "$PWD":/src -w /src vim-centos10-dev \
  python3 /root/.vim/iwyu_tool.py -p build/compile_commands.json
```

Replace `/root/.vim/iwyu_tool.py` with the path where you added the script; if you copied
the script into the image you can call it directly.

Flags

- `-p/--compile-commands`: path to `compile_commands.json` (default `build/compile_commands.json`)
- `-b/--iwyu-binary`: path to the `include-what-you-use` binary (default `include-what-you-use`)
- `-j/--jobs`: parallel jobs
- `--out-dir`: output directory for per-file results (default `iwyu_out`)

Notes

- This script is a minimal helper and not a drop-in replacement for the official
  `iwyu_tool.py` in the upstream repo. It runs the IWYU binary for each translation
  unit and saves stdout/stderr for inspection.
- To automatically apply fixes, use the official upstream `iwyu_tool.py` which can
  generate patch files based on IWYU output.
