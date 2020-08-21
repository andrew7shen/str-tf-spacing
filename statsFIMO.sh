#!/bin/bash

#Function: summarizes basic statistics about FIMO comparison data

#for hipstr
if test -f tfpair_summary_hipstr.txt; then
        echo "file exists"
        rm tfpair_summary_hipstr.txt
        touch tfpair_summary_hipstr.txt
else
    	echo "file doesn't exist"
        touch tfpair_summary_hipstr.txt
fi

echo tfpair     count   median  sstdev  hits    1       2       3       4       5       6 >> tfpair_summary_hipstr.txt
for tfpair in $(ls my_comp_all)
do
  	#add motif length, hits per pair, number of eSTRs
        echo ${tfpair}	$(cat my_comp_all/${tfpair}/${tfpair}_final.bed | awk '{print ($12) "\t" $0}' | datamash count 1 median 1 sstdev 1)	0	0	0	0	0	0	0 >> tfpair_summary_hipstr.txt
done

