#!/bin/bash

path=$1

if [[ "$path" == "" ]] ; then
    echo "no path was specified"
    exit
fi

if [[ ! -d "$path" ]] ; then
    echo "path does not exist"
    exit
fi

if [[ ! "$(ls -A $path)" ]]; then
    echo "directory is empty"
    exit
fi

cd $path
printf "changing directory to $(pwd) \n"

chars=( {a..z} {A..Z} {0..9} )

function rand_string {
    local c=$1 ret=
    while((c--)); do
        ret+=${chars[$((RANDOM%${#chars[@]}))]}
    done
    printf '%s\n' "$ret"
}

printf "\nrenaming files\n"
for f in ./*
do
    r="$(rand_string 8)"
    mv "$f" ./"$r"
    echo "$f -> $r"
done

printf "\nshredding files\n"
shred -v ./*

printf "\nremoving files\n"
rm -v ./*