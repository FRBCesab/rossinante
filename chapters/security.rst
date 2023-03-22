Security
=========================

|admin|

.. |admin| image:: https://img.shields.io/static/v1?label=-&message=Admin%20only&color=red&logo=ubuntu&style=flat-square

-----



During Rossinante installation, some security aspects have been set
(user access control, least privileges, encrypted communication, minimal
installation, etc.). Here we will improve the security.


|


Firewall
--------

Let's configure the firewall **UFW** (Uncomplicated Firewall).

Tutorial:
  * https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04


---------


.. code-block:: shell

  # Install UFW ----
  $ sudo apt install ufw

  # Disable firewall ----
  $ sudo ufw disable

  # Deny all incoming connections ----
  $ sudo ufw default deny incoming

  # Allow all outgoing connections ----
  $ sudo ufw default allow outgoing

  # Allow SSH port ----
  $ sudo ufw allow 2222/tcp

  # Activate firewall ----
  $ sudo ufw enable

  # Check firewall status ----
  $ sudo ufw status


|


Fail2ban
--------


.. code-block:: shell

  # Install Fail2ban ----
  $ sudo apt install fail2ban

  # Duplicate config file ----
  $ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

  # Edit config file ----
  $ sudo nano /etc/fail2ban/jail.local


Change the following value:

.. code-block::

  [sshd]

  mode    = aggressive
  port    = 2222


.. code-block:: shell

  # Restart service ----
  $ sudo service fail2ban restart


.. code-block:: shell

  # Monitoring ----
  $ sudo fail2ban-client status

  $ sudo fail2ban-client status sshd

  $ cat /var/log/auth.log | grep sshd
