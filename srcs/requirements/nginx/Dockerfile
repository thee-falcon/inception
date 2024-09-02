FROM alpine:3.18

RUN apk update && apk add nginx openssl

RUN mkdir -p /etc/nginx/ssl

COPY requirements/nginx/tools/omakran.crt /etc/nginx/ssl
COPY requirements/nginx/tools/omakran.key /etc/nginx/ssl
COPY requirements/nginx/conf/default.conf /etc/nginx/http.default

CMD ["nginx", "-g", "daemon off;"]
