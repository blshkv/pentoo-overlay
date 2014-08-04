#!/bin/bash
#work around for detecting and fixing bug #461824

CORES="$(grep -c ^proc /proc/cpuinfo)"
if [[ "${CORES}" -eq "0" ]] ; then CORES="1" ; fi

find /etc {/usr,}/{*bin,lib*} -type f | xargs -P ${CORES} fgrep '_portage_rebuild_' | fgrep -v doebuild > /tmp/urfuct.txt
if [ -n "$(cat /tmp/urfuct.txt)" ]; then
	for badhit in $(cat /tmp/urfuct.txt) ; do
		echo ${badhit} | cut -d":" -f1 >> /tmp/badfiles.txt
	done
	qfile -C -f /tmp/badfiles.txt | cut -d' ' -f1 >> /tmp/badpkg_us.txt
	cat /tmp/badpkg_us.txt | sort -u > /tmp/badpkg.txt
	emerge -1 --buildpkg=y --nodeps $(cat /tmp/badpkg.txt) || /bin/bash
	rm -f /tmp/urfuct.txt /tmp/badfiles.txt /tmp/badpkg_us.txt /tmp/badpkg.txt
fi
