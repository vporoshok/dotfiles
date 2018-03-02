#!/bin/sh

remote="$1"
url="$2"

z40=0000000000000000000000000000000000000000

IFS=' '
while read local_ref local_sha remote_ref remote_sha
do
	if [ "$local_sha" = $z40 ]
	then
		# Handle delete
        exit 1
	else
		if [ "$remote_sha" = $z40 ]
		then
			# New branch, examine all commits
			range="$local_sha"
		else
			# Update to existing branch, examine new commits
			range="$remote_sha..$local_sha"
		fi

		# Show all TODO: in diff and show confirm
		todos=`git diff "$range" | grep -v '^+ .* TODO:'`
		if [ -n "$todos" ]
		then
			echo "Found TODOs:"
            echo $todos
            read -r -p "Push anyway? [y/N] " input

            case $input in
            [yY][eE][sS]|[yY])
                exit 0
            ;;

            *)
                exit 1
            ;;
            esac
		fi
	fi
done

exit 0
