origin_dir="all_data"
result_dir="save_data"
save_pre="new_save_"
#################################
# select the txt and csv

generate_data()
{
	
	txt_file_pre_name=`ls $1 |grep .txt|awk -F "." '{print $1}' `
	for each in $txt_file_pre_name
	do
		each_data=`ls $1 |grep .txt |grep $each`
		each_csv=`ls $1 |grep .csv|grep $each`
		if [ -z "$each_data" ] ||[ -z "$each_csv" ];
		then
			echo $each" csv file  not exsit!!!"
		continue
	fi
	
	each_data_path=$1"/"$each_data
	each_csv_path=$1"/"$each_csv
	each_save_path=$result_dir"/"$1"/"$save_pre$each_data
	
	save_dir_path=${each_save_path%/*}
	
	mkdir -p $save_dir_path
	python convert.py $each_data_path $each_csv_path $each_save_path 
	echo $each_save_path" generate success!!!\n"
	#echo $each_data_path
	#echo $each_csv_path
	#echo $each_save_path
	#echo $save_dir_path
done
	
}
list_alldir(){
for file2 in `ls -a $1`
do
	if [ x"$file2" != x"." -a x"$file2" != x".." ];then
		if [ -d "$1/$file2" ];then
			files=`ls "$1/$file2"|grep .txt`
			if [ x"$files" != x ];then
				generate_data "$1/$file2"
			fi 
			list_alldir "$1/$file2"
		fi
	fi
done
}
list_alldir $origin_dir




exit 0
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
