#!/bin/bash

# bash tool => return all clear subdomains
# bash tool "*" => return all subdomains which have astric
# bash tool "all" => return all subdomains

domain=$1
subs_all=()
subs_astric=()
subs_normal=()

getSubs() {
	subs_all=$(curl -s https://crt.sh/\?q=$domain\&output\=json | jq -r '.[].name_value' | grep $domain | grep -v '\\' | grep -v "@" | sort -u)
}
getSubs

for sub in $subs_all; do
	if [[ "$sub" =~ "*" ]]; then
		subs_astric+="$sub "
	else
		subs_normal+="$sub "
	fi
done

if [[ $2 == "*" ]]; then
	for sub in $subs_astric; do
		echo $sub
	done
elif [[ $2 == "all" ]]; then
	for sub in $subs_all; do
		echo $sub
	done

else
	for sub in $subs_normal; do
		echo $sub
	done

fi
