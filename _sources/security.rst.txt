Security
=========================

|admin|

.. |admin| image:: https://img.shields.io/static/v1?label=-&message=Admin%20only&color=red&logo=ubuntu&style=flat-square

-----

Coming soon...



.. code-block:: shell

  ## Firewall Configuration ----

  $ sudo ufw disable
  $ sudo ufw default deny incoming
  $ sudo ufw allow 22
  $ sudo ufw allow 8787
  $ sudo ufw allow 8888
  $ sudo ufw enable
  $ sudo ufw status
