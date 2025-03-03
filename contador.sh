#!/bin/bash

read -p "Digite um número: " num

sequencia=""

for i in $(seq 1 $num)
do
    sequencia="$sequencia $i"
done

echo "$sequencia"