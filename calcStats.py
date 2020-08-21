#Function: calculates hits and lengths for the hipstr master output file


#clears stats_final.txt file
import os
os.remove("stats_final.txt")

f1 = open("intersect_master.bed", "r")
f1_split = f1.readlines()
f2 = open("tfpair_summary_hipstr.txt", "r")
f2_split = f2.readlines()
f3 = open("stats_final.txt", "a")

for line2 in f2_split:
	L = ""
	line2_split = line2.split()
	L = L + line2_split[0] + "\t" + line2_split[1] + "\t" + line2_split[2] + "\t" + line2_split[3] + "\t"

	for line1 in f1_split:
		line1_split = line1.split("\t")
		#print line1_split[18]
	
		hit_count =  0
		ones = 0
		twos = 0
		threes = 0
		fours = 0
		fives = 0
		sixes = 0

		if line1_split[18] == line2_split[0]:
			hit_count = hit_count+1
			if line1_split[3] == "1":
				ones = ones+1
			if line1_split[3] == "2":
	                        twos = twos+1
			if line1_split[3] == "3":
				threes = threes+1
			if line1_split[3] == "4":
        	                fours = fours+1
			if line1_split[3] == "5":
                        	fives = fives+1
			if line1_split[3] == "6":
        	                sixes = sixes+1
		
		L = L + str(hit_count) + "\t" + str(ones) + "\t" + str(twos) + "\t" + str(threes) + "\t" + str(fours) + "\t" + str(fives) + "\t" + str(sixes)

	f3.write(L + "\n")
