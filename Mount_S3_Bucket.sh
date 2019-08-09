#!/bin/bash
echo " ##### Finding the existence of s3fs package in your Machine #####"
if [[ -e /usr/bin/s3fs ]]; then
  echo " #### s3fs is Available #### "
  while :
  do
  clear
      echo " What do you want to do? "
      echo " 1)Mount S3 with New Password File on New Directory"
      echo " 2)Mount S3 with Old Password File on New Directory"
      echo " 3)Mount S3 with Old Password File & Existing Directory"
      echo " 4)Exit"
      read -p "Select an option [1-4]: " option
         case $option in
         1)
            echo " ### Mounting S3 ### "
            read -p "Enter ACCESS_KEY_ID : " key_id
            read -p "Enter SECRET_ACCESS_KEY : " access_key
            read -p "Enter Path to save passwd file : " path
            echo $key_id:$access_key > $path/.passwd-s3fs &> Setup_Errors.txt
            sudo chmod 600 $path/.passwd-s3fs
            read -p "Enter the directory path or name to mount s3 : " direc
            mkdir $direc
            read -p "Enter the s3 bucket name : " s3_name
            read -p "Enter the region name : " region
            s3fs $s3_name /$direc -o passwd_file=${HOME}/.passwd-s3fs -o url=https://s3-$region.amazonaws.com &>> Setup_Errors.txt
            break
            ;;
          2)
            echo " ### Mounting S3 ### "
            read -p "Enter Path for saved passwd file : " path
            read -p "Enter the directory name to mount s3 : " direc
            mkdir $direc
            read -p "Enter the s3 bucket name : " s3_name
            read -p "Enter the region name : " region
            s3fs $s3_name /$direc -o passwd_file=$path/.passwd-s3fs -o url=https://s3-$region.amazonaws.com
            df -Th
            ;;
          3)
            echo " ### Mounting S3 ### "
            read -p "Enter Path for saved passwd file : " path
            read -p "Enter the directory name to mount s3 : " direc
            read -p "Enter the s3 bucket name : " s3_name
            read -p "Enter the region name : " region
            s3fs $s3_name /$direc -o passwd_file=$path/.passwd-s3fs -o url=https://s3-$region.amazonaws.com
            ;;
           4)
            echo " ######## Exiting from Setup ######## "
         esac
     done
else
  echo " #### Installing s3fs #### "
  sudo apt install s3fs -y
  while :
  do
  clear
      echo " Do you want to mount s3bucket "
      echo " 1)Yes"
      echo " 2)No"
      read -p "Select an option [1-2]: " option
       case $option in
         1)
          read -p "Enter ACCESS_KEY_ID : " key_id
          read -p "Enter SECRET_ACCESS_KEY : " access_key
          echo $key_id:$access_key > ${HOME}/.passwd-s3fs
          sudo chmod 600 ${HOME}/.passwd-s3fs
          read -p "Enter the directory name to mount s3 : " direc
          mkdir $direc
          read -p "Enter the s3 bucket name : " s3_name
          read -p "Enter the region name : " region
          s3fs $s3_name /$direc -o passwd_file=${HOME}/.passwd-s3fs -o url=https://s3-$region.amazonaws.com
          df -Th
          break
          ;;
         2)
           echo " ### Skipping Setup of S3 ### "
           break
           ;;
         esac
     done
  fi
  
# if you want to identify the error's add this "-o dbglevel=info -f -o curldbg" to the s3fs command.
