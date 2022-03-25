Setting up
==========

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----



When you connect to Rossinante for the first time, you'll be asked to change
your password. This first connection is made under the SSH protocol (Secure
Shell), a cryptographic network protocol that allows you to securely access the
server.

For this tutorial, let's say:

* your laptop name is ``laptop``
* your name is ``Jane DOE``
* your email is ``jane.doe@mail.com``
* your username on your laptop is ``jane``
* your username on Rossinante is ``jdoe``
* the IP address of Rossinante is ``92.168.45.3``
* the port of the SSH server is ``22``

**NB --** When you are inside the CESAB, you can use the local IP address of the
server. When you are outside, you need to use the public IP through a VPN
connection (contact the administrator for further information).



|



SSH connection
--------------



To open an SSH connection on Unix-based OS (macOS and Linux), open a Terminal
session. On Windows, open the PowerShell application. Then run the following
command:


.. code-block:: shell

  # SSH connection to Rossinante ----
  jane@laptop:~$ ssh -p 22 jdoe@92.168.45.3


**NB --** ``jane@laptop:~$`` is the prompt on an Unix terminal. On Windows,
it looks like ``C:\Users\jane>``.


You'll be asked to change your password. Enter the old password and set your new
password (twice). Then, your prompt will look like (a reconnection may be
necessary): ``jdoe@rossinante:~$``. This means that you are now connected to
Rossinante under the username ``jdoe``.


You can check your current directory with the command ``pwd``:

.. code-block:: shell

  # Print working (current) directory ----
  jdoe@rossinante:~$ pwd
  ## /home/jdoe


To stop the SSH connection, use the command ``exit`` (or ``logout``):

.. code-block:: shell

  # Close the SSH connection ----
  jdoe@rossinante:~$ exit
  ## Connection to 92.168.45.3 closed.



|



SSH config file
---------------



It can be painful to remember the IP address and the SSH port of Rossinante,
especially if you use several servers. Fortunately you can store Rossinante
connection information in a special file located on **your laptop**
(not in the server): ``config``. The file must be stored in an hidden folder
``.ssh/`` located in your personal home directory.

To create this ``config`` file, open **RStudio** (for multi-OS support) and
follow these steps:


.. code-block:: r

  # Navigate to your home directory (symbolized by ~) ----
  R> setwd("~")

  # Create a new hidden folder ----
  R> dir.create("~/.ssh")

  # Change folder permissions ----
  # (only Jane can read, write, and execute this folder) ----
  R> Sys.chmod("~/.ssh", mode = "0700")

  # Create an (empty) SSH config file ----
  R> file.create("~/.ssh/config")

  # Change config file permissions ----
  # (only Jane can read and write this file) ----
  R> Sys.chmod("~/.ssh/config", mode = "0600")

  # Open the SSH config file with RStudio editor ----
  R> file.edit("~/.ssh/config")


Now add the follow lines in the SSH config file:

.. code-block::

  Host rossinante
     HostName 92.168.45.3
     Port 22
     User jdoe


You can now connect to Rossinante as follow:

.. code-block:: shell

  jane@laptop:~$ ssh rossinante



|



Generating SSH keys
-------------------



SSH keys are a more secure method of logging into a remote server, because they
are not vulnerable to common brute-force password hacking attacks. Generating
an SSH keys pair consists in creating two long strings of characters: a public
and a private key. You can place the public key on any server, and then connect
to the server using a device that has access to the private key.

Let's create a new SSH keys pair using the cryptosystem ``ed25519``. You will
create this SSH keys pair locally (i.e. **on your laptop**).



.. code-block:: shell

  # Create a new SSH key pair (on your laptop) ----
  jane@laptop:~$ ssh-keygen -t ed25519 -C "jane.doe@mail.com"



If you want, you can add a passphrase to increase the security of your key pair
(recommended) but each time you will connect to Rossinante you will be asked
to enter it. It's up to you.

This SSH keys pair has been stored in ``~/.ssh/``.



.. code-block:: shell

  # Content of the ~/.ssh folder ----
  jane@laptop:~$ ls ~/.ssh
  ## config       id_ed25519       id_ed25519.pub



The private key is ``id_ed25519`` and the public one ``id_ed25519.pub``.
Nobody (except you) can have access to the private key. So you need to change
the permissions of this file.



.. code-block:: shell

  # Change private key permissions (only Jane can only read this file) ----
  jane@laptop:~$ chmod 400 ~/.ssh/id_ed25519



On the opposite your SSH public key can be deployed everywhere. In our case, we will store
it on the Rossinante server.



.. code-block:: shell

  # Copying public key to Rossinante ----
  jane@laptop:~$ ssh-copy-id -i ~/.ssh/id_ed25519.pub rossinante



Now we can connect to Rossinante more securely and without entering any password
(except if you have added a passphrase to your SSH keys pair).



.. code-block:: shell

  jane@laptop:~$ ssh rossinante



The first time you use your new SSH keys pair you will see:



.. code-block::

  The authenticity of host '[92.168.45.3]:22' can't be established.
  RSA key fingerprint is ...
  Are you sure you want to continue connecting (yes/no/[fingerprint])?



Just write ``yes`` and press ``Enter``.

Our SSH public key on Rossinante has been stored under the name ``authorized_keys``.



.. code-block:: shell

  # Content of the ~/.ssh folder ----
  jdoe@rossinante:~$ ls ~/.ssh
  ## authorized_keys



**NB --** If you lose you private key you will still be able to log in with
your password.



|



Git credentials
---------------



The version control system **git** is already installed on Rossinante, but you
need to (globally) set your username and email (required for commits).
Run the following lines:



.. code-block:: shell

  # Connection to Rossinante ----
  jane@laptop:~$ ssh rossinante

  # Set Git credentials on Rossinante (globally) ----
  jdoe@rossinante:~$ git config --global user.name "Jane Doe"
  jdoe@rossinante:~$ git config --global user.email jane.doe@mail.com



A ``~/.gitconfig`` file has been created:

.. code-block:: shell

  # Content of the .gitconfig file ----
  jdoe@rossinante:~$ cat ~/.gitconfig
  ## [user]
  ##          name  = Jane Doe
  ##          email = jane.doe@mail.com



You can also define **git** parameters locally, i.e. specific to a project. For more
information: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup.



|



GitHub SSH keys
---------------



If you want to communicate with GitHub through the SSH protocol (recommended)
you need to generate a new SSH keys pair (different from the one used to connect
to Rossinante).

Let's create a new SSH keys pair using the cryptosystem ``RSA`` and a key size of
``4096`` bits. But this time, this SSH keys pair will be generated **on Rossinante**.



.. code-block:: shell

  # Create a new SSH key pair ----
  jdoe@rossinante:~$ ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C "jane.doe@mail.com"



**NB --** To be detected by RStudio Server, this SSH keys pair must be named
``id_rsa`` and created using the cryptosystem ``RSA``.



This new SSH keys pair has been stored in ``~/.ssh/``.

.. code-block:: shell

  # Content of the ~/.ssh folder ----
  jdoe@rossinante:~$ ls ~/.ssh
  ## authorized_keys       id_rsa       id_rsa.pub



Let's restrict the access to the private key.



.. code-block:: shell

  # Change private key permissions (only jdoe can only read this file) ----
  jdoe@rossinante:~$ chmod 400 ~/.ssh/id_rsa



Now we need to store the public key on GitHub server. Visit
https://github.com/settings/keys and click on **New SSH key**.



On Rossinante, print the **public** SSH key and copy it.



.. code-block:: shell

  # Print GitHub public SSH key ----
  jdoe@rossinante:~$ cat ~/.ssh/id_rsa.pub



Go back to GitHub, give a title to your new SSH key (for example *Rossinante key*) and
paste your public SSH key. Click on **Add SSH key**.


Congratulation! You can know communicate with GitHub using the SSH protocol.
Let's test the SSH connection between Rossinante and GitHub:

.. code-block:: shell

  # Test SSH connection between Rossinante and GitHub ----
  jdoe@rossinante:~$ ssh -T git@github.com
  ## Hi janedoe! You've successfully authenticated!



**Important --** If you lose your private SSH key you won't be able to establish
a connection with GitHub (from Rossinante). You'll need to delete your SSH key
on GitHub (i.e. *Rossinante key*) and to create a new one.

**NB --** You will need to add your private GitHub SSH key on your other devices.
Alternatively (recommended) you can create a new GitHub SSH keys pair on each
device (if not already done).



|



GitHub PAT
----------



If you want to use the GitHub API, essentially with the R package
`usethis <https://usethis.r-lib.org/>`_,
you need to create a GitHub Personal Access Token (PAT). Visit
https://github.com/settings/tokens and click on **Generate new token**.
Choose a name for the token (for example *Rossinante token*), select
an expiration date, and choose the scope (at least): **repo** and **workflow**.
Copy the GitHub PAT and go back to Rossinante shell.

You will store this token in the file ``~/.Renviron`` (readable by R).

.. code-block:: shell

  # Store GitHub PAT on Rossinante (for R only) ----
  jdoe@rossinante:~$ echo "GITHUB_PAT=XXX" >> ~/.Renviron

Make sure to replace ``XXX`` by your token value.
