prompt_path_cl="32"
prompt_git_cl="36"


drawing1=(
  '               ▄▄▄▄▄     '
  '      ▄▄▄▄▄   █ █████    '
  '    ▄████  █ █   █ █     '
  '    █  █    █      █     '
  '       █   █    ▄        '
  '         ▄▄█ ██▀         '
  '      ██▀  █▀            '
  '     ██▀   █ ▄           '
  '           █▀            '
  '       $$$$$$$$$$#       '
  '        $$$$$$$$#        '
  '                         '
)


replace_colors() {
  method=$1
  str=$2

  if [ "$method" == "r" ]; then
    str=${str//"!"/""}
    str=${str//">"/""}
    str=${str//"+"/""}
  elif [ "$method" == "a" ]; then
    str=${str//" "/"\033[0m "}
    str=${str//"!"/"\033[1;37m"}
    str=${str//"+"/"\033[36m"}
    str=${str//">"/"\033[1;32m"}

    str=${str//"█"/"\033[32m█"}
    str=${str//"▄"/"\033[32m▄"}
    str=${str//"▀"/"\033[32m▀"}
    str=${str//"#"/"\033[2;36m█"}
    str=${str//"$"/"\033[36m█"}
    str="$str\033[0m"
  fi

  echo $str
}
