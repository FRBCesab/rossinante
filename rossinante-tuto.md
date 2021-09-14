---
title: |
  Rossinante -- User guide\vspace{4cm}
  ![](images/quichotte.jpg)\vspace{2cm}
author: Nicolas Casajus
date: |
  September 14, 2021
  \newpage
output:
  pdf_document:
    latex_engine: xelatex
    toc: true
    number_sections: true
    highlight: zenburn
geometry: margin=2.5cm
papersize: a4
links-as-notes: false
header-includes: |
  \usepackage{titlesec}
  \titlespacing{\section}{0pt}{0.85cm}{0.50cm}
  \titlespacing{\subsection}{0pt}{0.75cm}{0.50cm}
  \usepackage{setspace}
  \singlespacing
---



\newpage



# Introduction {-}



This tutorial presents how to use the FRB-CESAB server **Rossinante**, dedicated 
to medium performance scientific computing (Table 1). You can run programs coded
in R, Python, Julia, C, and C++. Unlike traditional clusters, Rossinante
does not have a job scheduling system (e.g. SLURM) meaning that you can launch
jobs when you want (only if the server is available, see below the 
**Good practices** section).




| **Hardware** | **Specifications**                               |
|--------------|--------------------------------------------------|
| CPU          | 2 x Intel Xeon Gold 5218R (total 80 threads)     |
| RAM          | 12 x Cells 32 Go RDIMM (total 384 GB)            |
| Storage      | 8 x 960 GB SSD SATA (total 6.1 TB)               |
| GPU          | NVIDIA Quadro RTX 6000                           |
| OS           | Ubuntu Server 20.04 LTS (Focal Fossa)            |
:Rossinante hardware specifications



**When do you need to use Rossinante?** 

- You need to analyse large datasets (RAM operations), and/or,
- you need to repeat tasks many times (parallelization on CPU/GPU).



\vspace{0.45cm}



**What are the available software?** 

- R 4.1 (and RStudio Server 1.4)
- Python 3.8 (and its development environment)
- Julia 1.6
- LaTeX 3.14 and Pandoc 2.5
- git 2.25
- FFmpeg (transcoding multimedia files)
- ImageMagick (image manipulation program)
- Poppler (utility library for PDF)
- Spatial tools (GDAL, GEOS, PROJ4)

And some useful utilities:

- `htop`: CPU and RAM monitoring tool
- `nvtop`: NVIDIA GPU monitoring tool
- `nano`, `vi`, and `vim`: text editors
- `screen` and `tmux`: terminal multiplexers
- `tree`: recursive directory listing program
- `curl` and `wget`: download managers
- `zip` and `unzip`: ZIP files managers



\vspace{0.45cm}



**Can you do what you want on Rossinante?**

No! Rossinante has only one administrator, Nicolas Casajus[^0]. Regular users, 
like you, have only access to a personal directory, `/home/you/` and to a shared
directory `/home/cesab/`. You can store your files in one of these two folders. 
But keep in mind that only you have access to your personal space whereas 
everybody can access the shared space.

[^0]: nicolas[dot]casajus[at]fondationbiodiversite[dot]fr


\vspace{0.45cm}


**Important --** Rossinante is **not a storage server**. Its 6 TB storage are shared
among all users. You can store large datasets on your personal space to run yours
analyses, but once you've finished, please remove your data.


\vspace{0.45cm}


If you need to use a non-installed software, please contact the administrator. 
Note that each user has a personal R library in which he can install every
R package he wants (independently of other users).



# First steps

When you connect to Rossinante for the first time, you'll be asked to change 
your password. This first connection is made under the SSH protocol (Secure 
Shell). This protocol is a cryptographic network protocol that allows you to 
securely access a remote computer over an unsecured network.


\vspace{0.45cm}


For this tutorial, let's say:

- your name is `Jane DOE`
- your username on your laptop is `jane`
- your laptop name is `laptop`
- your username on Rossinante is `jdoe`
- the public IP address[^1] of Rossinante is `92.168.45.3`
- the port of the SSH server is `22`



## SSH connection



To open an SSH connection on Unix-based OS (macOS and Linux)[^2], open a Terminal
session and run:

[^1]: When you are inside the CESAB, you can use the local IP address of the
server.

[^2]: On Windows, open the PowerShell and run the same command.


```sh
# SSH connection to Rossinante ----
jane@laptop:~$ ssh -p 22 jdoe@92.168.45.3
```

**N.B.** `jane@laptop:~$` is the prompt of an Unix terminal. On Windows, it looks
like `C:\Users\jdoe>`


\vspace{0.45cm}


You'll be asked to change your password. Enter the old password and set your new
password (twice). You'll may be invited to connect a second time. Then, your 
prompt will look like:

```sh
jdoe@rossinante:~$
```

This means that you are now connected to Rossinante under the username `jdoe`. 
You can check your current directory with the command `pwd`:

```sh
# Print working (current) directory ----
jdoe@rossinante:~$ pwd
## /home/jdoe
```

To stop the SSH connection, use the command `exit` (or `logout`):

```sh
jdoe@rossinante:~$ exit
## Connection to 92.168.45.3 closed.
```




## SSH config file




It can be painful to remember the IP address and the SSH port of Rossinante,
especially if you use several servers. Fortunately you can store Rossinante
credentials (except your password) and SSH connection information in a special
file located on **your laptop** (not in the server): `~/.ssh/config`.

To create this `config` file, open a Terminal/PowerShell and follow these steps:

```sh
# Navigate to your home directory (symbolized by ~) ----
jane@laptop:~$ cd ~

# Create a new hidden folder ----
jane@laptop:~$ mkdir .ssh/

# Change folder permissions ----
# (only Jane can read, write, and execute this folder) ----
jane@laptop:~$ chmod 700 .ssh/

# Create an (empty) SSH config file ----
jane@laptop:~$ touch .ssh/config

# Change config file permissions ----
# (only Jane can read and write this file) ----
jane@laptop:~$ chmod 600 ~/.ssh/config

# Open the SSH config file with the CLI editor nano ----
jane@laptop:~$ nano ~/.ssh/config
```

Now add the follow lines in the SSH config file:

```sh
## Host rossinante
##     HostName 92.168.45.3
##     Port 22
##     User jdoe
```

To save changes press `CTRL + X` and `Y`/`O` and press `Enter`.

\vspace{0.25cm}

You can now connect to Rossinante as follow:

```sh
jane@laptop:~$ ssh rossinante
```



## Generating SSH keys



Though SSH supports password-based authentication, it is generally recommended
that you use SSH keys instead. SSH keys are a more secure method of logging into
an SSH server, because they are not vulnerable to common brute-force password
hacking attacks. Generating an SSH key pair creates two long strings of 
characters: a public and a private key. You can place the public key on any 
server, and then connect to the server using an SSH client that has access to 
the private key.

Let's create a new SSH keys pair using the cryptosystem `RSA` and a key size of
`4096` bits.

```sh
# Create a new SSH key pair ----
jane@laptop:~$ ssh-keygen -f ~/.ssh/id_rossinante -t rsa -b 4096 -C "jane.doe@mail.com"
```

If you want, you can add a passphrase to increase the security of your key pair
but each time you will connect to Rossinante you will be asked to enter it.

This SSH key pair has been stored in `~/.ssh/`.

```sh
# Content of the ~/.ssh folder ----
jane@laptop:~$ ls ~/.ssh/
## config       id_rossinante       id_rossinante.pub
```

The private key is `id_rossinante` and the public one `id_rossinante.pub`.
Nobody (except you) can have access to your private key. So we need to change
the permissions of this file.

```sh
# Change private key permissions ----
# (only Jane can read this file) ----
jane@laptop:~$ chmod 400 ~/.ssh/id_rossinante
```

On the opposite your public can be deployed everywhere. In our case, we will store
it on the Rossinante server.


```sh
# Copying public key to Rossinante ----
jane@laptop:~$ ssh-copy-id -i ~/.ssh/id_rossinante.pub rossinante
```

Now we can connect to Rossinante without entering password (except if you have
added a passphrase to your SSH key pair).

```sh
jane@laptop:~$ ssh rossinante
```

The first time you use your new SSH key pair you will see:

```sh
## The authenticity of host '[92.168.45.3]:22' can't be established.
## RSA key fingerprint is ...
## Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Just write `yes` and press `Enter`.

Our public key on Rossinante has been stored under the name `authorized_keys`.

```sh
# Content of the ~/.ssh folder ----
jdoe@rossinante:~$ ls ~/.ssh
## authorized_keys
```



## Git credentials



If you want to use **git** on Rossinante, you need to set your user name and 
email (required for commits). Run the following lines:

```sh
# Connection to Rossinante ----
jane@laptop:~$ ssh rossinante

# Set Git credentials (globally) ----
jdoe@rossinante:~$ git config --global user.name "Jane Doe"
jdoe@rossinante:~$ git config --global user.email jane.doe@mail.com
```

A `~/.gitconfig` file has been created:

```sh
# Content of the .gitconfig file ----
jdoe@rossinante:~$ cat ~/.gitconfig
## [user]
##          name = Jane Doe
##          email = jane.doe@mail.com
```


You can also define git parameters locally, i.e. specific to a project. For more
information: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup



## GitHub SSH keys



If you want to communicate with GitHub through the SSH protocol (recommended) 
you need to generate a new SSH key pair (different from the one used to connect 
to Rossinante).

Let's create a new SSH keys pair using the cryptosystem `RSA` and a key size of
`4096` bits. But this time, this SSH keys pair will be generated on Rossinante.

```sh
# Create a new SSH key pair ----
jdoe@rossinante:~$ ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C "jane.doe@mail.com"
```

**N.B.** To be detected by RStudio Server, this SSH keys pair must be named `id_rsa`.


\vspace{0.25cm}


This new SSH key pair has been stored in `~/.ssh/`.

```sh
# Content of the ~/.ssh folder ----
jdoe@rossinante:~$ ls ~/.ssh/
## authorized_keys       id_rsa       id_rsa.pub
```


\vspace{0.25cm}


Let's restrict the access to the private key.


```sh
# Change private key permissions ----
# (only jdoe can read this file) ----
jdoe@rossinante:~$ chmod 400 ~/.ssh/id_rsa
```


\vspace{0.25cm}


Now we need to store the public key on GitHub server. Go to your personal page 
on GitHub and click on **Settings**. Then click on **SSH and GPG keys**[^4] and
click on **New SSH key**.

[^4]: Or visit directly the page: https://github.com/settings/keys.



On Rossinante, print the **public** SSH key and copy it.

```sh
# Print GitHub public SSH key ----
jdoe@rossinante:~$ cat ~/.ssh/id_rsa.pub
```

On GitHub, give a title to you new SSH key (for instance, `Rossinante`) and
paste your public SSH key. Click on **Add SSH key**.

Congratulation! You can know communicate with GitHub using the SSH protocol. 
Let's test the SSH connection between Rossinante and GitHub:

```sh
# Test SSH connection between Rossinante and GitHub ----
jdoe@rossinante:~$ ssh -T git@github.com
## Hi janedoe! You've successfully authenticated!
```

\newpage

**Important --** If you lose your private SSH key you won't be able to establish
a connection with GitHub. You'll need to delete your SSH key on GitHub (i.e. 
`Rossinante`) and to create a new one.

# Sending files



When you want to run analyses on Rossinante, you need to transfer files (code 
and data) from your laptop to the server. Here we will see three methods.



## sFTP



The easiest way to transfer files from your laptop to Rossinante (or vice versa) 
is by using the sFTP protocol (Secure File Transfer Protocol). 
The **Filezilla** client (https://filezilla-project.org/) is a freeware that 
supports this protocol. You will need to define the following parameters (Fig. 1):

- Host: `sftp://92.168.45.3`
- Username: `jdoe`
- Password: your Rossinante user's password
- Port: `22`

To make the connection, click on **Quick connect**.

![Filezilla interface](images/filezilla.png){width=16cm}

The left panel (A) lists your local folders/files. The right panel (B) shows the
content of your personal directory on Rossinante. 

To send local files to Rossinante, first select the directory in B to send these
files in. Then select the files in A, right click, and click on Upload. 

To send remote files to your laptop, first select the directory in A to send these
files in. Then select the files in B, right click, and click on Download. 

\vspace{0.25cm}

**Important --** If your project is tracked by git do not use this method (
except on large files). See section 2.3.



## scp



An alternative to transfer files is by using the command `scp` that allows
to copy files using the SSH protocol.

Let's say we want to copy the local file **script.R**, located in the 
**Documents/** folder, to Rossinante (in the folder **projects/** in our
personal directory). We will use `scp` as follow:

```sh
# Send a file from local to Rossinante ----
jane@laptop:~$ scp ~/Documents/script.R rossinante:projects/
```

If we want to download a file from Rossinante:

```sh
# Send a file from Rossinante to local ----
jane@laptop:~$ scp rossinante:projects/script.R ~/Documents/
```

To copy folders we will add the option `-r` (for recursive):

```sh
# Send a folder from local to Rossinante ----
jane@laptop:~$ scp -r ~/Documents/project_1 rossinante:projects/

# Send a folder from Rossinante to local ----
jane@laptop:~$ scp -r rossinante:projects/project_1 ~/Documents/
```


\vspace{0.25cm}



You can use the option `-p` to preserve modification times, 
access times, and modes from the original file(s). This can be useful when
you want to copy a project tracked by git.


```sh
# Send a folder from local to Rossinante (preserve modification times) ----
jane@laptop:~$ scp -r -p ~/Documents/project_1 rossinante:projects/
```


## Git and GitHub



If your project is tracked by the versioning system control **git**, you may 
prefer sending files through GitHub (or GitLab). This method has the advantage 
of keeping your project tracked by git, synchronized with GitHub, and backed up 
on Rossinante.


\vspace{0.25cm}


The workflow is the following (Fig. 2):

1. On your laptop, commit changes
1. Then push changes to your repository on GitHub
1. Connect to Rossinante via SSH (or RStudio Server, see below)
1. Clone the GitHub repository on Rossinante or pull changes if your project is
already cloned
1. Run analysis on Rossinante


![Sending files from local to Rossinante using GitHub](images/github-1.png){width=12cm}


\vspace{0.45cm}


Once your analysis is finished, you can (Fig. 3):

1. Track new files and commit changes
1. Push changes to your repository on GitHub
1. On your laptop, pull changes



![Sending files from Rossinante to local using GitHub](images/github-2.png){width=12cm}


At this stage, the project on your laptop, GitHub and Rossinante is in the same state.

\vspace{0.75cm}

**Important --** GitHub does not accept file > 100MB. If your project contains large 
datasets (added in the `.gitignore`), you need to send these files through `sFTP`
or `scp` (Fig. 4).


![Sending files between devices using GitHub and sFTP](images/github-3.png){width=12cm}

\newpage

If your results (created on Rossinante) are > 100MB, you will need to add theses
files to the `.gitignore` and send them to your laptop with the sFTP protocol.



# Working with R



To execute R code on Rossinante, you can use either the RStudio Server interface 
or directly the R console in the terminal. You can also use the `Rscript` Unix 
command.



## RStudio Server



![RStudio Server interface](images/rstudio-server.png){width=12cm}

To start the RStudio Server interface, open a web browser (Firefox, Chrome, 
etc.) and enter the URL of the RStudio Server following by the port: 
`http://92.168.45.3:3528` (for example)

After entering your Rossinante log in information, you are connected to a
new RStudio Server instance. You can now use this interface as the one you 
know (RStudio Desktop).


\vspace{0.45cm}


**Important --** RStudio Server has two buttons to close the interface:
**Sign out** (B in Fig. 5) and **Quit current R session** (C in Fig. 5). 
If you click on **Sign out**, your session will be still active and you will 
have access to objects when you will log in again. You need to click on that 
button if you have launch time consuming analysis. If you click on 
**Quit current R session** you will stop all analyses and you were not able
to access R objects. Click on that button to terminate your session.


\vspace{0.45cm}


If you have been disconnected from RStudio Server (network crash, power failure, 
etc.), you may not be able to restart RStudio Server (blank page). In that case,
you need to kill your previous R sessions (still actives) as follow:

```sh
# SSH connection to Rossinante ----
jane@laptop:~$ ssh rossinante

# Erase all active R sessions ----
jdoe@rossinante:~$ rm -rf ~/.local/share/rstudio/sessions/active/session-*
```


\vspace{0.45cm}


**Note --** With RStudio Server, you can also upload distant files (D in Fig. 5).


## R in the terminal

An alternative is to launch the R console directly from the terminal of Rossinante.
And this is very easy.


```sh
# SSH connection to Rossinante ----
jane@laptop:~$ ssh rossinante

# Launch R console from terminal ----
jdoe@rossinante:~$ R

## R version 4.1.1 (2021-08-10) -- "Kick Things"
## Copyright (C) 2021 The R Foundation for Statistical Computing
## Platform: x86_64-pc-linux-gnu (64-bit)
## 
## R is free software and comes with ABSOLUTELY NO WARRANTY.
## You are welcome to redistribute it under certain conditions.
## Type 'license()' or 'licence()' for distribution details.
## 
## R is a collaborative project with many contributors.
## Type 'contributors()' for more information and
## 'citation()' on how to cite R or R packages in publications.
## 
## Type 'demo()' for some demos, 'help()' for on-line help, or
## 'help.start()' for an HTML browser interface to help.
## Type 'q()' to quit R.
## 
> 
```

To close your R session:

```sh
# Close R session ----
> q("no")
```


\vspace{0.45cm}


If you want, you can also use the command `Rscript` to run an R script 
(or R expression) without opening an R console, directly in the terminal.

```sh
# Run an R expression ----
jdoe@rossinante:~$ Rscript -e 'print("Hello World!")'
## [1] "Hello World!"

# Write an R script on the personal folder ----
jdoe@rossinante:~$ echo 'print("Hello World!")' > ~/hello.R

# Print 'hello.R' file content ----
jdoe@rossinante:~$ cat ~/hello.R
## print("Hello World!")

# Run an R script ----
jdoe@rossinante:~$ Rscript ~/hello.R
## [1] "Hello World!"
```


\vspace{0.45cm}


- screen



# Working with Python



Coming soon...



# Good practices



Coming soon...
