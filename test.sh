#!/bin/bash
echo $name
#cat test.sh | while read line
#do
#	echo "${line}"
#done
#echo "$IFS"
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

pushd() {
	REQ=${1:=.}
	if [ -d "$REQ" ]
	then
		cd "$REQ" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			_DIR_STACK="`pwd`:$_DIR_STACK"
			export _DIR_STACK
			dirs
		else
			echo " ERROR:cannot change to directory $REQ" >&2
		fi
	else
		echo " ERROR:$REQ is not a directory" >&2
	fi
	unset REQ

			
}

_popd_helper() {
	POPD="$1"
	if [ -z "$POPD" ]
	then
		echo " ERROR: $POPD is not a directory"
	fi
	shift 1
	if [ -n "$1" ]
	then
		_DIR_STACK="$1"
		shift
		for i in "$@";
		do
			_DIR_STACK="$_DIR_STACK:$1"	
		done
	else
		_DIR_STACK=
	fi
	if [ -n "$POPD" ]
	then
		echo "value $POPD"
		cd "$POPD"
		if [ $? -ne 0 ]
		then
			echo " ERROR: cannot cd to ${POPD}" >&2 
		else
			pwd
		fi
	else
		echo "ERROR: ${POPD} is not a directory" >&2
	fi
	unset POPD
	export _DIR_STACK


}

popd() {
	OLDIFS="$IFS"
	IFS=:
	_popd_helper $_DIR_STACK
	IFS="$OLDIFS"

}


pushd /home/zhangwanquan/env
echo "after push $_DIR_STACK"
popd
echo "after opop $_DIR_STACK"















