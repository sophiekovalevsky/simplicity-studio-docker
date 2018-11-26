FROM ubuntu:16.04
LABEL maintainer "Kiara Navarro <sophiekovalevsky@fedoraproject.org>"

ENV USER_NAME=${USER_NAME:-engineer}
ENV HOME=/home/${USER_NAME}
ENV SIMPLICITY_STUDIO_DIR=simplicity-studio

RUN mkdir /app
WORKDIR /app

#### ---- Do the setup and add udev rules to container
COPY ${SIMPLICITY_STUDIO_DIR}/setup.sh .
COPY ${SIMPLICITY_STUDIO_DIR}/StudioLinux StudioLinux

#### ---- Package installation ----
RUN dpkg --add-architecture i386 \
    && apt-get update \
    ### ---- Create udev folder. Required by setup.sh ----
    && mkdir -p /etc/udev/rules.d \
    #### ---- Just install right away
    && sed -i "s/sudo apt-get install/apt-get install -y/" "setup.sh" \
    #### ---- Run their own setup
    #### You can use ./setup if you are at the folder, however, you can use the absolute path
  	&& ./setup.sh \
    #### ---- Install required packages until Silabs launch a new release with this issue fixed :/
    && apt-get install -y packagekit-gtk3-module libcanberra-gtk-module libqt4-network \
  	&& apt-get autoremove --purge -y \
  	&& apt-get clean

#### ---- Remove things that won't be need it
RUN rm setup.sh
RUN rm -rf StudioLinux

#### ---- Run as non-privileged user
RUN useradd -ms /bin/bash ${USER_NAME}
USER ${USER_NAME}
WORKDIR ${HOME}

#### ---- Run Simplicity Studio
ENTRYPOINT ["/opt/simplicity-studio/run_studio.sh"]
