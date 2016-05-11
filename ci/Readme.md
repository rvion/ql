
reproduire ça dans rancher via l'ui dans un nouveau stack appelé "ci"
```yaml
ci:
  image: rvion/jenkins-with-docker
  volumes:
  - /jenkins/:/var/jenkins_home/
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/bin/docker:/usr/bin/docker
  ports:
  - 80:8080/tcp
  - 50000:50000/tcp
```

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
   
------

pour info, l'image rvion/jenkins-with-docker a été construite avec cette commande:

```shell
docker build -t rvion/jenkins-with-docker .
```

puis poussé sur docker hub avec cette commande

```shell
docker push -t rvion/jenkins-with-docker .
```
