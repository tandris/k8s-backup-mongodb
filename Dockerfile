FROM mongo:latest

RUN apt update
RUN apt install awscli -y

WORKDIR /scripts

COPY backup-mongodb.sh .
RUN chmod +x backup-mongodb.sh

ENV MONGODB_URI ""
ENV BUCKET_URI ""
ENV SUBFOLDER ""
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV AWS_DEFAULT_REGION ""
ENV AWS_ENDPOINT_URL ""
ENV MONGODB_DB_NAME ""

CMD ["/scripts/backup-mongodb.sh"]
