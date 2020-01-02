#!/bin/sh
/usr/sbin/init
chown -R apache:apache /opt/svnadmin/data
chmod -R 777 /opt/svnadmin/data

filepath="/opt/svnadmin/data/config.tpl.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.tpl.ini /opt/svnadmin/data/config.tpl.ini
  chown apache:apache /opt/svnadmin/data/config.tpl.ini
fi

filepath="/etc/subversion/subversion-access-control"
if [ ! -x "$filepath" ]; then
  touch /etc/subversion/subversion-access-control
  chown apache:apache /etc/subversion/subversion-access-control
fi

filepath="/etc/subversion/passwd"
if [ ! -x "$filepath" ]; then
  touch /etc/subversion/passwd
  chown apache:apache /etc/subversion/passwd
fi

filepath="/opt/svnadmin/data/config.ini"
if [ ! -x "$filepath" ]; then
  cp /opt/initfile/config.ini /opt/svnadmin/data/config.ini
  chown apache:apache /opt/svnadmin/data/config.ini
fi

dirpath="/opt/svnadmin/data/backup"
if [ ! -x "$dirpath" ]; then
  mkdir /opt/svnadmin/data/backup
  chown -R apache:apache /opt/svnadmin/data/backup
fi
dirpath="/home/svn"
if [ ! -x "$dirpath" ]; then
  mkdir /home/svn
  chown -R apache:apache /home/svn
fi

#/usr/sbin/apachectl restart

/usr/sbin/apachectl -DFOREGROUND
/usr/bin/svnserve -d --foreground -r /home/svn --listen-port 3690

tail -f /dev/null

