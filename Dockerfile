
FROM python:3.6.9-alpine3.10

ENV PYTHONUNBUFFERED 1

RUN apk update \
  && apk add --virtual build-deps g++ gfortran gcc python3-dev musl-dev

RUN pip install --no-cache-dir cython==0.29.21
RUN pip install --no-cache-dir spacy==2.2.3

RUN python -m spacy download fr_core_news_md

RUN apk update \
  # lxml dependencies
  && apk add --no-cache g++ libxslt libxml2-dev libxslt-dev \
  # Correcting issues with numpy and pandas
  # https://gist.github.com/orenitamar/f29fb15db3b0d13178c1c4dd611adce2
  && apk add --no-cache --update-cache gcc gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev

RUN pip install --no-cache-dir lxml==4.5.0
RUN pip install --no-cache-dir numpy==1.16.2
RUN pip install --no-cache-dir pandas==0.24.1
RUN pip install --no-cache-dir nltk==3.4.5 && \
  python -m nltk.downloader punkt
