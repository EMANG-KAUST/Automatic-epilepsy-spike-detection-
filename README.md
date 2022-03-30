
<h1 align="center">Cuffless Blood Pressure Estimation Algorithm Built on <a href="https://link.springer.com/article/10.1007/s00498-012-0091-1" target="_blank">SCSA</a></h1>

<p align="center">
  <a href="https://ieeexplore.ieee.org/document/9374974">
    <img src="https://img.shields.io/badge/paper-IEEE%20Access-brightgreen">
  </a>  <a href="https://ieeexplore.ieee.org/document/9176849">
    <img src="https://img.shields.io/badge/paper-EMBC2020-orange">
  </a>
  </a>  
</p>

<p align="center">
  <a href="#Dataset">Dataset</a> •
  <a href="#environment">Environment</a> •
  <a href="#download">Download</a> •
  <a href="#how-to-run">How to Run</a>  •
  <a href="#license">License</a>
</p>

Algorithm diagram            |  Real-time implementation
:-------------------------:|:-------------------------:
![1](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/51.png)  |  ![2](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/1.gif)


## Dataset
The Physionet’s <a href="https://archive.physionet.org/mimic2/" target="_blank">Multiparameter Intelligent Monitoring in Intensive Care (MIMIC II)</a> online waveform database is used for accuracy analysis.
 
* The data set is in matlab's v7.3 mat file, accordingly it should be opened using new versions of matlab or HDF libraries in other environments (Please refer to <a href="https://archive.ics.uci.edu/ml/datasets/Cuff-Less+Blood+Pressure+Estimation">this site</a> for more information about this format)
* This database consist of a cell array of matrices, each cell is one record part. In each matrix each row corresponds to one signal channel:
  - PPG signal, FS=125Hz; photoplethysmograph from fingertip 
  - ABP signal, FS=125Hz; invasive arterial blood pressure (mmHg) 
  - ECG signal, FS=125Hz; electrocardiogram from channel II
* Number of Patients: 12000
* Associated Tasks: Blood pressure regression
* Sampling Frequency: 125Hz
* Precision: 8 bits
* Citation Source: If you use this dataset, please refer [this paper](https://www.semanticscholar.org/paper/Cuff-less-high-accuracy-calibration-free-blood-time-Kachuee-Kiani/756f12f5495be3717a691a6073642733f6b1a8a3)

## Environment

The original source is developed in Matlab 2016a. An equaling or higher version is recommended. This application uses the following Matlab toolbox:

- [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)
- [Deep Learning Toolbox](https://www.mathworks.com/products/deep-learning.html)
## Download

This application can be downloaded by built-in [git](https://www.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html) tool in Matlab.
![screenshot](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/2.gif)

## How to Run

The application provides interfaces which can help researchers to extract feature vectors using SCSA method. Network training and prediction interfaces are also provided.

### Extract SCSA feature set 
You can extract a SCSA feature vector from a certain PPG segment (i.e. a heart beat interval) with the following command.
```matlab
[featureS] = SegmentExtract(PPGSegment)
```
### Train feed-forward neural network (FFNN)
The application utilizes a FFNN structure for SBP and DBP estimation.
![screenshot2](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/ffnn1.png)
Once feature sets are generated, with `size(Traindata)=length(featureVector),num(samples)`,`size(SBPTarget)=1,num(samples)`and `size(DBPTarget)=1,num(samples)`, you can train the neural network with the following command.
```matlab
[netS,netD] = ModelGen(Traindata,SBPTarget,DBPTarget)
```
### Predict BP with trained network
With `netS` and `netD`, one can predict SBP and DBP by:
```matlab
[SBPestimate] = netS(featureS)
```
and
```matlab
[DBPestimate] = netD(featureS)
```

### License

The application library (i.e. all code inside of the `functions` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
