# rad-sftp-sync
Download or Upload file to remote in Vim

Installation
----

Install using [vim-plug],[bundle],[vundle],[pathogen] or your favorite Vim package manager.

Usage
----

create an executable file .rsync in your root project directory.

    <leader>ru
    will execute  project_dir/.rsync and upload current buffer file

    <leader>rd
    will execute  project_dir/.rsync and download current buffer file

rsync file example
----
3 argument will be passed to the executable command : 
* $1 a string : "upload" or "download"
* $2 the path from the root to the buffer 
ps : $2 will be empty if the file is in the root directory so $2 will be $3
* $3 the buffer file name
<pre>
#!/bin/sh

userid='user_id@host'
key='path_to_the_private_key'  # in this case the private key must not have passphrase
path='remote_server_path'


if [ "upload" == $1 ];then
	if [ -z "$3" ];then
		echo put $2 $path/$2 | sftp -i $key $remote
	else
		echo put $2/$3 $path/$2/$3 | sftp -i $key $remote
	fi
elif [ 'download' == $1 ];then
	if [ -z "$3" ];then
		echo get $path/$2 $2 | sftp -i $key $remote
	else
		echo get $path/$2/$3 $2/$3 | sftp -i $key $remote
	fi
fi
</pre>
