
<h1 align="center">Automatic Epilepsy Spike Detection</h1>

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

Algorithm diagram            |  Sample Epilepsy Spikes
:-------------------------:|:-------------------------:
![1](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/51.png)  |  ![2](https://github.com/EMANG-KAUST/CentralPressure_PPG/blob/main/img/1.gif)


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
