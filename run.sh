#!/bin/sh
#/usr/sbin/init
chown -R apache:apache /opt/svnadmin/data
chmod -R 777 /opt/svnadmin/data

filepath="/opt/svnadmin/data/config.tpl.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.tpl.ini /opt/svnadmin/data/config.tpl.ini
  chown apache:apache /opt/svnadmin/data/config.tpl.ini
fi

filepath="/opt/svnadmin/data/config.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.ini /opt/svnadmin/data/config.ini
fi

dirpath="/opt/svnadmin/data/backup"
if [ ! -x "$dirpath" ]; then
  mkdir /opt/svnadmin/data/backup
  chown -R apache:apache /opt/svnadmin/data/backup
fi

chown -R apache:apache /opt/svnadmin/data
chmod -R 777 /opt/svnadmin/data

filepath="/etc/subversion/subversion-access-control"
if [ ! -x "$filepath" ]; then
  touch /etc/subversion/subversion-access-control
  chown apache:apache /etc/subversion/subversion-access-control
fi

filepath="/etc/subversion/passwd"
if [ ! -x "$filepath" ]; then
  touch /etc/subversion/passwd
  chown apache:apache /etc/subversion/passwd
  chmod -R 777 /etc/subversion/passwd
fi

chmod -R 777 /etc/subversion


dirpath="/home/svn"
if [ ! -x "$dirpath" ]; then
  mkdir /home/svn
  chown -R apache:apache /home/svn
fi

chmod -R 777 /home/svn

# /usr/sbin/httpd -k start
/usr/sbin/apachectl  restart ;

# tail -f /dev/null

