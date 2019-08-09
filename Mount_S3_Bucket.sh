#!/bin/bash
echo " ##### Finding the existence of s3fs package in your Machine #####"
if [[ -e /usr/bin/s3fs ]]; then
  echo " #### s3fs is Available #### "
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
          sudo mkdir /$direc
          read -p "Enter the s3 bucket name : " s3_name
          s3fs $s3_name /$direc -o passwd_file=${HOME}/.passwd-s3fs
          break
          ;;
          2)
            echo " ### Skipping Setup of S3 ### "
            break
           ;;
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
          sudo mkdir /$direc
          read -p "Enter the s3 bucket name : " s3_name
          s3fs $s3_name /$direc -o passwd_file=${HOME}/.passwd-s3fs
          break
          ;;
          2)
            echo " ### Skipping Setup of S3 ### "
            break
           ;;
         esac
     done
  fi
  cd /$direc
  
  
