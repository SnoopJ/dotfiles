# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


function irclog() {
        usage="irclog -- helper function to search IRC logs.  Passes all flags to ag.  Use -G mask to search against a glob"

        if [ -z "$1" ]
        then
                echo $usage;
                return;
        fi

        local OPTIND opt a
        while getopts ":h" opt; do
          case $opt in
            h)
              echo "$usage"
              return
              ;;
          esac
        done

        ag -i "$@" ~/irclogs;
}

