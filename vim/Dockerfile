FROM rockylinux/rockylinux:10

USER root
# 1. Global fix for SSL/Randomness errors
RUN sed -i 's/https:/http:/g' /etc/yum.repos.d/rocky*.repo

# 2. Install EPEL and all build dependencies
# Added: clang-devel and llvm-devel for IWYU
RUN yum install -y epel-release && \
    sed -i 's/https:/http:/g' /etc/yum.repos.d/*.repo && \
    yum install -y \
        git \
        make \
        gcc \
        gcc-c++ \
        clang \
        clang-devel \
        llvm-devel \
        clang-tools-extra \
        cmake \
        gdb \
        nodejs \
        npm \
        fzf \
        ncurses-devel \
        python3-devel \
        ripgrep \
        curl && \
    yum clean all

# 3. Build Vim
RUN git config --global http.sslVerify false && \
    cd /tmp && \
    git clone --depth 1 https://github.com/vim/vim.git && \
    cd vim && \
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-python3interp=yes \
                --with-python3-config-dir=$(python3-config --configdir) \
                --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    rm -rf /tmp/vim

# 4. Build Include-What-You-Use (Clang 20)
# We check out 'clang_20' 
RUN cd /tmp && \
    git clone https://github.com/include-what-you-use/include-what-you-use.git && \
    cd include-what-you-use && \
    git checkout clang_20 && \
    mkdir build && cd build && \
    cmake -G "Unix Makefiles" \
          -DCMAKE_PREFIX_PATH=/usr \
          -DCMAKE_C_COMPILER=clang \
          -DCMAKE_CXX_COMPILER=clang++ .. && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    rm -rf /tmp/include-what-you-use

# 5. Install vim-plug
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs --insecure \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 6. Setup Configuration Files
COPY .vimrc /root/.vimrc
RUN mkdir -p /root/.vim
COPY coc-settings.json /root/.vim/coc-settings.json
COPY .clangd /root/.clangd 
COPY quick-reference.txt /root/quick-reference.txt

# 7. Install Vim plugins
RUN vim -E -s -u "/root/.vimrc" +PlugInstall +qall || true

# 8. Install coc extensions
RUN mkdir -p /root/.config/coc/extensions && \
    cd /root/.config/coc/extensions && \
    echo '{"dependencies":{}}' > package.json && \
    npm config set strict-ssl false && \
    npm config set registry http://registry.npmjs.org/ && \
    npm install coc-clangd coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock


# Install iwyu helper script into image
COPY iwyu_tool.py /usr/local/bin/iwyu_tool.py
RUN chmod +x /usr/local/bin/iwyu_tool.py || true

# 9. Verify and Bash Setup
RUN echo 'cat ~/quick-reference.txt 2>/dev/null || true' >> /root/.bashrc

#CMD ["/usr/local/bin/vim"]
