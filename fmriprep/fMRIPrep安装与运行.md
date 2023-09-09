

##fMRIPrep安装

### 1、Docker 安装（ubuntu）

安装命令如下：

```
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

测试 Docker 是否安装成功，输入以下指令：

```
sudo docker run hello-world
```

打印出以下信息则安装成功:

```
$ sudo docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete                                                                  Digest: sha256:c3b4ada4687bbaa170745b3e4dd8ac3f194ca95b2d0518b417fb47e5879d9b5f
Status: Downloaded newer image for hello-world:latest


Hello from Docker!
This message shows that your installation appears to be working correctly.


To generate this message, Docker took the following steps:
  1. The Docker client contacted the Docker daemon.
  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
  (amd64)
  3. The Docker daemon created a new container from that image which runs the
  executable that produces the output you are currently reading.
  4. The Docker daemon streamed that output to the Docker client, which sent it
  to your terminal.


To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### 2、拉取镜像

终端输入：

```
python -m pip install --user --upgrade fmriprep-docker
```

添加环境变量：

```
echo 'export PATH=$PATH:your_path' >> ~/.bash_profile
source ~/.bash_profile
```

重启终端后可以使用 `which fmriprep-docker` 来验证。

### 3、安装 TemplateFlow

```
pip install templateflow
```

安装后在安装目录中解压模板：

```
unzip $HOME/.cache/templateflow/conf/templateflow-skel.zip -d $HOME/.cache/templateflow
```

### 4、FreeSurfer license

```
mv ~/license.txt $HOME/test_tutorial/derivatives
```

## fMRIPrep运行

查看运行脚本：

```
cat $HOME/test_tutorial/code/fmriprep.sh
```

运行：

```
bash
source $HOME/test_tutorial/code/fmriprep.sh
```