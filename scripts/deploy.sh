#setup variables
script_dir="$( cd "$( dirname "$0" )" && pwd )"
deploy_env='daniel'
init=''
if [ "$#" -ge 1 ]; then init=$1; fi
rsync_args="-arvuz $script_dir/../ daniel@writerkata.com:/home/daniel/public/tree.monomyth.io/public --delete --exclude-from $script_dir/exclude.txt"
site_dir='tree.monomyth.io'
error_output='error: deployment aborted'

#deploy
cd $script_dir
echo $'\033[0;36m'
echo "deployment started to $site_dir"

#copy web files
echo $'\033[0;33m'
echo $'step one: copying website to server'
echo $'\033[0m'
rsync $rsync_args
res=$?
[ $res -ne 0 ] && echo $'\033[0;31m' && echo $ $error_output && echo $'\033[0m' && exit 1

#run package install
echo $'\033[0;33m'
echo $'step two: run package install server'
echo $'\033[0m'
ssh $deploy_env@writerkata.com "bash -l -c 'cd ./public/$site_dir/public;pwd;npm install'"
res=$?
[ $res -ne 0 ] && echo $'\033[0;31m' && echo $ $error_output && echo $'\033[0m' && exit 1

#run migrations
#echo $'\033[0;33m'
#echo $'step three: run migrations on database'
#echo $'\033[0m'
#ssh $deploy_env@writerkata.com "bash -l -c 'cd ./public/$site_dir/public;./node_modules/.bin/db-migrate up -e production'"
#res=$?
#[ $res -ne 0 ] && echo $'\033[0;31m' && echo $ $error_output && echo $'\033[0m' && exit 1

#restart web server
echo $'\033[0;33m'
echo $'step four: restart server'
echo $'\033[0m'
ssh -tt $deploy_env@writerkata.com "bash -l -c 'sudo reboot'"
res=$?
[ $res -ne 0 ] && echo $'\033[0;31m' && echo $ $error_output && echo $'\033[0m' && exit 1

#finished
echo $'\033[0;32m'
echo "deployment finished to $site_dir"
echo $'\033[0m'