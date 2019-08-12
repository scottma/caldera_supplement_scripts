sudo ps -a
pid=$(sudo ps -A | sed 's/^[ \t]*//;s/[ \t]*$//'  | grep python3.6 | cut -
d ' ' -f 1)
echo killing process $pid
sudo kill -9 $pid
rm -rf *.db
. ./generate.sh
sudo python3.6 server.py &
