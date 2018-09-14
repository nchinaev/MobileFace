This repository features code for 3D face reconstruction accuracy evaluation. We hope to provide an automated benchmark 
for researchers in the area of 3D face reconstruction.

Method and formulas for evaluation are detailed in paper 'MobileFace: 3D Face Reconstruction with Efficient CNN Regression' presented at [PeopleCap 2018](https://peoplecap2018.weebly.com/), an ECCV workshop on capturing and modeling human bodies, faces and hands.

# Paper

[[pdf]](https://github.com/nchinaev/MobileFace/blob/master/MobileFace_3D_Face_Reconstruction_Chinaev_Chigorin_Laptev.pdf)

@InProceedings{Chinaev2018MobileFace,<br />
author = {Chinaev, Nikolai and Chigorin, Alexander and Laptev, Ivan},<br />
title = {MobileFace: 3D Face Reconstruction with Efficient CNN Regression},<br />
booktitle = {European Conference on Computer Vision (ECCV) Workshops},<br />
month = {Sep},<br />
year = {2018}<br />
}

# Evaluation

The evaluation is performed on a subset of BU4DFE. The subset is divided into two splits: validation and test, 2989 scans in total. 

The two splits are defined as lists of images stored in `data/val_list.txt` and `data/test_list.txt`. Filenames in these two files reflect paths to the images in BU4DFE dataset. For example, F002_Angry_000_3d.jpg -> F002/Angry/000.jpg

The code allows to test the accuracy of 3D models reconstructed for these images.

Access to BU4DFE dataset is needed in order to run this code.

### Setup
- In folder data create subfolders `scans`, `indices`, `csv`, `scans_cropped`.
- Unpack files listed in data/wrl_files_list.txt into data/scans, rename them as in F001/Angry/036.wrl -> F001_Angry_036_3d.wrl
- Unpack [indices](https://drive.google.com/file/d/1iGfE4kHmTsHZ_ogVoYiPPJUhBplksLfc/view?usp=sharing) into data/indices
- Unpack [csv files](https://drive.google.com/file/d/1HJSQSQGSggebYBCeIn_IpQBe4EjrNXSV/view?usp=sharing) into data/csv
- run `transformWrl.py`
- run `cropScans.m`

### Usage 

Run `compareBu4dfeMeshes.m`, follow instructions from this file.
