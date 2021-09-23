Sending files
=============

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----



When you want to run analyses on Rossinante, you need to transfer files (code
and data) from your laptop to the server. Here we will see four methods.



sFTP
----


The easiest way to transfer files from your laptop to Rossinante (or vice versa)
is by using the sFTP protocol (Secure File Transfer Protocol).
The `Filezilla <https://filezilla-project.org/>`_ client is a
freeware that supports this protocol. You will need to define the following
parameters (Figure 1):


- Host: ``sftp://92.168.45.3``
- Username: ``jdoe`` (Rossinante username)
- Password: your Rossinante user's password
- Port: ``22`` (SSH port)

To make the connection, click on **Quick connect**.

.. figure:: ./images/filezilla.png
  :align: center
  :alt: Filezilla interface

  **Figure 1** -- Filezilla interface


|

The left panel ``A`` lists your local folders/files. The right panel ``B``
shows the content of your personal directory on Rossinante.

To send local files **to Rossinante**, first select the directory in ``B`` to
send these files in. Then select files/folders in ``A``, right click, and click
on **Upload**.

To send remote files **to your laptop**, first select the directory in ``A`` to
send these files in. Then select the files in ``B``, right click, and click
on **Download**.



scp command
-----------



An alternative to transfer files is by using the command ``scp`` that allows
to copy files using the SSH protocol (secure copy).

Let's say we want to copy the local file ``script.R``, located in the
``Documents/`` folder, to Rossinante (in the folder ``~/projects/``).
We will use ``scp`` as follow:



.. code-block:: shell

  # Send a file from local to Rossinante ----
  jane@laptop:~$ scp ~/Documents/script.R rossinante:projects/



If we want to download a file from Rossinante:



.. code-block:: shell

  # Send a file from Rossinante to local ----
  jane@laptop:~$ scp rossinante:projects/script.R ~/Documents/



To copy folders we will add the option ``-r`` (for recursive):

.. code-block:: shell

  # Send a folder from local to Rossinante ----
  jane@laptop:~$ scp -r ~/Documents/project_1 rossinante:projects/

  # Send a folder from Rossinante to local ----
  jane@laptop:~$ scp -r rossinante:projects/project_1 ~/Documents/



You can use the option ``-p`` to preserve modification times,
access times, and modes from the original file(s). This can be useful when
you want to copy a project tracked by **git**.



.. code-block:: shell

  # Send a folder from local to Rossinante (preserve modification times) ----
  jane@laptop:~$ scp -r -p ~/Documents/project_1 rossinante:projects/



rsync
-----

Tutorial:
  * https://linuxize.com/post/how-to-transfer-files-with-rsync-over-ssh/

The command ``rsync`` is an alternative to ``scp`` and has the advantage to copy
files only if necessary. It's also can be used as a backup system.


GitHub
------


If your project is tracked by the versioning system control **git**, you may
prefer sending files through GitHub (or GitLab). This method has the advantage
of keeping your project tracked by git, synchronized with GitHub, and backed up
on Rossinante.


The workflow is the following (Figure 2):

1. On your laptop, commit changes
1. Then push changes to your repository on GitHub
1. Connect to Rossinante via SSH (or RStudio Server, see :ref: `rstudio`)
1. Clone the GitHub repository on Rossinante or pull changes if your project is
already cloned
1. Run analysis on Rossinante


.. figure:: ./images/github-1.png
  :align: center
  :alt: GitHub 1

  **Figure 2** -- Sending files from local to Rossinante using GitHub


|


Once your analysis is finished, you can (Figure 3):

1. Track new files and commit changes
1. Push changes to your repository on GitHub
1. On your laptop, pull changes


.. figure:: ./images/github-2.png
  :align: center
  :alt: GitHub 2

  **Figure 3** -- Sending files from Rossinante to local using GitHub


|


At this stage, the project on your laptop, GitHub and Rossinante is in the same state.


|


**Important --** GitHub does not accept file > 100MB. If your project contains large
datasets (added in the ``.gitignore``), you need to send these files through ``sFTP``
or ``scp`` (Figure 4).



.. figure:: ./images/github-3.png
  :align: center
  :alt: GitHub 3

  **Figure 4** -- Sending files between devices using GitHub and sFTP


|


If your results (created on Rossinante) are > 100MB, you will need to add theses
files to the ``.gitignore`` and send them to your laptop with the sFTP protocol.
