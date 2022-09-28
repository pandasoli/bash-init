
draw_header() {
  cl() {
    cls=("1" "2" "3" "4" "5" "6" "7")
    cl_num=$[ $RANDOM % 7 ]
    end_cl=${cls[$cl_num]}

    echo "\033[$1${end_cl}m"
  }

  echo ''
  echo -ne "    \033[0m$(cl 3)░$(cl 3)▒$(cl 3)▓"
  echo -ne "\033[30m$(cl 4) $(cl 4) $(cl 4) $(cl 4)B$(cl 4)A$(cl 4)S$(cl 4)H$(cl 4) $(cl 4)I$(cl 4)N$(cl 4)I$(cl 4)T$(cl 4) $(cl 4) $(cl 4) "
  echo -ne "\033[0m$(cl 3)▓$(cl 3)▒$(cl 3)░"
  end
  echo ''
}

end() {
  echo -e "\033[0m"
}

drawing() {
  # Validating if drawing exists
  current_drawing=$(cat $prog_path/current-drawing.txt)

  if [ ! -f "$prog_path/drawings/$current_drawing.sh" ]; then
    draw_header;

    echo -e "\033[31mNot found '\033[0m$current_drawing\033[31m' drawing"
    end
    return
  fi

  # Importing drawing
  . "$prog_path/drawings/$current_drawing.sh"


  # Sleep for some seconds
  sleep 0.1


  # Load infos
  os=$(cat /etc/*-release | grep 'DISTRIB_ID=' $os_infos | sed 's/DISTRIB_ID=//g' | sed 's/["]//g' | awk '{print $0}')
  os="$os "$(cat /etc/*-release | grep 'VERSION=' $os_infos | sed 's/VERSION=//g' | sed 's/["]//g' | awk '{print $0}')

  vkernel=$(uname -r)
  desktop_environment=$XDG_CURRENT_DESKTOP
  packages_count=$(dpkg -l | wc -l)

  total_ram_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  total_ram_mb=$(expr $total_ram_kb / 1024)

  free_ram_kb=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  free_ram_mb=$(expr $free_ram_kb / 1024)

  total_disk=$(df -h --output=source,size,avail | grep '/dev/sda3' | awk '{print $2}')
  free_disk=$(df -h --output=source,size,avail | grep '/dev/sda3' | awk '{print $3}')


  # Printing functions
  printxy() {
    x=$1
    y=$2
    str="$3"

    tput cup $y $x
    echo -e "$str"
  }

  draw_center() {
    y=$2
    str=$(replace_colors r "$1")

    window_width=$(tput cols)

    ((x=$window_width/2-${#str}/2))

    res=$(replace_colors a "$1")
    printxy $x $y "$res"
  }


  # Rendering all
  draw_center "!Panda' +OS" 1
  draw_center "$os" 3

  draw_center ">Kernel: ${vkernel}" 5
  draw_center ">Desktop >environment: ${desktop_environment}" 6
  draw_center ">Shell: $1" 7
  draw_center ">Packages: $packages_count" 8
  draw_center ">RAM: +$free_ram_mb +MB / $total_ram_mb MB" 9
  draw_center ">Disk: +$free_disk / $total_disk" 10

  for (( i=0; i < ${#drawing1[@]}; ++i )); do
    line=${drawing1[$i]}
    line=$(replace_colors a "$line")
    printxy 4 $i "$line"
  done

  for (( i=0; i < ${#drawing2[@]}; ++i )); do
    line=${drawing2[$i]}
    line=$(replace_colors a "$line")
    ((x=$window_width-${#drawing2[$i]}-4))
    printxy $x $i "$line"
  done

  end
}

set_prompt() {
  is_there_git=$(git rev-parse --git-dir 2> /dev/null)

  dir=$(pwd)
  dir=${dir//"/home/$USER"/"~"}

  res="\033[1;${prompt_path_cl}m${dir} "

  if [ "$is_there_git" != "" ]; then
    git_branch=$(git branch --show-current)
    res="$res\033[1;${prompt_git_cl}m${git_branch} "
  fi

  res="$res"'\033[0m$ '

  echo -e "$res"
}

# prog_path="$HOME/my-path/bash-init"
prog_path="."


if [ "$1" = 'change' ]; then
  draw_header

  echo -e "Changening drawing to \033[34m$2\033[0m..."
  echo $2> "$prog_path/current-drawing.txt"
  echo -e "\033[32mAll done!"
  end
elif [ "$1" = '?' ]; then
  draw_header

  echo -e "Hii, we got only this command yet:"
  echo -e "  change \033[33m<drawing name>"
  end
else
  clear
  drawing $1
fi
