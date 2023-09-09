## 输入与输出

### 运行输入

*要求“广义”BIDS数据结构：

```
<inputdir>/
  derivatives/
    license.txt # freesurfer运行必要文件
  codes/
    fmriprep.sh # 运行脚本
  sub-<label>/ # BIDS结构
    anat/ # .json文件非必需
    func/ # .json是必需文件
    dwi/
    fmap/
    ...
  sourcedata/ # 空文件夹，存在的必要是因为freesurfer
  dataset_description.json # 必需结构，但内容非必需
```

### 运行输出

```text
<outputdir>/
  derivatives/
  	logs/
  	sub-<label>/
  	    
  		anat/ #结构像预处理结果
    		sub-<label>[_space-<space_label>]_desc-preproc_T1w.nii.gz
    		# 预处理后的T1图像
    		sub-<label>[_space-<space_label>]_desc-brain_mask.nii.gz
    		# Mask
    		sub-<label>[_space-<space_label>]_dseg.nii.gz
    		# 分割后的结果
    		sub-<label>[_space-<space_label>]_label-CSF_probseg.nii.gz
    		# 脑脊液
    		sub-<label>[_space-<space_label>]_label-GM_probseg.nii.gz
    		# 灰质
    		sub-<label>[_space-<space_label>]_label-WM_probseg.nii.gz
    		# 白质
    		
			sub-<label>_from-[_space-<space_label>]_to-T1w_mode-image_xfm.h5
    		sub-<label>_from-T1w_to-[_space-<space_label>]_mode-image_xfm.h5
    		
    		#如果使用 FreeSurfer 重建，則會生成以下文件：
    		#（2022.3.14更新：考虑到张老师说freesurfer单独做，所以这部分可以先不考虑）
    		sub-<label>_hemi-[LR]_smoothwm.surf.gii      # 白质表面
    		sub-<label>_hemi-[LR]_pial.surf.gii          # 软膜表面
    		sub-<label>_hemi-[LR]_midthickness.surf.gii  # 中央表面
    		sub-<label>_hemi-[LR]_inflated.surf.gii      # 膨胀后的白质表面
    	
    	func/ #功能像预处理结果
    		sub-<label>_[specifiers]_from-scanner_to-T1w_mode-image_xfm.txt
    		sub-<label>_[specifiers]_from-T1w_to-scanner_mode-image_xfm.txt
    		
            sub-<label>_[specifiers]_space-<space_label>_boldref.nii.gz
	        # Bold参考像
	        sub-<label>_[specifiers]_space-<space_label>_desc-brain_mask.nii.gz
	        # Mask
	        sub-<label>_[specifiers]_space-<space_label>_desc-preproc_bold.nii.gz
	        # 预处理完的Bold图像
	        
    		sub-<label>_[specifiers]_desc-confounds_timeseries.tsv
    		sub-<label>_[specifiers]_desc-confounds_timeseries.json
    		# 每个Bold图像都有一个Confounds文件生成
  	
  	sub-<label>.html
  	# 主要描述原始图像信息，所做的处理，中间结果图像可视化，是否报错等
  	# 也用来检查被试处理过程中剥脑、分割、配准、表面重建等步骤是否有异常。
  	
  	dataset_description.json
  	.bidsignore
```

