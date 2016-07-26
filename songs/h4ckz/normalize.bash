#!/usr/bin/env bash

for sample in $(find . -name '*.wav')
do
	mv $sample /tmp/to_process.wav
	sox --norm /tmp/to_process.wav $sample
	echo "$sample OK"
done
