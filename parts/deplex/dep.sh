#!/bin/bash

UNAME=$(whoami)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# check do we have Duplex details [Fist Init]
if [ ! -d $DIR/.conf ]
	then
		mkdir $DIR/.conf
fi

#detect are we in Guest mode
if [[ $UNAME =~ .*uest.* ]]
then
	INS_DIR="/tmp/$UNAME/Desktop/"
	SUB_DIR="/tmp/$UNAME/sublime/"
else
	INS_DIR="/opt/"
	SUB_DIR="/home/$UNAME/sublime/"
fi

#check is requested deplex
if [ -z "$1" ];
	then
	me=`basename $0`
	echo "Select Deployed system '$me sample-details'"
	exit;
else
	echo "Cloning '$1'"
fi


if [ ! -d $DIR/.conf/$1 ]
	then
		(
			#Check is it in HG
			cd  $INS_DIR
			#https://bitbucket.org/greenbox/portable-install
			hg clone https://bitbucket.org/greenbox/$1

			if [ -d $INS_DIR/$1 ]
				then

				#in case if HG is working we need to check : is there a project file in
				if [ ! -f $INS_DIR/$1/$1.sublime-project ]
					then
					mkdir $DIR/.conf/$1
					echo "0" > $DIR/.conf/$1/.rsinc
					echo "https://bitbucket.org/greenbox/$1" > $DIR/.conf/$1/.hg

					mkdir $INS_DIR/$1
					echo "0" > $INS_DIR/$1/.rsinc
					cp $DIR/prospect.s-p $INS_DIR/$1/$1.sublime-project

					sed -i "s+RSYNC_STATUS+0+g" $INS_DIR/$1/$1.sublime-project
					INC_PATH="$INS_DIR/$1"
					sed -i "s+INC_PATH+$INC_PATH+g" $INS_DIR/$1/$1.sublime-project

					hg add $INS_DIR/$1/$1.sublime-project

					$SUB_DIR/sublime_text --project $INS_DIR/$1/$1.sublime-project

				fi

				exit 1;
			fi

			#Check is it in rSync Sources
			if [ ! -d $DIR/.conf/$1 ]
				then

				if [ -f $DIR/.conf/.rsincs ]
					then

					rsync_list=$DIR/.conf/.rsincs
					while read -r line
					do
					    ssh_line=$line
					    (
					    	echo "doing scp -r $ssh_line:/sd-ext/fs/$1 $INS_DIR/$1"
					    	if scp -r $ssh_line:/sd-ext/fs/$1 $INS_DIR/$1 2>/dev/null ; then
							    echo 'done '
							else
							    echo 'damn, there was an error'
							fi
					    )

					   if [ -d $INS_DIR/$1 ]
							then

							if [ ! -f $INS_DIR/$1/$1.sublime-project ]
								then
								mkdir $DIR/.conf/$1
								echo "1" > $DIR/.conf/$1/.rsinc
								echo "1" > $INS_DIR/$1/.rsinc
								
								cp $DIR/prospect.s-p $INS_DIR/$1/$1.sublime-project

								sed -i "s+RSYNC_STATUS+0+g" $INS_DIR/$1/$1.sublime-project
								INC_PATH="$INS_DIR/$1"
								sed -i "s+INC_PATH+$INC_PATH+g" $INS_DIR/$1/$1.sublime-project

								RSYNC_PATH="$DEP_LOC/sd-ext/fs/$1"
								sed -i "s+RSYNC_PATH+$RSYNC_PATH+g" $INS_DIR/$1/$1.sublime-project

								#copy project on server
								scp $INS_DIR/$1/$1.sublime-project $ssh_line:/sd-ext/fs/$1/

								$SUB_DIR/sublime_text --project $INS_DIR/$1/$1.sublime-project

							fi


							exit 2;
						fi

					done < "$rsync_list"
				else
					echo "rSync not defined"	
				fi
			fi

			#project not found anyWhere : build from scrach + deploy to system

			DEP_LOC=''
			DEP_STATE=0

			(
				while read -r line
					do
				    ssh_line=$line
				    (
				    	echo "doing ssh -t $ssh_line"
				    	if ssh -t $ssh_line "/sd-ext/mkproject.sh $1 && bash" 2>/dev/null ; then
						    DEP_LOC=$ssh_line
							DEP_STATE=1
							echo "UPdated '$DEP_LOC' '$DEP_STATE' "


							if [ ! -d $INS_DIR/$1 ]
								then
								#building directory and details

								echo "DEP_LOC $DEP_LOC"

								mkdir $DIR/.conf/$1

								echo "$DEP_LOC" > $DIR/.conf/$1/.rsinc

								mkdir $INS_DIR/$1

								echo "$DEP_LOC" > $INS_DIR/$1/.rsinc
								cp $DIR/prospect.s-p $INS_DIR/$1/$1.sublime-project

								sed -i "s+RSYNC_STATUS+$DEP_STATE+g" $INS_DIR/$1/$1.sublime-project
								RSYNC_PATH="$DEP_LOC:/sd-ext/fs/$1"
								sed -i "s+RSYNC_PATH+$RSYNC_PATH+g" $INS_DIR/$1/$1.sublime-project
								INC_PATH="$INS_DIR/$1"
								sed -i "s+INC_PATH+$INC_PATH+g" $INS_DIR/$1/$1.sublime-project

								$SUB_DIR/sublime_text --project $INS_DIR/$1/$1.sublime-project

							fi
							exit;
						else
						    echo 'damn, there was an error'
						fi
				    )

				done < "$rsync_list"
			)

			if [ ! -d $INS_DIR/$1 ]
				then
				#building directory and details

				echo "DEP_LOC $DEP_LOC"

				mkdir $DIR/.conf/$1

				echo "$DEP_LOC" > $DIR/.conf/$1/.rsinc

				mkdir $INS_DIR/$1

				echo "$DEP_LOC" > $INS_DIR/$1/.rsinc
				cp $DIR/prospect.s-p $INS_DIR/$1/$1.sublime-project

				sed -i "s+RSYNC_STATUS+$DEP_STATE+g" $INS_DIR/$1/$1.sublime-project
				RSYNC_PATH="$DEP_LOC/sd-ext/fs/$1"
				sed -i "s+RSYNC_PATH+$RSYNC_PATH+g" $INS_DIR/$1/$1.sublime-project
				INC_PATH="$INS_DIR/$1"
				sed -i "s+INC_PATH+$INC_PATH+g" $INS_DIR/$1/$1.sublime-project

				$SUB_DIR/sublime_text --project $INS_DIR/$1/$1.sublime-project

			fi
			exit 3;

		) 

		echo "Exited with Code '$?'" 

fi
