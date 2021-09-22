Introduction
============

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----


This tutorial presents how to use the FRB-CESAB server **Rossinante**, dedicated
to *medium* performance scientific computing (Table 1). You can run programs
implemented in R, Python, Julia, C, and C++ directly from a terminal or using
Web clients like RStudio Server and Jupyter Notebook. Unlike traditional clusters,
Rossinante does not have a job scheduling system (e.g. SLURM, Torque) meaning
that you can launch jobs whenever you want. But only if there is cores and
RAM available (see :ref:`good-practices` section).


.. table:: **Table 1** -- Rossinante hardware specifications
  :align: center
  :width: 100%

  +--------------+------------------------------------------------------+
  | **Hardware** | **Specifications**                                   |
  +==============+======================================================+
  | CPU          | 2 x Intel Xeon Gold 5218R -- ``80 threads``          |
  +--------------+------------------------------------------------------+
  | RAM          | 12 x Cells 32 Go RDIMM -- ``384 GB``                 |
  +--------------+------------------------------------------------------+
  | Storage      | 8 x 960 GB SSD SATA -- ``6 TB``                      |
  +--------------+------------------------------------------------------+
  | GPU          | NVIDIA Quadro RTX 6000                               |
  +--------------+------------------------------------------------------+
  | OS           | Ubuntu Server 20.04 LTS (Focal Fossa)                |
  +--------------+------------------------------------------------------+

|

When do you need to use Rossinante?
  * You need to analyse large datasets (RAM operations), and/or,
  * You need to repeat tasks many times (parallelization on CPU/GPU).


What are the available software?
  * `R 4.1 <https://cran.r-project.org/>`_
  * `RStudio Server <https://www.rstudio.com/products/rstudio/download-server/>`_
  * `Python 3.9 <https://www.python.org/>`_
  * `pip <https://pip.pypa.io/>`_ and `Conda <https://docs.conda.io/en/latest/>`_ -- Python packages managers
  * `Jupyter Notebook <https://jupyter-notebook.readthedocs.io/>`_ and `JupyterLab <https://jupyterlab.readthedocs.io/>`_
  * `Julia 1.6 <https://julialang.org/>`_
  * `LaTeX3 <https://www.latex-project.org/>`_
  * `Pandoc <https://pandoc.org/>`_
  * `git <https://git-scm.com/>`_



And some useful utilities:
  * `CUDA 11.4 <https://developer.nvidia.com/cuda-downloads>`_ and `NVIDIA cuDNN 8.1 <https://developer.nvidia.com/cudnn>`_ -- Deep Learning
  * `FFmpeg <https://ffmpeg.org/>`_ -- Transcoding multimedia files
  * `ImageMagick <https://imagemagick.org>`_ -- Image manipulation program
  * `Poppler <https://poppler.freedesktop.org/>`_ -- PDF utility library
  *  `GDAL <https://gdal.org/>`_, `GEOS <https://trac.osgeo.org/geos>`_, `PROJ <https://proj.org/>`_ -- Spatial libraries
  * `htop <https://htop.dev/>`_ -- CPU, RAM, and processes monitoring tool
  * `nvtop <https://github.com/Syllo/nvtop>`_ -- NVIDIA GPU monitoring tool
  * `nano <https://www.nano-editor.org/>`_ and `vim <https://www.vim.org/>`_ -- CLI text editors
  * `screen <https://www.gnu.org/software/screen/>`_ and `tmux <https://github.com/tmux/tmux/wiki>`_ -- Terminal multiplexers
  * `tree <http://mama.indstate.edu/users/ice/tree/>`_ -- Recursive directory listing program
  * `curl <https://curl.se/>`_ and `wget <https://www.gnu.org/software/wget/manual/wget.html>`_ -- Download managers
  * `zip <https://linuxize.com/post/how-to-zip-files-and-directories-in-linux/>`_ and `unzip <https://linuxize.com/post/how-to-unzip-files-in-linux/>`_ -- ZIP files managers

|

Can you do what you want on Rossinante?
  No! Rossinante has only one administrator, Nicolas Casajus. Regular users,
  like you, have only access to a personal directory, ``/home/you/`` and to a shared
  directory ``/home/cesab/``. You can store your files in one of these two folders.
  But keep in mind that only you have access to your personal space whereas
  everybody can access the shared space.


  If you need to use a non-installed software, please contact the administrator.
  Note that each user has a personal R library in which he can install every
  R packages he wants (independently of other users). For Python, packages are
  shared among all users (except if you work with virtual environments [recommended]).





**Important --** Rossinante is **not a storage server**. Its 6 TB storage are shared
among all users. You can store large datasets on your personal space to run yours
analyses, but once you've finished, please remove large files.
