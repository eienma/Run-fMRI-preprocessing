## 准备工作（1）——建立 BIDS 结构、格式转换

新建 BIDS 结构文件夹

```bash
cd $HOME
mkdir test_tutorial
```

将dicom数据放入文件夹

```bash
mv ~/Downloads/raw_data $HOME/test_tutorial
```

安装 dcm2niix 

```bash
cd ~
git clone https://github.com/rordenlab/dcm2niix.git
cd dcm2niix
mkdir build
cd build
cmake ..
make
```

并添加环境变量：

```bash
export PATH="$HOME/dcm2niix/build/bin/:$PATH"
```

安装 dcm2bids

```bash
pip uninstall dcm2bids
pip install dcm2bids --user
```

编辑 `BIDS_config.json` 文件配置，示例参考：

```json
 {
   "descriptions": [
      {
         "dataType": "anat",
         "modalityLabel": "T1w",
         "criteria": {
            "SidecarFilename": "002*"
         }
      },
      {
         "dataType": "fmap",
         "modalityLabel": "epi",
         "customLabels": "dir-AP",
         "IntendedFor": [
            4,
            6
         ],
         "criteria": {
            "SidecarFilename": "003*"
         }
      },
      {
         "dataType": "fmap",
         "modalityLabel": "epi",
         "customLabels": "dir-PA",
         "IntendedFor": [
            4,
            6
         ],
         "criteria": {
            "SidecarFilename": "004*"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "sbref",
         "customLabels": "task-bart_run-01",
         "criteria": {
            "SidecarFilename": "005*"
         },
         "sidecarChanges": {
            "TaskName": "bart"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "bold",
         "customLabels": "task-bart_run-01",
         "criteria": {
            "SidecarFilename": "006*"
         },
         "sidecarChanges": {
            "TaskName": "bart"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "sbref",
         "customLabels": "task-rest_run-01",
         "criteria": {
            "SidecarFilename": "007*"
         },
         "sidecarChanges": {
            "TaskName": "rest"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "bold",
         "customLabels": "task-rest_run-01",
         "criteria": {
            "SidecarFilename": "008*"
         },
         "sidecarChanges": {
            "TaskName": "rest"
         }
      },
      {
         "dataType": "anat",
         "modalityLabel": "T2w",
         "criteria": {
            "SidecarFilename": "010*"
         }
      },
      {
         "dataType": "fmap",
         "modalityLabel": "magnitude1",
         "IntendedFor": [
            11,
            13
         ],
         "criteria": {
            "SidecarFilename": "011*",
            "EchoTime": 0.00492
         }
      },
      {
         "dataType": "fmap",
         "modalityLabel": "phasediff",
         "IntendedFor": [
            11,
            13
         ],
         "criteria": {
            "SidecarFilename": "012*"
         },
         "sidecarChanges": {
            "EchoTime1": 0.00492,
            "EchoTime2": 0.00738
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "sbref",
         "customLabels": "task-bart_run-02",
         "criteria": {
            "SidecarFilename": "013*"
         },
         "sidecarChanges": {
            "TaskName": "bart"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "bold",
         "customLabels": "task-bart_run-02",
         "criteria": {
            "SidecarFilename": "014*"
         },
         "sidecarChanges": {
            "TaskName": "bart"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "sbref",
         "customLabels": "task-rest_run-02",
         "criteria": {
            "SidecarFilename": "015*"
         },
         "sidecarChanges": {
            "TaskName": "rest"
         }
      },
      {
         "dataType": "func",
         "modalityLabel": "bold",
         "customLabels": "task-rest_run-02",
         "criteria": {
            "SidecarFilename": "016*"
         },
         "sidecarChanges": {
            "TaskName": "rest"
         }
      },
      {
         "dataType": "anat",
         "modalityLabel": "FLAIR",
         "criteria": {
            "SidecarFilename": "017*"
         }
      },
      {
         "dataType": "dwi",
         "modalityLabel": "dwi",
         "criteria": {
            "SidecarFilename": "018*"
         }
      },
      {
         "dataType": "dwi",
         "modalityLabel": "dwi",
         "criteria": {
            "SidecarFilename": "019*"
         }
      }
   ]
}
```

```
anat-T1w (0)
fmap-SE-AP (1)
fmap-SE-PA (2)
func_task-bart_SBRef (3)
func_task-bart (4)**
func_task-rest_SBRef (5)
func_task-rest (6)**
anat-T2w (7)
gre-field-mapping (8)
gre-field-mapping (9)
func_task-bart_SBRef (10)
func_task-bart (11)**
func_task-rest_SBRef (12)
func_task-rest (13)**
anat-FLAIR (14)
dwi-dir80-AP (15)
dwi-dir80-PA (16)
```

**带星号的采集显示与场图相对应的功能数据。  4 和 6 对应于第一个字段映射对，11 和 13 对应于第二个字段映射对。sbref 采集不包含在 IntendedFor 字段中。 如果收集了一对场图（无论类型如何），那么 IntendedFor 列表将包含所有功能采集的索引。

运行转换：

```bash
dcm2bids_scaffold -o $HOME/test_tutorial
echo "prepare for fmriprep data" > $HOME/test_tutorial/README
dcm2bids -d $HOME/test_tutorial/test_tutorial_data -p 01 -c $HOME/BIDS_config.json -o $HOME/test_tutorial --forceDcm2niix
```

验证BIDS结构：

https://bids-standard.github.io/bids-validator/

（由于 dataset_description.json 文件中存在次要格式问题，在执行 BIDS 验证时可能会遇到错误。 这并不重要，可以忽略。）