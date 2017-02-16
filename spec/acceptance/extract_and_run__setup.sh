# cleanout previous test runs
rm -rf /usr/download /usr/extract /var/cache/download_and_do/download

id bob || adduser bob
mkdir -p /usr/download
mkdir -p /usr/extract
chgrp bob /usr/extract
chgrp bob /usr/download
chmod 770 /usr/download
chmod 770 /usr/extract
