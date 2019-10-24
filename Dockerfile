FROM python:3-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk add gcc musl-dev

RUN pip3 install --no-cache-dir connexion pymongo docker gunicorn[gevent]

COPY api/openAPI3 /usr/src/app/api
COPY pds /usr/src/app/pds
COPY sc.py /usr/src/app/sc.py

EXPOSE 8080

ENTRYPOINT ["gunicorn"]

CMD ["-w", "4", "-b", "0.0.0.0:8080", "-k", "gevent", "-c", "sc.py", "api.server:create_app()"]