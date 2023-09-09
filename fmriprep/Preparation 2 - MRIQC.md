## 准备工作（2）——MRIQC

MRIQC 是一个 BIDS 应用程序，它利用 BIDS 兼容的数据集来对 T1w、T2w 和/或功能像执行质量评估 (QA)。评估结果以 HTML 报告的形式出现，可用于检查所收集数据的质量，并确定数据质量是否足以用于后续的预处理和分析。

安装：

```
docker run -it poldracklab/mriqc:0.15.1 --version
```

步骤：

```
mv ~/mriqc.sh $HOME/test_tutorial/code
bash
source $HOME/test_tutorial/code/mriqc.sh
```

