MOTD
=========================

|admin|

.. |admin| image:: https://img.shields.io/static/v1?label=-&message=Admin%20only&color=red&logo=ubuntu&style=flat-square

-----


.. code-block:: shell

  ## Install package ----

  $ sudo apt install update-motd figlet


  ## Edit header ----

  $ sudo cp /etc/update-motd.d/00-header /etc/update-motd.d/00-header.original
  $ sudo nano /etc/update-motd.d/00-header

  # >>> #!/bin/sh
  # >>>
  # >>> figlet -f small ROSSINANTE


  ## Edit Landscape ----

  $ sudo cp /etc/update-motd.d/50-landscape-sysinfo /etc/update-motd.d/50-landscape-sysinfo.original
  $ sudo nano /etc/update-motd.d/50-landscape-sysinfo

  # >>> #!/bin/sh
  # >>> # pam_motd does not carry the environment
  # >>> [ -f /etc/default/locale ] && . /etc/default/locale
  # >>> export LANG
  # >>> os=$(lsb_release -s -d)
  # >>> cores=$(grep -c ^processor /proc/cpuinfo 2>/dev/null)
  # >>> [ "$cores" -eq "0" ] && cores=1
  # >>> threshold="${cores:-1}.0"
  # >>> if [ $(echo "`cut -f1 -d ' ' /proc/loadavg` < $threshold" | bc) -eq 1 ]; then
  # >>>     echo
  # >>>     echo "(*) System Information"
  # >>>     #/bin/date
  # >>>     echo "\n  OS:             $os"
  # >>>     echo
  # >>>     /usr/bin/landscape-sysinfo
  # >>> else
  # >>>     echo
  # >>>     echo " System information disabled due to load higher than $threshold"
  # >>> fi


  ## Edit Updates ----

  $ sudo cp /etc/update-motd.d/90-updates-available /etc/update-motd.d/90-updates-available.original
  $ sudo nano /etc/update-motd.d/90-updates-available

  # >>> #!/bin/sh
  # >>>
  # >>> echo "\n(*) System Updates"
  # >>>
  # >>> stamp="/var/lib/update-notifier/updates-available"
  # >>>
  # >>> [ ! -r "$stamp" ] || cat "$stamp"
  # >>>
  # >>> find $stamp -newermt 'now-7 days' 2> /dev/null | grep -q -m 1 '.' || /usr/share/update-notifier/notify-updates-outdated


  ## Disable infos ----

  $ sudo chmod -x /etc/update-motd.d/00-header.original
  $ sudo chmod -x /etc/update-motd.d/50-landscape-sysinfo.original
  $ sudo chmod -x /etc/update-motd.d/90-updates-available.original
  $ sudo chmod -x /etc/update-motd.d/10-help-text
  $ sudo chmod -x /etc/update-motd.d/50-motd-news


  ## Update MOTD ----

  $ sudo update-motd
