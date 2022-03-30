FROM ubuntu:20.04

LABEL maintainer="Jia <angersax@sina.com>"

USER root
ARG GID=1000
ARG UID=1000
ARG LANG_EN="en_US.UTF-8"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y && \
    apt install -y build-essential curl file git locales lsof m4 make net-tools && \
    apt install -y patch python3 python3-pip software-properties-common && \
    apt install -y sudo unzip upx vim wget zip
RUN apt autoremove --purge -y > /dev/null && \
    apt autoclean -y > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/* && \
    rm -rf /tmp/*
RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    echo "LC_ALL=$LANG_EN" >> /etc/environment && \
    echo "LANG=$LANG_EN" > /etc/locale.conf && \
    echo "$LANG_EN UTF-8" >> /etc/locale.gen && \
    echo "StrictHostKeyChecking no" | tee --append /etc/ssh/ssh_config && \
    echo "ulimit -n 4096" | tee --append /etc/profile && \
    echo "ulimit -s 102400" | tee --append /etc/profile && \
    echo "craftslab ALL=(ALL) NOPASSWD: ALL" | tee --append /etc/sudoers && \
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    groupadd -g $GID craftslab && \
    useradd -d /home/craftslab -ms /bin/bash -g craftslab -u $UID craftslab
RUN locale-gen $LANG_EN && \
    update-locale LC_ALL=$LANG_EN LANG=$LANG_EN
ENV LANG=$LANG_EN
ENV LC_ALL=$LANG_EN
ENV SHELL="/bin/bash"

USER craftslab
WORKDIR /home/craftslab
RUN curl -LO https://nodejs.org/dist/v14.17.5/node-v14.17.5-linux-x64.tar.xz && \
    tar Jxvf node*.tar.xz && \
    rm node*.tar.xz && \
    mv node-* node
ENV PATH=/home/craftslab/node/bin:$PATH

USER craftslab
WORKDIR /home/craftslab
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git --depth 1
ENV PATH=/home/craftslab/depot_tools:$PATH
RUN sudo apt update && \
    sudo apt install -y automake libmysqlclient-dev python2.7 python2.7-dev python-is-python2 && \
    curl -L https://bootstrap.pypa.io/pip/2.7/get-pip.py -o /tmp/get-pip.py && \
    sudo python /tmp/get-pip.py
#RUN sudo apt install -y apt-transport-https ca-certificates gnupg && \
#    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
#    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
#    sudo apt update && \
#    sudo apt install -y google-cloud-sdk google-cloud-sdk-app-engine-python-extras google-cloud-sdk-app-engine-python

USER craftslab
WORKDIR /home/craftslab
RUN fetch infra && \
    pushd infra/appengine/monorail && \
    gclient runhooks && \
    popd
COPY 0001-Set-user-and-password-for-sql-connection.patch infra/appengine/monorail/
RUN pushd infra/appengine/monorail && \
    git config user.name "foo" && \
    git config user.email "foo@example.com" && \
    git am *.patch && \
    rm *.patch && \
    popd
RUN pushd infra/appengine/monorail && \
    make dev_deps && \
    make deps && \
    popd

USER craftslab
WORKDIR /home/craftslab/infra/appengine/monorail
ENV NODE_OPTIONS=--openssl-legacy-provider
CMD [ "make", "serve" ]
