#!/usr/bin/env zsh

dry_run=false
steps_directory="$(pwd)/steps"

if [[ $1 == "-h" || $1 == "--help" ]]; then
	echo "You can add --dry to have a dry run"
	exit 0
fi

if [[ $1 == "--dry" ]]; then
	dry_run=true
fi

log() {
	if $dry_run; then
		echo "[DRY RUN]: $1"
	else
		echo "$1"
	fi
}

for file in $steps_directory/* ; do
	log "Step $(basename $file)"
	if $dry_run; then
		log "$(cat $file)"
	else
		source $file
	fi
	log "---"
done
