#!/bin/bash

#User inputs:
bids_root_dir=/home/test_tutorial #指定根目录
subj=01 #指定预处理sub
nthreads=4
mem=20 #gb
container=docker #docker or singularity

#Begin:

#Convert virtual memory from gb to mb
mem=`echo "${mem//[!0-9]/}"` #remove gb at end
mem_mb=`echo $(((mem*1000)-5000))` #reduce some memory for buffer space during pre-processing

export TEMPLATEFLOW_HOME=/home/.local/lib/python3.8/site-packages/templateflow #指定template位置
export FS_LICENSE=/home/test_tutorial/derivatives/license.txt #指定freesurfer运行所需license.txt

#Run fmriprep
if [ $container == singularity ]; then
  unset PYTHONPATH; singularity run -B $HOME/.cache/templateflow:/opt/templateflow $HOME/fmriprep.simg \
    $bids_root_dir $bids_root_dir/derivatives \
    participant \
    --participant-label $subj \
    --skip-bids-validation \
    --md-only-boilerplate \
    --fs-license-file $FREESURFER_HOME/license.txt \
    --fs-no-reconall \
    --output-spaces MNI152NLin2009cAsym:res-native \
    --nthreads $nthreads \
    --stop-on-first-crash \
    --mem_mb $mem_mb \
    -w $HOME
else
  fmriprep-docker $bids_root_dir $bids_root_dir/derivatives \
    participant \
    --participant-label $subj \
    --skip-bids-validation \ #假设输入数据集符合 BIDS 标准并跳过验证
    --md-only-boilerplate \ #使用 pandoc 跳过生成 HTML 和 LaTeX 格式的引用，仅生成markdown，去掉后会生成正常LaTeX 格式的引用
    --fs-license-file $/home/test_tutorial/derivatives/license.txt \ 
    --fs-no-reconall \  #禁用 FreeSurfer 表面预处理，ps：也可以使用，但时间会很长，5-8小时左右
    --output-spaces MNI152NLin2009cAsym:res-native \ #标准化到指定空间
    --nthreads $nthreads \
    --stop-on-first-crash \
    --mem_mb $mem_mb \ 
    -w $HOME
fi
