
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
Both pre-defined system parameters and automatic detection function and utilities are described. The first subsection is listed for research purposes with some system parameters shown in variable location and variable name allowing easier tunning process. Then usages of automatic detection function and utilities are covered for implementations.
#### Pre-defined system parameters
Parameter Description | Variable Location    | Variable Name
----  | ----------------- | ----------
number of windows in *TestBuffer* | /functions/main/FD_analysis.m | KK
data scaling parameter  | /functions/main/FD_analysis.m | ds
Initial *u* value before search  | /functions/main/threshold2.m | c
non spike ratio *R* thresholds | /functions/main/ratiojudge.m| -
exponential search base number   | /functions/main/StateTrans.m| searchD
number of linear scanning intervals  | /functions/main/StateTrans.m | IndMax
ratio value for judging *C_1, C_2* conditions | /functions/main/SCSASpikeDetect.m| ThK, ThN
SCSA *C_1 , C_2* conditions thesholds  | /functions/main/SCSASpikeDetect.m | Ts1, Ts2
maximum sample length in a region |esRegionsExtract.m | NL
number of channels in data |esRegionsExtract.m| chan_index

#### Automatic detection function and utilities
This section provides implementation of **algorithm 3** in our paper. You can get extracted regions *R_F* from an input MEG/EEG patient data D (D is matrix with each row containing channel waveforms) simply by running the following command.
```matlab
[R_F] = esRegionsExtract(D)
```
> Note: Computing time for this function depends on
the length of the data. For instance, with a sampling frequency
of 500, it typically takes several minutes to analyze input with 
1-5 minutes of patient data, while it can take several hours to 
analyze the input with 15-30 minutes of patient data.
This non-linear increase in computing time lies in the threshold selection
since longer data will involve more efforts in computing FD threshold. 
Empirically, it is recommended to keep the patient data at around 15 minutes to 
achieve maximum performance.


#### Utilities
To perform comparisons or the algorithm modules independently, use the following functions with the specifications:

|     Utilities    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **`FD`**   | Our main C-SCSA implementation. It is the entry point into the denoising algorithm, capable of taking any noisy signal as input (signals with 300-10000 samples are recommended for computing time perspectives). To peform denoising, simply use `[ yscsa,mse,snr ,psnr] = SCSAden( yf,yf0,v )` **function Input**: `v` is a smoothness parameter related to eq. (11) in our [paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023). `yf` is the noisy signal and `yf0` is the clean signal, with possible values between (-5,5). `v` varies with input signal types, signal length and sampling frequencies.  **function Output**: `yscsa` is the denoised signal. `snr` and `mse` is the SNR and mean squared error (MSE) of the denoised signal for evaluation purposes. **In the case where clean signal is not available**, use `[ yscsa] = SCSAden( yf,yf,v )` to get the denoised signal.|
|  **`P-SCSA`**   | Usage to be updated soon!|
|   `Fast`    | C-SCSA fast version. We are currenlty using _fminsearch_ to speed up the searching process in eq. (10) in our [paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023), which uses the simplex search method of [Lagarias et al](https://www.researchgate.net/publication/216301003_Convergence_Properties_of_the_Nelder--Mead_Simplex_Method_in_Low_Dimensions). This version is currently in the research process and not available in the repository. |
|  `h_Select`   | Optimal `h` selection for denoising. This function is for testing purposes. Users will be able to extract the optimal `h` that bestly denoise a noisy signal `yf` by running:`[ de,h_optimal,snr ] = SCSA_H_Select( yf,yf0 )`. **function Input**:  `yf` is the noisy signal and `yf0` is the clean signal. **function Output**: `de` is the denoised signal. `h_optimal` is the `h` that provides the best denoising performance and `snr` is the highest SNR that SCSA method can achieve.                                                                                                                                                                                                                                                        |
|  `Assembly`   | Denoise signal by separating whole signal into regions of interest and apply C-SCSA on each. This module is currently in its testing stages and is not available in the repository.                                                                                                                                                                                                                                                          |
|  `Others`   | Other methods reconstruction are also available. [EMD-IT](https://www.sciencedirect.com/science/article/pii/S0165168414005027) can be implemented by `[ de,mse,snr ,psnr] = emd_den( yf,yf0,c,k)` and [wavelet denoising](https://www.sciencedirect.com/science/article/pii/S1051200405001703) can be implemented by `[de, mse,snr,psnr ] = wa( yf,yf0 )`                                                                                                                                                                                                                                                        |
|   `SCSA`    | SCSA reconstruction. Users can decompose the signal with a positive `h` value, by `[yscsa,Nh,EigV,EigF] = scsa_build(h,y)`. **function Input**: `h` is a positive value, also known as the [SCSA](https://link.springer.com/content/pdf/10.1007/s00498-012-0091-1.pdf) semi-classical constant. It can be selected by [Quantum-based interval selection](https://ieeexplore.ieee.org/abstract/document/9287878). `y` is the input signal to be decomposed.  **function Output**: `yscsa` is the decomposed signal, `Nh` is the number of eigenfunctions. `EigV` is a matrix with eigenvalues on its diagonal (you can export the eigenvalues by `diag(EigV)`. `EigF` is the matrix of eigenfunctions. [UI interface](https://github.com/EMANG-KAUST/SCSA-reconstruction) of this tool is also available. |


### License

The application library (i.e. all code inside of the `functions` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
