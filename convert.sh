origin_dir="origin_data"
save_dir="result_data"
save_pre="new_save_"
#################################
# select the txt and csv

txt_file_pre_name=`ls $origin_dir |grep .txt|awk -F "." '{print $1}' `
for each in $txt_file_pre_name
do
	each_data=`ls $origin_dir |grep .txt |grep $each`
	each_csv=`ls $origin_dir |grep .csv|grep $each`
	if [ -z "$each_data" ] ||[ -z "$each_csv" ];
	then
		echo $each" csv file  not exsit!!!"
		continue
	fi
	
	each_data_path=$origin_dir"/"$each_data
	each_csv_path=$origin_dir"/"$each_csv
	each_save_path=$save_dir"/"$save_pre$each_data
	
	python convert.py $each_data_path $each_csv_path $each_save_path 
	echo $each_save_path" generate success!!!"
done
#################################
