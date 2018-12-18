FROM python:3.6.6-stretch

LABEL maintainer="wanglin@dbca.cn"
LABEL createat="20181208"

RUN pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
	aliyun-python-sdk-core-v3 \
	certbot

WORKDIR /usr/src/app/

COPY alidns.py /usr/src/app/
COPY log.py /usr/src/app/
COPY authenticator.sh /usr/src/app/
COPY update /bin/update

CMD ["/usr/local/bin/certbot", "renew", "--force-renewal"]
