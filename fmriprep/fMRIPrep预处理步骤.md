## fMRIPrep预处理步骤

### 1 结构像

**<u>颅骨剥离</u>**：通过 Nipype 调用 antsBrainExtraction.sh(ANTs) 实现对 T1w 参考像进行颅骨剥离。

​					`using: [niworkflows-ants]`

**<u>组织分割</u>**：调用 FSL 的 FAST 模块，根据脑组织内部信号强度，将脑组织分为灰质、白质、脑脊液。

​					`分割概率掩码（CSF、白质和灰质）的阈值:0.95`

​					`(剩余的值将成为二进制组织蒙版)`

**<u>T1w空间标准化</u>**：调用 ANTs 的 antsRegistration 模块，使用模板：MNI152Nlin2009cAsym。

### 2 功能像

**<u>头动估计</u>**：调用FSL的mcflirt模块估计刚体变换的6个头动参数。

​					`using: [mcflirt]`

​					`motion_correction_reference: ['fmriprep_reference']`

<u>**mask**</u>：`using: [FSL_AFNI]`

**<u>磁化率失真校正(SDC)</u>**：调用基于Nipype的SDCFlows库。

--注：对于南京的数据，目前采用的方法是 Phase-difference B0 mapping（利用相位差估计B0图像），需要在转换BIDS结构时在 .json文件中用 IntendedFor 填写字段来链接到获取它的特定扫描；如果不指定  IntendedFor 则不运行 SDC。

**<u>原生空间预处理BOLD</u>**：利用前面头动校正以及SDC过程中估计的mapping，来完成基于单次插值的校正。

**<u>EPI序列配准T1w</u>**：实现了EPI参考像和重建所得灰白质交界的配准（如果使用了Freesurfer，则利用bbregister模块，如果没有使用Freesurfer，FSL则会利用fast模块来估计灰白质边界）。

**<u>BOLD 空间标准化</u>**：把上述所有校正配准过程的形变综合，将BOLD图像配准到标准空间MNI152Nlin2009cAsym