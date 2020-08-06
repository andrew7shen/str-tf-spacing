#!/bin/bash

#Function: run intersectBed on each final FIMO output (edited) file, create new text file within my_comp_all with intersect data

#Path to STRs: /storage/mgymrek/platinum-genomes/trio-analysis/gangstr/hg19_ver13_1.bed


if test -d my_intersect_all; then
        echo "directory exists"
        rm -r my_intersect_all
        mkdir my_intersect_all
else
    	echo "directory doesn't exist"
        mkdir my_intersect_all
fi

for tfpair in $(ls my_comp_all)
do
	mkdir my_intersect_all/${tfpair}
	intersectBed -a /storage/mgymrek/platinum-genomes/trio-analysis/gangstr/hg19_ver13_1.bed -b my_comp_all/${tfpair}/${tfpair}_final.bed > my_intersect_all/${tfpair}/${tfpair}_intersect.bed -f 1.0 -wa -wb
done
