FROM ubuntu
MAINTAINER Julian Sparber "julian@sparber.net"
RUN apt-get update -y && sudo apt-get install -y git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-7-jre openjdk-7-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib vim && apt-get clean
RUN  update-java-alternatives -s java-1.7.0-openjdk-amd64
# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux
RUN ls /opt
# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
RUN echo y | android update sdk --all --force --no-ui --filter tools,platform-tools

RUN which adb
RUN which android

RUN apt-get clean

ADD  http://commondatastorage.googleapis.com/git-repo-downloads/repo /bin/repo
RUN chmod a+rx /bin/repo
RUN adduser builder
ENV HOME /home/builder
RUN chown builder:users -R /home/builder/
USER builder
WORKDIR $HOME
ENTRYPOINT ["/bin/bash"]
