# TP - App4 Qualité Logicielle - ~2H


#### prerequisites:

 - github account (facultative)
 - docker-hub account (facultative)
 - cloudflare account (facultative)
 - ssh on your machine

---------

## I. Let's build some Cluster

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

----------------

## Continuous Integration

### Lancer jenkins

reproduire ça dans rancher via l'ui dans un nouveau stack appelé "ci"
```yaml
ci:
  image: rvion/jenkins-with-docker
  volumes:
  - /ci-data/:/var/jenkins_home/
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/bin/docker:/usr/bin/docker
  ports:
  - 80:8080/tcp
  - 50000:50000/tcp
```
### Configurer jenkins

#### 0/3 install github plugins
  - [ ] go to jenkins > manage jenkins > manage plugins > available tab
  - [ ] check "github plugin"
  - [ ] check "github auth plugin"
  - [ ] click install without restart
  - [ ] mark the "restart jenkins blablabla" checkbox at the bottom
  - [ ] wait for jenkins to restart

#### 1/3 configure github OAuth
  - [ ] go to jenkins > manage jenkins > Configure Global Security >
    - [ ] mark "Enable security"
    - [ ] security realm > select github authentication plugin
    - [ ] create a custom app here: https://github.com/settings/applications/new
      - [ ] homepage url is the ip/url of your jenkins
      - [ ] Authorization callback URL is `yourhomepageurl/securityRealm/finishLogin` (according to the doc https://wiki.jenkins-ci.org/display/JENKINS/Github+OAuth+Plugin)
    - [ ] fill client id and secret on jenkins
    - [ ] select (Project-based Matrix Authorization Strategy)
    - [ ] :warning: add your github username just below and grant you access (administer). don't press <Enter> but use your mouse to click the Add button. UI is crappy as hell
    - [ ] press enter

#### 2/3 configure github status API

  - [ ] go to jenkins > manage jenkins > Configure System > github section
   - [ ] add github server
   - [ ] you need to add a token credential (of type secret text on jenkins). create it here https://github.com/settings/tokens with rights:
      - repo > repo:status
      - admin:repo_hook > {write + read}
   - [ ] save
  - [ ] "fork" https://github.com/rvion/ql to your github profile (https://github.com/yourname/ql)

oh, and while you're on this page, you can also set Quiet period to 0


#### 3/3 create job

  - [ ] go to jenkins > jobs > new job
  - [ ] freestry project with whatever name you want > click ok
  - [ ] configure jenkins job like that:
     - [ ] mark "github project" > git@github.com:yourname/ql.git
     - [ ] Source Code Management >
        - [ ] select Git > git@github.com:yourname/ql.git
        - [ ] credentials > (put your credentials (if you don't have 2 factors auth) or create new rsa key, upload pub on github, paste private on jenkins) ensure you don't have an error message saying you can't connect
        - [ ] Branches to build: remove everything so it's empty (to build everything)
     - [ ] Build Triggers > Build when a change is pushed to GitHub
     - [ ] Build > add build step > Execute Shell (fill in `ql/travis.sh`)
     - [ ] Post-build Actions > Add post build actions > set status for github (universal) > (change status result to "one of default messages and statuses")
     - [ ] save
   - [ ] hit `build now`
   - [ ] ...
   - [ ] profit

#### 4/3

 - [ ] check memory consumption, check container running on rancher
 - [ ] go on rancher > infrastructure
 - [ ] ci_1 >  click '...' > click "execute shell"
 - [ ] docker login at least once


pour info, l'image rvion/jenkins-with-docker a été construite puis poussé sur docker hub avec ces commande

```shell
docker build -t rvion/jenkins-with-docker ci
docker push rvion/jenkins-with-docker
```


---------

## auth

### Lancer Postgres et keycloak

- [] reproduire ça dans un nouveau stack nommé "auth" sur rancher via l'UI


```shell
docker run --name postgres \
  -e POSTGRES_DATABASE=keycloak \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_ROOT_PASSWORD=password \
  -d postgres
```

```shell
docker run \
  --restart always \
  --name keycloak \
  --link postgres:postgres  \
  -e POSTGRES_DATABASE=keycloak  \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -p "80:8080" \
  -d rvion/auth:1.9.3.Final
```

infos:
 `-e` => ENV variable
 `-p` => PORT binding
 `-d` => --daemon (already the default on rancher)
 `--restart always` (already the default on rancher)

----------------------
