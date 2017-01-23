# coding:utf_8
import sys
import os
import csv

def read_csv():
	global input_center,xdelta
	csvfile = file(origin_csv_path,'r')
	reader = csv.reader(csvfile)
	for line in reader:
		if len(line)==2 and line[0].find("Center Frequency")!=-1:
			input_center = str('%.9f'%(float(line[1][:-1])*100000))
		if len(line)==2 and line[0].find("Bandwidth")!=-1:
			# add something
			xdelta = str('%.6e'%(1/float(line[1][:-1])/1000000))	
	csvfile.close()
	
def convert_origin_to_result():
	global origin_data_path,save_path,input_center,xdelta
	input_zoom = "TRUE"
	input_range = "2.000000000"
	inputrefimped = "50.000000000"
	xstart= "0.000000000"
	xdomain = "0"
	xunit = "Sec"
	yunit = "V"
	freqvalidmax = "1020000000.000000000"
	freqvalidmin = "980000000.000000000"
	timestring = "Wed Apr 9 10:31:26.524 2014"
	with open(save_path,'w') as data_output:
		text = "InputZoom"+'\t'+input_zoom+"\r\n"
		text += "InputCenter"+'\t'+input_center+"\r\n"
		text += "InputRange"+'\t'+input_range+"\r\n"
		text += "InputRefImped"+'\t'+inputrefimped+"\r\n"
		text += "XStart"+'\t'+xstart+"\r\n"
		text += "XDelta"+'\t'+xdelta+"\r\n"
		text += "XDomain"+'\t'+xdomain+"\r\n"
		text += "XUnit"+'\t'+xunit+"\r\n"
		text += "YUnit"+'\t'+yunit+"\r\n"
		text += "FreqValidMax"+'\t'+freqvalidmax+"\r\n"
		text += "FreqValidMin"+'\t'+freqvalidmin+"\r\n"
		text += "TimeString"+'\t'+timestring+"\r\n"
		text += "Y"+"\r\n"
		count = 0
		with open(origin_data_path,'r') as data_input:
			for line in data_input:
				line = line.strip()
				count += 1
				text +=	line
				if count %2 ==1:
					seq = '\t'
				else:
					seq = '\r\r\n'
				text += seq
		data_output.write(text)
		data_output.close()
	data_input.close()
 
if __name__=='__main__':
	origin_data_path = sys.argv[1]
	origin_csv_path = sys.argv[2]
	save_path = sys.argv[3]
	#print origin_data_path
	#print origin_csv_path
	#print save_path
	

	input_center = ""
	xdelta = ""
	read_csv()
	#print input_center
	#print xdelta
	convert_origin_to_result()
