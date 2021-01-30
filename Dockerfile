FROM python:latest

LABEL maintainer="Kovasky Buezo"

RUN apt-get update && apt-get -y install cron git
RUN git clone "https://github.com/blawar/nut" && \
    mv nut /root && \
    cd "/root/nut" && \
    pip3 install -r "/root/nut/requirements.txt"
    
COPY /entrypoint.sh /
COPY conf "/root/nut/conf"

RUN chmod +x /entrypoint.sh
RUN touch /var/log/cron.log && touch /var/log/nut.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]
