#!/bin/bash
set -eo pipefail

export LANG="pt_BR.UTF-8"

xauth(){
  if [ -n "${XAUTHORITY}" ] && [ -n "${HOST_HOSTNAME}" ]
  then
    if [ "${HOSTNAME}" != "${HOST_HOSTNAME}" ]
    then
      [ -f ${XAUTHORITY} ] || touch ${XAUTHORITY}
      xauth add ${HOSTNAME}/unix${DISPLAY} . \
      $(xauth -f /tmp/.docker.xauth list ${HOST_HOSTNAME}/unix${DISPLAY} | awk '{ print $NF }')
    else
      cp /tmp/.docker.xauth ${XAUTHORITY}
    fi
  fi
}

run() {
  xauth
  firefox -CreateProfile default
  sudo dpkg -i /warsaw_setup64.deb
  su -c "/etc/init.d/warsaw start"
  /usr/local/bin/warsaw/core
  firefox --private-window $1
}

run "https://www2.bancobrasil.com.br/aapf/login.jsp?aapf.IDH=sim&perfil=1"

exit 0

