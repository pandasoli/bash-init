# Drawing
drawing() {
  sleep 0.1

  os=$(cat /etc/*-release | grep "DISTRIB_ID=" | sed 's/DISTRIB_ID=//g' | sed 's/["]//g' | awk '{print $1}')
  os="$os $(cat /etc/*-release | grep "VERSION=" | sed 's/VERSION=//g' | sed 's/["]//g' | awk '{print $1 $2 $3 $4}')"

  vkernel=$(uname -r)
  desktop_environment=$XDG_CURRENT_DESKTOP
  packages_count="$(dpkg -l | wc -l)"

  total_ram_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  total_ram_mb=$(expr $total_ram_kb / 1024)

  free_ram_kb=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  free_ram_mb=$(expr $free_ram_kb / 1024)

  total_disk=$(df -h --output=source,size,avail | grep "/dev/sda3" | awk '{print $2}')
  free_disk=$(df -h --output=source,size,avail | grep "/dev/sda3" | awk '{print $3}')

  animal=(
    ' #####             ##### '
    ' ######███████████###### '
    ' ##█#███████████████#█## '
    ' #█████████████████████# '
    '██████████#███#██████████'
    '████████####█####████████'
    '███████###@#█#@###███████'
    '██████######█######██████'
    ' ██████###█████###██████ '
    '  █████████████████████  '
    '    ███████###███████    '
    '      ██████#██████      '
    '        █████████        '
  )

  printxy() {
    x=$1
    y=$2
    str="$3"

    tput cup $y $x
    echo -e "$str"
  }

  replace_colors() {
    method=$1
    str=$2

    if [ "$method" == "r" ]; then
      str=${str//"!"/""}
      str=${str//"#"/""}
      str=${str//"@"/" "}
      str=${str//">"/""}
      str=${str//"%"/" "}
      str=${str//"&"/""}
      str=${str//"+"/""}
      str=${str//"W"/" "}
    elif [ "$method" == "a" ]; then
      str=${str//" "/"\033[0m "}
      str=${str//"!"/"\033[1;37m"}
      str=${str//"#"/"\033[40m "}
      str=${str//"@"/"\033[46m "}
      str=${str//">"/"\033[1;34m"}
      str=${str//"&"/"\033[36m"}
      str=${str//"+"/"\033[34m"}
      str=${str//"█"/"\033[47m "}
      str="$str\033[0m"
    fi

    echo $str
  }

  draw_center() {
    y=$2
    str=$(replace_colors r "$1")

    window_width=$(tput cols)

    ((x=$window_width/2-${#str}/2))

    res=$(replace_colors a "$1")
    printxy $x $y "$res"
  }

  draw_center "!Panda' &OS" 1
  draw_center "$os" 3

  draw_center ">Kernel: ${vkernel}" 5
  draw_center ">Desktop >environment: ${desktop_environment}" 6
  draw_center ">Shell: $0" 7
  draw_center ">Packages: $packages_count" 8
  draw_center ">RAM: +$free_ram_mb +MB / $total_ram_mb MB" 9
  draw_center ">Disk: +$free_disk / $total_disk" 10

  for (( i=0; i < ${#animal[@]}; ++i )); do
    line=${animal[$i]}
    line=$(replace_colors a "$line")
    printxy 4 $i "$line"
  done

  echo ""

  PS1='\[\033[1;34m\]\w '
  PS1="$PS1\[\033[0m\]\$ "
}
drawing $1
