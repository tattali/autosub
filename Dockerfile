FROM python:3.10

RUN apt update && \
    apt install -y ffmpeg \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade --no-deps --force-reinstall git+https://github.com/openai/whisper.git

ENTRYPOINT ["whisper"]
