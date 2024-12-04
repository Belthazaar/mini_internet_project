FROM python:3.13.0-alpine3.20

RUN apk add --no-cache iputils tmux

COPY ping.py /home/ping.py
RUN chmod +x /home/ping.py

WORKDIR /home
CMD ["python", "ping.py"]
