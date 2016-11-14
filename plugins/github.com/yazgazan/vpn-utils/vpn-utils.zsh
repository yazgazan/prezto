#!/usr/bin/env zsh

VPN_MACHINE="vpn.yazou.org"
OVPN_DATA="ovpn-data"

function _vpn_add {
	local client_name=$1
	if [[ $client_name == "" ]]; then
		echo "Usage: $maincmd $subcmd <client name>" > /dev/stderr
		return 2
	fi
	shift

	docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $client_name nopass
	return $?
}

function _vpn_get {
	local client_name=$1
	if [[ $client_name == "" ]]; then
		echo "Usage: $maincmd $subcmd <client name>" > /dev/stderr
		return 2
	fi
	shift

	docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $client_name > $client_name.ovpn
	return $?
}

function _vpn_list {
	docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_listclients
	return $?
}

function _vpn_start {
	docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN --name="vpn" kylemanna/openvpn
	return $?
}

function _vpn_stop {
	docker stop vpn && docker rm vpn
	return $?
}

function _vpn_help {
	local errcode=$1

	(
		echo "Usage: $maincmd <CMD> [OPTS...]"
		echo "       $maincmd add <client name>"
		echo "       $maincmd get <client name>"
		echo "       $maincmd list"
		echo "       $maincmd start"
		echo "       $maincmd stop"
		echo "       $maincmd help"
		echo
	) > /dev/stderr
	if [[ $errcode != "" ]]; then
		return $errcode
	fi
}

function _vpn_cmd {
	local cmd=$1
	if [[ $cmd == "" ]]; then
		_vpn_help 2
		return $?
	fi
	shift

	if [[ $(docker-machine active) != $VPN_MACHINE ]]; then
		echo "Error: machine not set" > /dev/stderr
		return 1
	fi
	case $cmd in
		add)
			subcmd=$cmd _vpn_add $@
			;;
		get)
			subcmd=$cmd _vpn_get $@
			;;
		list)
			subcmd=$cmd _vpn_list
			;;
		start)
			subcmd=$cmd _vpn_start
			;;
		stop)
			subcmd=$cmd _vpn_stop
			;;
		help)
			subcmd=$cmd _vpn_help
			;;
		*)
			subcmd=$cmd _vpn_help 2
			;;
	esac
}

function vpn {
	(
		eval $(docker-machine env $VPN_MACHINE)
		maincmd=$0 _vpn_cmd $@ || return $?
	) || return $?
}

function _vpn {
	local -a opts args

	opts=(add get help)
}

