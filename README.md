
<h1 align="center">Automatic Epilepsy Spike Detection</h1>

<p align="center">
  <a href="https://ieeexplore.ieee.org/document/9374974">
    <img src="https://img.shields.io/badge/paper-IEEE%20Access-brightgreen">
  </a>  <a href="https://ieeexplore.ieee.org/abstract/document/9631028">
    <img src="https://img.shields.io/badge/paper-EMBC2021-orange">
</a>   <a href="https://www.gnu.org/licenses/gpl-3.0.en.html">
<img src="https://img.shields.io/badge/license-GPL--3.0--or--later-blue">
  </a>  
</p>

<p align="center">
  <a href="#Dataset">Dataset</a> •
  <a href="#environment">Environment</a> •
  <a href="#download">Download</a> •
  <a href="#how-to-run">How to Run</a>  •
  <a href="#license">License</a>
</p>

Algorithm diagram            |  Sample Epilepsy Spikes
:-------------------------:|:-------------------------:
![1](https://github.com/EMANG-KAUST/Automatic-epilepsy-spike-detection-/blob/main/img/1.png)  |  ![2](https://github.com/EMANG-KAUST/Automatic-epilepsy-spike-detection-/blob/main/img/2.png)


## Dataset
Project team is currently considering the [UCI machine learning repository](https://archive.ics.uci.edu/ml/index.php), once dataset is uploaded users can export MEG/EEG data from the updated link. Each patient data contains the following elements.
- `data` (A Matrix element with each row containing waveform of a specific channel. )
- `events` (A struct element with *M* spike label imformation)
                                                                            
    Field | Data Types    | Value
    ----  | ----------------- | ----------
    label  | string | "spikes"
    times  | array (double)| M doubles
    samples  | array (double) | M doubles
                                                                            
- `smpfreq` (A integer element with sampling frequency)
- `chantype` (An array element with each array element showing data type of the corresponding row in *data* element)
- `channame` (An array element with each array eleemnt showing channel type of the corresponding type in *chantype* elements)
    > Note: For EEG data, the channel waveform is 
    the difference of voltage between the *electrode* 
    and the *ground*, with the type of electrode shown 
    in *channame* variable. EEG waveform can be generated 
    by substracting two data waveforms thus eliminating 
    the ground voltage. More basics about EEG signal can be 
    found in this [tutorial](https://www.youtube.com/watch?v=XMizSSOejg0).

## Environment

Our application is developed in Matlab 2020a. An equaling or higher version is recommended and no other dependencies are needed to implement our method. To implement other methods and utilities, it is recommended to install the following Matlab toolbox:

- [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)
- [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/deep-learning.html)
## Download

This application can be downloaded by built-in [git](https://www.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html) tool in Matlab.
![screenshot](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/2.gif)

## How to Run

The repo provides a wide variety of methods and utilities which can help researchers to study epilepsy spike detection methods. Both detection methods and feature extraction methods in existing literature publications are provided.
### Table of content
              
- Our method
    - Pre-defined system parameters
    - Automatic detection function 
    - Utilities

### Our method 
This section provides implementation of algorithm 3 in our paper. Both pre-defined system parameters and automatic detection function and utilities are described. The first subsection is listed for research purposes with some system parameters shown in variable location and variable name for easier tunning process. Then usages of automatic detection function and utilities are covered for implementations.
#### Pre-defined system parameters
Parameter Description | Variable Location    | Variable Name
----  | ----------------- | ----------
number of windows in *TestBuffer* | /functions/main/FD_analysis.m | KK
data scaling parameter  | /functions/main/FD_analysis.m | ds
Initial $u$ value before search  | /functions/main/threshold2.m | c
non spike ratio *R* thresholds | /functions/main/ratiojudge.m| -
exponential search base number   | /functions/main/StateTrans.m| searchD
number of linear scanning intervals  | /functions/main/StateTrans.m | IndMax
ratio value for judging *C_1, C_2* conditions | /functions/main/SCSASpikeDetect.m| ThK, ThN
SCSA *C_1 , C_2* conditions thesholds  | /functions/main/SCSASpikeDetect.m | Ts1, Ts2
maximum sample length in a region |- | -

#### Automatic detection function and utilities
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
