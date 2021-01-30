FROM python:latest

LABEL maintainer="Kovasky Buezo"

ARG tag_name=""

RUN apt-get update && apt-get -y install cron curl wget tar sed
RUN --build-arg tag_name=`curl --silent "https://api.github.com/repos/blawar/nut/releases/latest" | \ 
    grep '"tag_name":' | \                                                 
    sed -E 's/.*"([^"]+)".*/\1/'` && \
    curl -sOL "https://github.com/blawar/nut/archive/$tag_name.tar.gz" && \
    tar -xzvf "$tag_name.tar.gz" -C /root && \
    cd "/root/nut-${tag_name:1}" && \
    pip3 install requirements.txt

COPY /entrypoint.sh /
COPY conf "/root/nut-${tag_name:1}/conf"

RUN chmod +x /entrypoint.sh

RUN touch /var/log/cron.log && touch /var/log/nut.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]

