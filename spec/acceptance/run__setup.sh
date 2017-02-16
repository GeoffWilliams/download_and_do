# clean out previous test runs
rm -rf /usr/download /usr/extract /var/cache/download_and_do/download

id bob || adduser bob
mkdir -p /usr/download
chgrp bob /usr/download
chmod 770 /usr/download
