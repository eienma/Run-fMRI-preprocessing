# C-PAC 安装与运行

## [1、Docker 安装（ubuntu）](https://github.com/eienma/Run-fMRI-preprocessing/blob/master/fmriprep/fMRIPrep安装与运行.md#1docker-安装ubuntu)

安装命令如下：

```bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

测试 Docker 是否安装成功，输入以下指令：

```bash
sudo docker run hello-world
```

打印出以下信息则安装成功：

```bash
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

## 2、安装C-PAC

cpac 需要 Python 3.6 或更高版本。

```bash
pip install cpac
```

```bash
cpac --platform docker --tag nightly pull
```

```bash
docker run -i --rm \
        -v /Users/You/local_bids_data:/bids_dataset \
        -v /Users/You/some_folder:/outputs \
        -v /tmp:/tmp \
        -v /Users/You/Documents:/configs \
        -v /Users/You/resources:/resources \
        fcpindi/c-pac:latest /bids_dataset /outputs participant --pipeline_file /configs/pipeline_config.yml --n_cpus 12 --mem_gb 12 --participant_label 17
```