## TP - App4 Qualité Logicielle - ~2H

- [ ] make ssh key (ssh-keygen -f yourname -N "") (be sure to include __your name__)
- [ ] go on https://cloud.digitalocean.com/droplets/new?size=2gb&region=lon1&options=private_networking,ipv6
- [ ] choose a region not too far, ubuntu 14/04 x64 (defaut), 20$/mo, ipv6 et private networking (mais pas backups),
- [ ] copy pub key (cat yourname.pub | pbcopy)
- [ ] add your ssh pub key
- [ ] choose a simple name __with your name__
- [ ] create the machine
- [ ] log in the machine ssh -i yourname root@ipofthemachine
- [ ] install docker with (`curl -sSL https://get.docker.com/ | sh`) (if no curl, install curl with `apt-get update -q && apt-get install curl`)
- [ ] launch rancher (http://docs.rancher.com/rancher/latest/en/installing-rancher/installing-server/) -> (`sudo docker run -d --restart=always -p 80:8080 rancher/server`)
- [ ] setup dommain name with Rémi
- [ ] login rancher (go to the ip of your machine in web browser)
- [ ] setup security via github (see instructions on your rancher)
- [ ] create 3 hosts on the same geographic Region, with enable private networking



### auth

docker run --name postgres \
  -e POSTGRES_DATABASE=keycloak \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_ROOT_PASSWORD=password \
  -d postgres

docker run \
  --restart always \
  --name keycloak \
  --link postgres:postgres  \
  -e POSTGRES_DATABASE=keycloak  \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -p "80:8080" \
  -d rvion/auth:0.19.1
