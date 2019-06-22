NOW=$(date +"%Y%m%d-%H%M%S")
for DBLIST in $(mysql --user=$1 --password='$2' -e 'show databases;' | awk '{ print $1 }' | sed -n '1!p')
do
  mysqldump --user=$1 --password='$2' $DBLIST > /backup/$DBLIST-$NOW.sql
done
tar -cvf /backup/$NOW-db.tar /backup/*.sql
rm -f /backup/*.sql
find /backup -type f -mtime +7 -delete
