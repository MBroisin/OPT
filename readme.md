# README

## General

This repository contains the code to perform reconstruction of 3D images from OPT projections. The tree is structured as follows :


* OPT2019
    * ForwardModel
        * tests to use the forward model
        * functions
            * useful functions for the forward model
        * ...
    * Reconstruction
        * tests to use the reconstruction
        * functions
            * useful functions for the reconstruction
        * ...
    * ```CreateArtificialImage.m```
            

This repo does not contain any data, but ```CreateArtificialImage.m``` can help building an image that can be used to see the effect of OPT and the reconstruction. A complete example of the use is provided, and the different tests may help to understand how to take benefits from this repository.


## References

These codes are based on several papers including :


Trull, A. K., van der Horst, J., van Vliet, L. J., & Kalkman, J. (2018). Comparison of image reconstruction techniques for optical projection tomography. Applied optics, 57(8), 1874-1882. ([Paper link](https://www.osapublishing.org/ao/abstract.cfm?uri=ao-57-8-1874))


Trull, A. K., van der Horst, J., Palenstijn, W. J., van Vliet, L. J., van Leeuwen, T., & Kalkman, J. (2017). Point spread function based image reconstruction in optical projection tomography. Physics in Medicine & Biology, 62(19), 7784. ([Paper link](https://iopscience.iop.org/article/10.1088/1361-6560/aa8945/meta))


## Help and properties

This repository is provided by the Biomedical Imaging Group ([BIG](http://bigwww.epfl.ch/)) of EPFL. If you have any questions or remarks, please do not hesitate to reach me on matthieu.broisin@epfl.ch .