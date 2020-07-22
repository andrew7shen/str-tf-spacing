#!/bin/bash

#Function: summarizes basic statistics about FIMO comparison data


if test -f tfpair_summary.txt; then
	echo "file exists"
	rm tfpair_summary.txt
	touch tfpair_summary.txt
else
	echo "file doesn't exist"
	touch tfpair_summary.txt
fi

echo chromosome	count	median	sstdev >> tfpair_summary.txt
for tfpair in $(ls my_comp_all)
do
	echo ${tfpair} $(cat my_comp_all/${tfpair}/${tfpair}_final.bed | awk '{print ($12) "\t" $0}' | datamash count 1 median 1 sstdev 1) >> tfpair_summary.txt
done
