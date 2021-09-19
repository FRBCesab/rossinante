Working with R
==============

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----


To execute R code on Rossinante, you can use either the RStudio Server interface
or directly the R console in the terminal. You can also use the ``Rscript``
command.



.. _rstudio:

RStudio Server
--------------


.. figure:: ./images/rstudio-server.png
  :align: center
  :alt: RStudio Server interface

  **Figure 5** -- RStudio Server interface


|



To start the RStudio Server interface, open a web browser (Firefox, Chrome,
etc.) and enter the URL of the RStudio Server following by the port:
``http://92.168.45.3:3528`` (for example).

After entering your Rossinante log in information, you are connected to a
new RStudio Server instance. You can now use this interface as the one you
know (RStudio Desktop).


|


**Important --** RStudio Server has two buttons to close the interface:
``Sign out`` (B in Figure 5) and ``Quit current R session`` (C in Figure 5).
If you click on ``Sign out``, your session will be still active (in background)
and you will have access to objects when you will log in again. You need to
click on that button if you have launched time consuming analysis. If you click
on ``Quit current R session`` you will stop all analyses and you were not able
to access R objects. Click on that button to terminate your session.


|


If you have been disconnected from RStudio Server (network crash, power failure,
etc.), you may not be able to restart RStudio Server (blank page). In that case,
you need to kill your previous R sessions (still active) as follow:

.. code-block:: shell

  # SSH connection to Rossinante ----
  jane@laptop:~$ ssh rossinante

  # Erase all active R sessions ----
  jdoe@rossinante:~$ rm -rf ~/.local/share/rstudio/sessions/active/session-*



**Note --** With RStudio Server, you can also upload distant files (D in Figure 5).



R in the terminal
-----------------



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



If you want, you can also use the command ``Rscript`` to run an R script
(or R expression) without opening an R console, directly from the terminal.

.. code-block:: shell

  # Run an R expression (option '-e') ----
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



|


**Important --** If you launch R in the terminal (or ``Rscript``) and your code
takes time to be computed, you cannot use the terminal until the computation is
done. The job is running in foreground. Moreover, if your SSH connection is
stopped, your R session is aborted and your work is lost.


**Solution --** You can use a terminal multiplexer like ``screen`` or ``tmux``. These
tools open *virtual* terminals (screens) in the main terminal and you can navigate between
screens and the main terminal. The idea is to create (attach) a new screen, launch
your analysis, go back to the main terminal (detach), and work on other stuffs.
If you stop your SSH connection, the analysis is still running, and if you make
a new SSH connection to Rossinante, you can reattach the screen and resume your R session.



Let's take an example with ``screen``:



.. code-block:: shell

  # SSH connection to Rossinante ----
  jane@laptop:~$ ssh rossinante

  # Attach (create) a new screen (named 'r_analysis', for instance) ----
  jdoe@rossinante:~$ screen -S r_analysis

  # Open R console (in the new screen) ----
  (r_analysis) jdoe@rossinante:~$ R

  # Launch the analysis ----
  (r_analysis) jdoe@rossinante:~$ source("script_analysis.R")



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



To close a screen, type `exit` in the screen or press `CTRL + A`` and ``K``.
