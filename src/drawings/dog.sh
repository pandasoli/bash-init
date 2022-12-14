prompt_path_cl="33"
prompt_git_cl="30"


drawing1=(
  '                         '
  '      ▄▄▀▀▀#▄▄           '
  '     █      "$#▄         '
  '    █ __    █$$$█        '
  '   ▄▀$█▄$  █$$$=▀        '
  '  ██  ""  █$$$=█         '
  '  ▀▄    ▄ ▀===#$█        '
  '    ▀▀▀▀ █$$$$"  ▀▀▄     '
  '        █           █    '
  '        █            █   '
  '         █   ▄       _█  '
  '        ▄▀  ▄█#▄▄▄▄#_$█  '
  '       █▄▄▄▀▄▄█======▀   '
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
    str=${str//">"/"\033[1;33m"}
    str=${str//"+"/"\033[33m"}
    str=${str//"!"/"\033[1;37m"}

    str=${str//"█"/"\033[0m\033[1;30m█"}
    str=${str//"▄"/"\033[0m\033[1;30m▄"}
    str=${str//"▀"/"\033[0m\033[1;30m▀"}
    str=${str//"$"/"\033[0m\033[33m█"}
    str=${str//"\""/"\033[0m\033[33m▀"}
    str=${str//"_"/"\033[0m\033[33m▄"}
    str=${str//"#"/"\033[43m\033[30m▀"}
    str=${str//"="/"\033[43m\033[30m▄"}
    str=${str//"$"/"\033[43m "}
    str="$str\033[0m"
  fi

  echo $str
}
