readme.md

https://github.com/gambol99/keycloak-proxy
bin/keycloak-proxy \
    --discovery-url=https://auth.rvion.fr/auth/realms/master \
    --client-id=jenkins \
    --secret=<SECRET> \
    --listen=127.0.0.1:3000 \
    --redirection-url=http://127.0.0.3000 \
    --refresh-sessions=true \
    --encryption-key=AgXa7xRcoClDEU0ZDSH4X0XhL5Qy2Z2j \
    --upstream=http://127.0.0.1:80 \
    --resource="uri=/admin|methods=GET|roles=test1,test2" \
    --resource="uri=/backend|roles=test1"


### jenkins options

```
build-pipeline-plugin
copyartifact
parameterized-trigger
git-parameter
mask-passwords
```

http://nathanleclaire.com/blog/2014/07/12/10-docker-tips-and-tricks-that-will-make-you-sing-a-whale-song-of-joy/
https://hub.docker.com/r/evarga/jenkins-slave/~/dockerfile/
evarga/jenkins-slave

https://docs.docker.com/engine/examples/running_ssh_service/

apt-get update && apt-get install -y openssh-server
mkdir /var/run/sshd
echo 'root:pass' | chpasswd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
/usr/sbin/sshd -D
### build command:

https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin#GitHubPlugin-GithubPlugin
