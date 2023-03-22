Working with R
==============

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----


To execute R code on Rossinante, you can use either the RStudio Server interface
or directly the R console in the terminal. You can also use the ``Rscript``
command.



|



.. _rstudio:

RStudio Server
--------------


.. figure:: ./images/rstudio-server.png
  :align: center
  :alt: RStudio Server interface

  **Figure 5** -- RStudio Server interface


|



To open the RStudio Server interface, we first need to create an **SSH
tunneling** (or port forwarding). This method consists in creating an encrypted
SSH connection between a client (your laptop) and a server (Rossinante) through
which a service (Rstudio Server) port (8787) can be relayed.

To create an SSH port forwarding, pass the ``-L`` option to the ssh client:

.. code-block:: shell

  # Open an SSH port forwarding ----
  jane@laptop:~$ ssh -L 8787:localhost:8787 rossinante

**NB --** The first ``8787`` is your local port through RStudio Server will be relayed.
The second ``8787`` is the port on Rossinante through RStudio Server is running.
In short, ``localhost`` is your laptop. Instead of ``localhost`` we could have
written ``127.0.0.1``. You can change the first ``8787`` for any number greater
than ``1024``.


You are now connected to Rossinante.


To start the RStudio Server interface, open a web browser (Firefox, Chrome,
etc.) and enter the following URL: ``localhost:8787``.

After entering your Rossinante log in information, you are connected to a
new RStudio Server instance. You can now use this interface as the one you
know (RStudio Desktop).



**Important --** RStudio Server has two buttons to close the interface:
``Sign out`` (B in Figure 5) and ``Quit current R session`` (C in Figure 5).
If you click on ``Sign out``, your session will be still active (in background)
and you will have access to objects when you will log in again. You need to
click on that button if you have launched time consuming analysis. If you click
on ``Quit current R session`` you will stop all analyses and you were not able
to access R objects. Click on that button to terminate your session.




**Warning --** If you stop your SSH (port forwarding) session, you will close the
RStudio Server session. Before shutting down the SSH connection, click on
``Sign out`` or ``Quit current R session`` to securely close the RStudio Server
instance.




**Trick --** If you have been disconnected from RStudio Server (network crash, power failure,
etc.), you may not be able to restart RStudio Server (blank page). In that case,
you need to kill your previous R sessions (still active) as follow:

.. code-block:: shell

  # SSH connection to Rossinante ----
  jane@laptop:~$ ssh rossinante

  # Erase all active R sessions ----
  jdoe@rossinante:~$ killall -u jdoe rsession

  # Hardcore method ----
  jdoe@rossinante:~$ rm -rf ~/.local/share/rstudio/sessions/active/session-*



|



R console
---------



An alternative is to launch the R console directly from the terminal of Rossinante.
And this is very easy.


.. code-block:: shell

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


To close your R session:

.. code-block:: r

  # Close R session ----
  > q("no")



|


**The Rscript command**
  If you want, you can also use the command ``Rscript`` to run an R script
  (or R expression) without opening an R console, directly from the terminal.

.. code-block:: shell

  # Run an R expression (option '-e') ----
  jdoe@rossinante:~$ Rscript -e 'print("El ingenioso hidalgo don Quijote de la Mancha")'
  ## [1] "El ingenioso hidalgo don Quijote de la Mancha"

  # Write an R script on the personal folder ----
  jdoe@rossinante:~$ echo 'print("El ingenioso hidalgo don Quijote de la Mancha")' > ~/quijote.R

  # Print 'quijote.R' file content ----
  jdoe@rossinante:~$ cat ~/quijote.R
  ## print("El ingenioso hidalgo don Quijote de la Mancha")

  # Run the R script ----
  jdoe@rossinante:~$ Rscript ~/quijote.R
  ## [1] "El ingenioso hidalgo don Quijote de la Mancha"

  # Remove the R script ----
  jdoe@rossinante:~$ rm ~/quijote.R



|



**Problem**
  If you launch R in the terminal (or ``Rscript``) and your code takes time to
  be computed, you cannot use the terminal until the computation is done. The job
  is running in foreground. Moreover, if your SSH connection is stopped, your R
  session is aborted and your work is lost.


**Solution**
  You can use a terminal multiplexer like ``screen`` or ``tmux``. These tools
  open *virtual* terminals (screens) in the main terminal and you can navigate
  between screens and the main terminal. The idea is to create (attach) a new
  screen, launch your analysis, go back to the main terminal (detach), and work
  on other stuffs. If you stop your SSH connection, the analysis is still
  running, and if you make a new SSH connection to Rossinante, you can reattach
  the screen and resume your R session.



Let's take an example with ``screen``:



.. code-block:: shell

  # SSH connection to Rossinante ----
  jane@laptop:~$ ssh rossinante

  # Attach (create) a new screen (named 'r_analysis', for instance) ----
  jdoe@rossinante:~$ screen -S r_analysis

  # Open R console (in the new screen) ----
  (r_analysis) jdoe@rossinante:~$ R

  # Launch the analysis ----
  (r_analysis) > source("script_analysis.R")



To detach from the screen session, type ``CTRL + A`` and ``D``.

You can list running screens as follow:



.. code-block:: shell

  # List running screens ----
  jdoe@rossinante:~$ screen -ls
  ## There is a screen on:
  ##         4002.r_analysis (Detached)



To reattach a screen session, use the following command:



.. code-block:: shell

  # Reattach a screen ----
  jdoe@rossinante:~$ screen -r r_analysis

  (r_analysis) jdoe@rossinante:~$



To close a screen, type ``exit`` in the screen or press ``CTRL + A`` and ``K``.

More information on ``screen``:
https://www.malekal.com/screen-linux-lancer-plusieurs-commandes-sans-perdre-execution/


|



R packages
----------



Only base R packages are installed and shared among users.
Each user has a personal R library in which he can install/update every R packages he
wants (independently of other users). This library is located in
``~/R/x86_64-pc-linux-gnu-library/4.1/``.

To install a new R package, use the interface of RStudio Server or the R console and run:

.. code-block:: r

  install.packages("sf")

If you want you can also update your packages:

.. code-block:: r

  update.packages()


**NB --** Some R packages require system libraries and some of them may be
missing on Rossinante. Please contact the administrator to solve the issue.

You can find a list of common R packages used in Ecology
`here <https://raw.githubusercontent.com/FRBCesab/rossinante/main/tools/list-of-rpackages.R>`_.
To install these packages on Rossinante (or elsewhere), open an R console or
RStudio Server and run:

.. code-block:: r

  ## Script URL ----
  url <- "https://raw.githubusercontent.com/FRBCesab/rossinante/main/tools/list-of-rpackages.R"

  ## Download script ----
  download.file(url, destfile = "list-of-rpackages.R")

  ## Install R packages ----
  source("list-of-rpackages.R")

  ## Delete downloaded script ----
  file.remove("list-of-rpackages.R")
