# Import Agave runtime extensions
. _lib/extend-runtime.sh

# Allow CONTAINER_IMAGE over-ride via local file
if [ -z "${CONTAINER_IMAGE}" ]
then
    if [ -f "./_lib/CONTAINER_IMAGE" ]; then
        CONTAINER_IMAGE=$(cat ./_lib/CONTAINER_IMAGE)
    fi
    if [ -z "${CONTAINER_IMAGE}" ]; then
        echo "CONTAINER_IMAGE was not set via the app or CONTAINER_IMAGE file"
        CONTAINER_IMAGE="sd2e/base:ubuntu17"
    fi
fi

# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a



COMMAND=" ThermoRawFileParser "
PARAMS=" "

if [ -n "${raw_file}" ];
then
	PARAMS="${PARAMS} --input=${raw_file} "

elif [ -n "${raw_directory}" ];
then
	PARAMS="${PARAMS} --input_directory=${raw_directory} "

else
	echo "Error: must specify either an input file or input directory"
	return
fi


if [ -n "${out_file}" ];
then
	PARAMS="${PARAMS} --output_file=${out_file} "

elif [ -n "${out_directory}" ];
then
	PARAMS="${PARAMS} --output=${out_directory} "

else
	echo "Error: must specify either an output file or output directory"
	return
fi

if [ -n "${format}" ];
then
	PARAMS="${PARAMS} --format=${format} "
else
	PARAMS="${PARAMS} --format=1 "
fi

#mkdir -p ./output/
container_exec ${CONTAINER_IMAGE} ${COMMAND} ${PARAMS}

