Linux Cheat Sheet
=================

|all-users|

.. |all-users| image:: https://img.shields.io/static/v1?label=-&message=All%20users&color=yellowgreen&logo=ubuntu&style=flat-square

----


Getting help
------------

.. code-block:: shell

  ## Getting help ----

  $ man ls                                   # Print the manual of the command <ls>
  $ curl https://cheat.sh/ls                 # Print examples of the command <ls>

|



Directory navigation
--------------------

.. code-block:: shell

  ## Navigate to HOME directory ----

  $ cd                                       # Go to HOME directory (/home/jdoe)
  $ cd ~                                     # Idem
  $ cd $HOME                                 # Idem
  $ cd /home/jdoe                            # Idem


  ## Navigate between directories ----

  $ cd ..                                    # Move one level up
  $ cd ../..                                 # Move two levels up

  $ cd Pictures                              # Go to a directory
  $ cd Pictures/wallpapers                   # Go to a subdirectory (relative path)
  $ cd /home/jdoe/Pictures/wallpapers        # Go to a subdirectory (absolute path)


  ## Print current directory ----

  $ pwd

|



Directory content
-----------------

.. code-block:: shell

  ## List directory content ----

  $ ls                                       # List content
  $ ls -l                                    # List content in a table-like format
  $ ls -a                                    # List content including hidden files
  $ ls -al                                   # List content in a table-like format with hidden files
  $ ll                                       # Idem
  $ ls -R                                    # List content recursively
  $ ls -lh                                   # List content in a table-like format and human-readable


  ## List content in a tree-like format ----

  $ tree                                     # List content in a tree-like format
  $ tree -a                                  # List content including hidden files
  $ tree -L 2                                # Limit to two subdirectory levels

|


Working with files
------------------

.. code-block:: shell

  ## Creating new files ----

  $ touch newfile.txt                        # Create a new empty file

  $ echo "Line 1\nLine 2" > newfile.txt      # Create a new file and add content on-the-fly

  $ nano newfile.txt                         # Create and open a new file in the NANO text editor
                                             # Press CTRL + X to exit (and Y and ENTER to save the file)

  $ cat > newfile.txt                        # Create new file and add content interactively
                                             # Press CTRL + D to save the file


  ## Editing an existing file ----

  $ echo "Line 3\nLine 4" >> file.txt        # Add content to an existing file

  $ nano file.txt                            # Open an existing file in the NANO text editor


  ## Print file content ----

  $ cat file.txt                             # Print file content

  $ less file.txt                            # Open a file for interactive reading

  $ head file.txt                            # Print the first part of a file
  $ tail file.txt                            # Print the last part of a file


  ## Moving file ----

  $ mv file.txt new/location/                # Move a file to a new location


  ## Renaming file ----

  $ mv file.txt new_name.txt                 # Rename a file
  $ mv file.txt new/location/new_name.txt    # Move and rename a file


  ## Deleting file ----

  $ rm file.txt                              # Delete a file


  ## Joining files ----

  $ cat file-1.txt file-2.txt > file-3.txt   # Merge two files in one

|


Working with directories
------------------------

.. code-block:: shell

  ## Creating directories ----

  ...


  ## Moving directories ----

  ...


  ## Renaming directories ----

  ...


  ## Deleting directories ----

  ...
  
|


Useful commands
---------------

.. code-block:: shell

  ## Clears the screen of the terminal ----

  $ clear


  ## Get the size of the current directory ----
  
  $ du -sh .


  ## Print the command lines history ----

  $ history


  ## Search for a previous command ----

  # CTRL + R and type some characters of the command
