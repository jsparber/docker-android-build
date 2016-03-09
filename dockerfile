FROM ubuntu
MAINTAINER Julian Sparber "julian@sparber.net"
RUN apt-get update -y && sudo apt-get install -y git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-7-jre openjdk-7-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib vim && apt-get clean
RUN  update-java-alternatives -s java-1.7.0-openjdk-amd64
ADD  http://commondatastorage.googleapis.com/git-repo-downloads/repo /bin/repo
RUN chmod a+rx /bin/repo
RUN adduser builder
ENV HOME /home/builder
RUN chown builder:users -R /home/builder/
USER builder
WORKDIR $HOME
ENTRYPOINT ["/bin/bash"]
