# letsencrypt auto renewal by dns challenge

使用条件:

* 已经有dns记录存在

## env

* ALI_SECRET_ID=
* ALI_SECRET_KEY=

## create accounts and renewal config file

* shell

```bash
$ certbot certonly --manual --preferred-challenges=dns --manual-auth-hook /usr/src/app/authenticator.sh -d hub.digi-sky.com
```

* docker

```bash
docker run -it --rm --name alidns -e ALI_SECRET_ID=xxx -e ALI_SECRET_KEY=xxx -v /data/ssl/:/etc/letsencrypt/ hub.digi-sky.com/base/alidns:1.0.0 update hub.digi-sky.com
```

## renewal by force

* shell

```bash
certbot renew --force-renewal
```
* docker

```bash
docker run -it --rm --name alidns -e ALI_SECRET_ID=xxx -e ALI_SECRET_KEY=xxx -v /data/ssl/:/etc/letsencrypt/ hub.digi-sky.com/base/alidns:1.0.0
```
