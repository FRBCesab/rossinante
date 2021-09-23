Installation
============

|admin|

.. |admin| image:: https://img.shields.io/static/v1?label=-&message=Admin%20only&color=red&logo=ubuntu&style=flat-square

-----

Disk partitioning
-----------------


.. table:: **Table 1** -- Rossinante disks partitioning
  :align: center
  :width: 100%

  +-----------------------------------+--------+---------------+
  | Storage virtualization technology |  Space | Path          |
  +===================================+========+===============+
  |                                   | 512 Mo | ``/boot/efi`` |
  +                                   +--------+---------------+
  |             RAID 1                |   8 Go | ``swap``      |
  +                                   +--------+---------------+
  |                                   | 438 Go | ``/``         |
  +-----------------------------------+--------+---------------+
  |             RAID 5                |   6 To | ``/home``     |
  +-----------------------------------+--------+---------------+


|


System update
-------------



.. code-block:: shell

  ## Update System ----

  $ sudo apt update && sudo apt full-upgrade
  $ sudo apt autoremove && sudo apt autoclean

|

Network
-------



Tutorials:
  - https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/
  - https://linuxize.com/post/how-to-set-dns-nameservers-on-ubuntu-18-04/
  - https://www.privacyguides.org/providers/dns/
  - https://libredns.gr/

-----


.. code-block:: shell

  ## Identify Ethernet Interfaces ----

  $ ip link


  ## Set Network parameters ----

  $ sudo cat << EOF > /etc/netplan/00-installer-config.yaml
  network:
    version: 2
    renderer: networkd
    ethernets:
      eno1np0:
        dhcp4: no
        addresses:
          - 192.168.0.42/24
        gateway4: 192.168.0.254
        nameservers:
          addresses: [116.202.176.26,208.91.112.52,208.91.112.53]
  EOF


  ## Apply changes ----

  $ sudo netplan apply


  ## Check ----

  $ ip addr show dev eno1np0


|


NVIDIA driver
-------------


Tutorial:
  - https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux

-----



.. code-block:: shell

  ## Install utilities ----

  $ sudo apt install ubuntu-drivers-common


  ## Detect NVIDIA card ----

  $ ubuntu-drivers devices


  ## Install recommended driver ----

  $ sudo apt install --no-install-recommends nvidia-driver-470

  $ sudo reboot

**NB --** It's recommended to install the driver from Ubuntu repository.
The option ``--no-install-recommends`` avoids to install ``gnome-shell``.


|


OpenSSH server
--------------


.. code-block:: shell

  ## Install SSH server ----

  $ sudo apt install openssh-server


  ## Backup original config file ----

  $ sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original


  ## Edit config file ----

  $ sudo nano /etc/ssh/sshd_config



Let's change the following parameters in the ``sshd_config`` file.

.. code-block:: shell

  Port 2222
  LoginGraceTime 30s
  MaxAuthTries 6
  PermitRootLogin no
  PermitEmptyPasswords no
  PubkeyAuthentication yes
  AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2
  AllowGroups sshlogin


Let's create a new Linux group ``sshlogin``. Only users who are members of this
group can connect to the server via the SSH protocol.

.. code-block:: shell

  ## Create new Linux group ----

  $ sudo groupadd sshlogin
  $ sudo usermod -aG sshlogin dquichotte



Apply new SSH config.

.. code-block:: shell

  ## Apply changes ----

  $ sudo service ssh restart


|


Create Linux users
------------------

First let's change some default parameters of the create user system. We will
increase privacy of user personal directory in such manner that only the user
and its primary group can access to this content.

.. code-block:: shell

  ## Backup original config file ----

  $ sudo cp /etc/adduser.conf /etc/adduser.conf.original


  ## Edit adduser config file ----

  $ sudo nano /etc/adduser.conf



Let's change the following parameters in the ``adduser.conf`` file.

.. code-block:: shell

  DIR_MODE=0750                                ## Personal directory permissions



Finally let's create the user ``psmith``.


.. code-block:: shell

  ## Create new user ----

  $ sudo adduser psmith                        ## Create new user 'psmith'
  $ sudo passwd -e psmith                      ## 'psmith' needs to change its password at first login


.. code-block:: shell

  ## Add 'psmith' to the group 'sshlogin' ----

  $ sudo usermod -aG sshlogin psmith


|


Softwares installation
----------------------



Utilities
~~~~~~~~~



.. code-block:: shell

  ## Utilities installation ----

  $ sudo apt update

  $ sudo apt install  \
      build-essential \                ## Tools for compiling software
      fail2ban        \                ## Intrusion prevention software
      ffmpeg          \                ## Tools for transcoding multimedia files
      git             \                ## Revision control system
      imagemagick     \                ## Image manipulation program
      nvtop           \                ## GPU monitor
      tree            \                ## Displays an indented directory tree
      tldr            \                ## Haskell tldr client
      unzip           \                ## De-archiver for .zip files
      zip             \                ## Archiver for .zip files
      zsh                              ## Shell with lots of feature



R and RStudio Server
~~~~~~~~~~~~~~~~~~~~



Tutorials:
  * https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/
  * https://rtask.thinkr.fr/fr/installation-de-r-4-0-sur-ubuntu-20-04-lts-et-astuces-pour-les-packages-de-cartographie/



.. code-block:: shell

  ## Add GPG keys ----

  $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9


  ## Add the R 4.0 repository from CRAN ----

  $ sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'


  ## Update packages list ----

  $ sudo apt update


  ## Install R ----

  $ sudo apt install r-base r-base-dev


  ## Install system libraries ----

  $ sudo apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev
  $ sudo apt install libnode-dev libcairo2-dev libnetcdf-dev
  $ sudo apt install libmagick++-dev libpoppler-cpp-dev libgmp3-dev


  ## Install LaTeX and Pandoc ----

  $ sudo apt install pandoc pandoc-citeproc texlive-full



RStudio Server
^^^^^^^^^^^^^^


.. code-block:: shell

  ## Install RStudio Server ----

  $ sudo apt install gdebi-core
  $ wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb

  $ sudo gdebi rstudio-server-1.4.1717-amd64.deb
  $ rm rstudio-server-1.4.1717-amd64.deb


Let's configure RStudio Server.

.. code-block:: shell

  ## Edit server config file ----

  $ sudo nano /etc/rstudio/rserver.conf


Let's add the following line:

.. code-block:: shell

  www-port=8787
  # www-address=127.0.0.1                     ## Replace by VPN address


Apply changes.

.. code-block:: shell

  $ sudo rstudio-server restart


Let's configure users sessions.

.. code-block:: shell

  ## Edit server config file ----

  $ sudo nano /etc/rstudio/rsession.conf


Let's add the following option (no limit).

.. code-block:: shell

  session-timeout-minutes=0


|



Python and Miniconda
~~~~~~~~~~~~~~~~~~~~


.. code-block:: shell

  ## Python utilities ----

  $ sudo apt install python3-pip python3-venv python3-sphinx python3-dev


  ## Download MiniConda installer ----

  $ wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh


  ## Check integrity with SHA-256 ----

  $ sha256sum Miniconda3-py39_4.10.3-Linux-x86_64.sh


  ## Install MiniConda ----

  $ sudo sh Miniconda3-py39_4.10.3-Linux-x86_64.sh  # !!! Location: /opt/miniconda3


  ## Create a conda group ----

  $ sudo addgroup conda


  ## Change group binaries owner ----

  $ sudo chgrp -R conda /opt/miniconda3


  ## Change permissions ----

  $ sudo chmod 770 -R /opt/miniconda3


  ## Add user to conda group ----

  $ sudo usermod -aG conda psmith


  ## Add conda binaries to path ---

  $ sudo echo "PATH=$PATH:/opt/miniconda3/bin" >> /etc/profile
  $ sudo echo "PATH=$PATH:/opt/miniconda3/bin" >> /etc/zsh/zprofile


  ## Create global config file ----

  $ sudo touch /opt/miniconda3/.condarc
  $ sudo chown root:conda /opt/miniconda3/.condarc


  ## Cleanup ----

  $ rm Miniconda3-py39_4.10.3-Linux-x86_64.sh

  # >>> Logout

  ## Remove (base) from prompt ----

  $ conda config --set auto_activate_base false




.. code-block:: shell

  ## Install Python packages ----

  $ conda install jupyter scipy matplotlib numpy requests keras pytorch pandas statsmodels
  $ conda install scikit-learn scikit-learn-intelex bokeh seaborn plotly future

  $ conda install -c r r-irkernel    # R in Jupyter Notebook

  $ conda install -c conda-forge jupyterlab



Julia
~~~~~


.. code-block:: shell

  ## Download compressed binaries ----

  $ wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.2-linux-x86_64.tar.gz


  ## Extract binaries ----

  $ tar -xvzf julia-1.6.2-linux-x86_64.tar.gz


  ## Copy binaries to /opt/ folder (third-party applications directory) ----

  $ sudo cp -r julia-1.6.2 /opt/


  ## Create symbolic link to julia inside the /usr/local/bin folder ----

  $ sudo ln -s /opt/julia-1.6.2/bin/julia /usr/local/bin/julia


  ## Cleanup ----

  $ rm -f julia-1.6.2-linux-x86_64.tar.gz
  $ rm -rf julia-1.6.2


.. code-block:: julia

  ## Add Julia to Jupyter Notebook ----

  julia> using Pkg
  julia> Pkg.add("IJulia")
  julia> exit()


Docker
~~~~~~


.. code-block:: shell

  ## Install tools ----

  $ sudo apt install apt-transport-https ca-certificates software-properties-common


  ## Add GPG key ----

  $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


  ## Add Docker repository ----

  $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  $ sudo apt update

  $ sudo apt install docker-ce docker-compose


  ## Check daemon ----

  $ sudo systemctl status docker


  ## Use Docker without sudo ----

  $ sudo usermod -aG docker psmith


|

CUDA and cuDNN
--------------

CUDA Toolkit 11.4
~~~~~~~~~~~~~~~~~

Source: https://developer.nvidia.com/cuda-downloads

.. code-block:: shell

  ## Install CUDA Toolkit 11.4 ----

  $ wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin

  $ sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

  $ wget https://developer.download.nvidia.com/compute/cuda/11.4.2/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb

  $ sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
  $ sudo apt-key add /var/cuda-repo-ubuntu2004-11-4-local/7fa2af80.pub
  $ sudo apt update
  $ sudo apt install cuda



cuDNN 8.2
~~~~~~~~~

Visit the page: https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html,
and download from a web browser on local device (login required):

* cuDNN Library for Linux (x86_64)
* cuDNN Runtime Library for Ubuntu20.04 x86_64 (Deb)
* cuDNN Developer Library for Ubuntu20.04 x86_64 (Deb)
* cuDNN Code Samples and User Guide for Ubuntu20.04 x86_64 (Deb)

Then send these files through SSH to Rossinante:

.. code-block:: shell

  $ scp cudnn-11.4-linux-x64-v8.2.4.15.tgz rossinante:~/
  $ scp libcudnn8* rossinante:~/


On Rossinante:

.. code-block:: shell


  ## Install cuDNN ----

  $ tar -xzvf cudnn-11.4-linux-x64-v8.2.4.15.tgz

  $ sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
  $ sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64

  $ sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

  $ sudo dpkg -i libcudnn8_2.4.15-1+cuda11.4_amd64.deb
  $ sudo dpkg -i libcudnn8-dev_8.2.4.15-1+cuda11.4_amd64.deb
  $ sudo dpkg -i libcudnn8-samples_8.2.4.15-1+cuda11.4_amd64.deb

  $ sudo apt install libfreeimage3 libfreeimage-dev


  ## Check install ----

  $ cp -r /usr/src/cudnn_samples_v8/ $HOME
  $ cd $HOME/cudnn_samples_v8/mnistCUDNN

  $ make clean && make
  $ ./mnistCUDNN


  ## Cleanup ----

  rm libcudnn8*
  rm cudnn-11.4-linux-x64-v8.2.4.15.tgz
  rm -rf cudnn_samples_v8
  rm -rf cuda
