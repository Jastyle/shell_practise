#!/bin/bash
name="testsh"
echo $name
cat test.sh | while read line
do
	echo "${line}"
done
echo "$IFS"
PATH=
SetPath() {
	PATH=${PATH=:"/sbin:/bin"}
	for _dir in $@;do
		if [ -d "$_dir" ]
			then
				PATH="$PATH:$_dir"
		fi
	done
	echo "$PATH"
}
SetPath /usr/bin:/bin

echo " $2 $3"
echo $@
dirs() {
	OLDIFS="$IFS"
	IFS=:
	for i in $_DIR_STACK
	do
		printf "%s " "$i"
	done
	echo 
	IFS="$OLDIFS"
		
}
dir /bin:/usr

pushd() {
	REQ=${1:=.}
	if [ -d "$REQ" ]
	then
		cd "$REQ" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			_DIR_STACK="`pwd`:$_DIR_STACK"
			dirs
		else
			echo " ERROR:cannot change to directory $REQ" >&2
		fi
	else
		echo " ERROR:$REQ is not a directory" >&2
	fi
	unset REQ

			
}


