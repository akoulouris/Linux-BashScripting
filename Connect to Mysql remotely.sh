#!/bin/bash


# Check if root
if ! is_root
then
    printf "\n${Red}Sorry, you are not root.\n${Color_Off}You must type: ${Cyan}sudo ${Color_Off}bash %s/webappinstall.sh\n" "$SCRIPTS"
    #exit 1
fi


echo "Type Mysql user, followed by [ENTER]:"
read mysqluser
echo "Type password for Mysql user, followed by [ENTER]:"
read mysqlpassword
echo "Type Public IP address from where you wish to allow access to MySQL server , followed by [ENTER]:"
read ipremote

mysql -u"$mysqluser" -p"$mysqlpassword" -e "GRANT ALL PRIVILEGES ON *.* TO '$mysqluser'@'$ipremote' IDENTIFIED BY '$mysqlpassword';"

echo "In  mysqld.cnf ,which usually lives on /etc/mysql/mysql.conf.d/mysqld.cnf find the line bind-address = 127.0.0.1 and comment it out"
echo "Change line  bind-address = 127.0.0.1 to #bind-address = 127.0.0.1"
read -p "Press enter to open mysqld.cnf"
service mysql restart

echo "now you can connect remotely to Mysql"
