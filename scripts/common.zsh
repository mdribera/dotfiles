# Functions used in lots o' places
info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] $1\n"
  echo ""
  [ ! $PS1 ] && exit 1
  return 1
}

# Create a new directory and enter it
mkd () {
	mkdir -p "$@"
	cd "$@"
}

# Whois lookup on a domain
whois () {
	local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
	if [ -z $domain ] ; then
		domain=$1
	fi
	echo "Getting whois record for: $domain …"

	/usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

# Print Finder Directory
pfd () {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

# cd to current finder directory
cdf () {
  cd "$(pfd)"
}
