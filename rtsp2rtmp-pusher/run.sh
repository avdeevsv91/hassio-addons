#!/usr/bin/with-contenv bashio

set +e
pids=()

function message {
    echo "[$(basename ${BASH_SOURCE})] ${1}"
}

# Run ffmpeg(s)
for stream in $(bashio::config "streams|keys"); do
    SOURCE=$(bashio::config "streams[${stream}].source")
    TARGET=$(bashio::config "streams[${stream}].target")
    bashio::config.has_value "streams[${stream}].video" && VIDEO=$(bashio::config "streams[${stream}].video") || VIDEO="copy"
    bashio::config.has_value "streams[${stream}].audio" && AUDIO=$(bashio::config "streams[${stream}].audio") || AUDIO="copy"
    bashio::config.has_value "streams[${stream}].options" && OPTIONS=$(bashio::config "streams[${stream}].options") || OPTIONS=""
    ffmpeg -nostdin -loglevel error -i "${SOURCE}" ${OPTIONS} -vcodec "${VIDEO}" -acodec "${AUDIO}" -f flv "${TARGET}" &
    pids+=($!)
    message "new stream with PID = ${pids[-1]} has been started:"
    message "  source = ${SOURCE:-<not set>}"
    message "  target = ${TARGET:-<not set>}"
    message "  video = ${VIDEO:-<not set>}"
    message "  audio = ${AUDIO:-<not set>}"
    message "  options = ${OPTIONS:-<not set>}"
done

# Wait ffmpeg(s)
while :; do
    counter=0
    for i in ${!pids[@]}; do
        if [[ ${pids[$i]} -gt 0 ]]; then
            if kill -0 ${pids[$i]} > /dev/null 2>&1; then
                ((counter+=1))
            else
                message "stream with PID = ${pids[$i]} has been stopped."
                pids[$i]=0
            fi
            sleep 1
        fi
    done
    [ ${counter} -eq 0 ] && break
done
message "all streams are stopped."
