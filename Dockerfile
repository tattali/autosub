FROM python:3.9

ARG DEPSLIST=requirements.txt

ENV PYTHONUNBUFFERED 1

ADD https://github.com/mozilla/DeepSpeech/releases/download/v${MODEL_VERSION]/deepspeech-${MODEL_VERSION]-models.pbmm ./
ADD https://github.com/mozilla/DeepSpeech/releases/download/v${MODEL_VERSION]/deepspeech-${MODEL_VERSION]-models.scorer ./

COPY setup.py ./
COPY autosub ./autosub

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    apt -y install ffmpeg libsm6 libxext6 && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

COPY $DEPSLIST ./requirements.txt

# make sure pip is up-to-date
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir audio output

ENTRYPOINT ["python3", "autosub/main.py"]
