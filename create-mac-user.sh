#LOCAL_ADMIN_FULLNAME="Joe Admin"     # The local admin user's full name
#LOCAL_ADMIN_SHORTNAME="joeadmin"     # The local admin user's shortname
#LOCAL_ADMIN_PASSWORD="password"      # The local admin user's password

echo -n "Please enter full name for the user:"
read LOCAL_ADMIN_FULLNAME

echo -n "Please enter the username:"
read LOCAL_ADMIN_SHORTNAME

echo -n "Please enter the password:"
read LOCAL_ADMIN_PASSWORD

echo -n "Please enter the name of this MACBook:"
read MAC_HOSTNAME

echo -n "Please enter the IP Address: "
read IP_ADDRESS

cd /etc/ansible

echo -e "[$MAC_HOSTNAME]" \\n "$IP_ADDRESS" >> hosts

# Create a local admin user account

ansible  -m shell -a "sysadminctl -addUser $LOCAL_ADMIN_SHORTNAME -fullName "$LOCAL_ADMIN_FULLNAME" -password "$LOCAL_ADMIN_PASSWORD"  -admin" $MAC_HOSTNAME
ansible  -m shell -a "dscl . create /Users/$LOCAL_ADMIN_SHORTNAME IsHidden 1" $MAC_HOSTNAME
ansible  -m shell -a "mv /Users/$LOCAL_ADMIN_SHORTNAME /var/$LOCAL_ADMIN_SHORTNAME" $MAC_HOSTNAME
ansible  -m shell -a "dscl . -create /Users/$LOCAL_ADMIN_SHORTNAME NFSHomeDirectory /var/$LOCAL_ADMIN_SHORTNAME" $MAC_HOSTNAME
ansible  -m shell -a "dscl . -delete "/SharePoints/$LOCAL_ADMIN_FULLNAME's Public Folder"  $MAC_HOSTNAME
