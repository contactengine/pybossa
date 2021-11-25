FROM python:3.8-buster AS build

ARG VERSION
ARG REVISION

LABEL org.opencontainers.image.title=pybossa \
      org.opencontainers.image.version=${VERSION} \
      org.opencontainers.image.revision=${REVISION}

RUN apt-get update \
  && apt-get -y upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
  libsasl2-dev=2.1.27+dfsg-1+deb10u1 \
  libldap2-dev=2.4.47+dfsg-3+deb10u6 \
  libssl-dev=1.1.1d-0+deb10u7 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV VIRTUAL_ENV=/app/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt setup.py setup.cfg ./
COPY pybossa/version.txt pybossa/version.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY *.py ./
COPY alembic/ alembic/
COPY pybossa/ pybossa/

FROM python:3.8-slim-buster

RUN apt-get update \
  && apt-get -y upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
  postgresql-client=11+200+deb10u4 \
  redis-tools=5:5.0.14-1+deb10u1 \
  dumb-init=1.2.2-1.1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && addgroup --system --gid 2000 pybossa \
  && adduser --system --uid 1000 --ingroup pybossa --disabled-password --gecos "" pybossa

WORKDIR /home/pybossa
COPY --from=build --chown=pybossa:pybossa /app .

ENV VIRTUAL_ENV=/home/pybossa/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["python", "run.py"]

EXPOSE 5000
USER pybossa
