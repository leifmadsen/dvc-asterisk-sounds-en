# Version: 0.0.1
FROM centos:7
MAINTAINER AVOXI DevOps "devops@avoxi.com"
ENV REFRESHED_AT 2015-09-01
ENV AST_SOUNDS_DIR /var/lib/asterisk/sounds/en/
RUN mkdir -p $AST_SOUNDS_DIR && yum install tar -y

ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g729-current.tar.gz $AST_SOUNDS_DIR
ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-sln16-current.tar.gz $AST_SOUNDS_DIR
ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz $AST_SOUNDS_DIR
ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g729-current.tar.gz $AST_SOUNDS_DIR
ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-sln16-current.tar.gz $AST_SOUNDS_DIR
ADD http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz $AST_SOUNDS_DIR

WORKDIR $AST_SOUNDS_DIR
RUN for s in g729 sln16 wav; do tar zxvf asterisk-core-sounds-en-$s-current.tar.gz; done
RUN for s in g729 sln16 wav; do tar zxvf asterisk-extra-sounds-en-$s-current.tar.gz; done

RUN rm -f $AST_SOUNDS_DIR/*.tar.gz && yum remove tar -y && yum autoremove -y && yum clean all

VOLUME [ $AST_SOUNDS_DIR ]
CMD [ "echo", "Asterisk English Sounds DVC"]
