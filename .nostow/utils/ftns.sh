#!/bin/bash


for_each_line() {
	local cb=$1	
	local file=$2	

	while read -r local line; do

		line=$(echo "${line}" | tr -d '\r')

		$cb $line
		local ret=$?

		if [ $ret -ne 0 ]; then
			break
		fi

	done < $file
}

starts_with() {
	if [[ $2 == $1* ]]; then
		echo true
	else
		echo false
	fi
}

should_skip_line() {
	local line=$1

	if $(starts_with "#" $line) == true; then
		echo true
	else
		echo false
	fi
}

assert_eq() {
	if [[ $1 != $2 ]]; then
		echo "'$1' does not equal '$2'; exiting"
		exit 1
	#else
	#	echo "'$1' does equal '$2'; passed"
	fi
}

test_assert_eq() {
	assert_eq true true
	assert_eq false false
	assert_eq 1 1 
	assert_eq 0 0 
	assert_eq '' ''
}

test_should_skip_line() {
	assert_eq $(should_skip_line "#") true
	assert_eq $(should_skip_line " ") false
	assert_eq $(should_skip_line "\t") false

}

test_starts_with(){
	assert_eq $(starts_with r run) true
	assert_eq $(starts_with ru run) true
	assert_eq $(starts_with run run) true
	assert_eq $(starts_with run- run) false
	assert_eq $(starts_with n run) false
}

test_all() {
	test_assert_eq
	test_should_skip_line
	test_starts_with
}

test_all
