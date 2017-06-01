function! FindSyncFile()
	if '.rsync' == expand('%:t')
		return "rsync"
	endif
	let l:file_path = expand('%:p:h')
	let l:path_to_sync = l:file_path . '/.rsync'

	let l:parts = split(l:file_path,"/")
	let l:length = len(l:parts)
	while !filereadable(l:path_to_sync)
		if l:length - 1 > 0
			let l:new_folder = l:parts[0:l:length-2]
			let l:file_path = '/'.join(l:new_folder,"/")
			let l:path_to_sync = l:file_path . '/.rsync'
			let l:length = l:length - 1
		else
			let l:file_path = ""
			break
		endif	
	endwhile
	return l:file_path
endfunction

function! Rsync(command)
	let file_path = fnameescape(FindSyncFile())
	 if file_path == "rsync"
		echo "you cannot " . a:command ." .rsync file"
	elseif (!empty(file_path))
		let path_to_sync = file_path ."/.rsync"
		let file = expand('%:t')
		let root = substitute(expand('%:p:h'), file_path."/", "", "")
		if root == expand("%:p:h")
			let root = ""
		endif
		execute '!' . path_to_sync.' ' . a:command.' '. fnameescape(root)." ". file
	else
		echo ".rsync file not found or not readable"
	endif
endfunction

nmap <leader>ru :call Rsync("upload")<CR>
nmap <leader>rd :call Rsync("download")<CR>

