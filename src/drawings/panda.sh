prompt_path_cl="34"
prompt_git_cl="32"

drawing1=(
  '                        '
  '      ▨                 '
  '     ▄▒▒███▄            '
  '    ████~~~██▄▄         '
  '  ▄████*▒▒@▒████        '
  '  ███████**█▀▀▀         '
  '  ▒▒▒▒▒▒▒▒▒_____║       '
  '  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒║       '
  '  ████████^^^^  ┇       '
  '  ████████      ║       '
  '  ████~~▒▒▒□□▤  ┇       '
  '   ^^^^▒▒▒▒▒▒▒▒ ║       '
  '          ^^^^          '
  '                        '
)

drawing2=(
  '        ║               '
  '        ┇               '
  '    ║   ║  ║            '
  '    ┇   ║  ┇            '
  '    ║   ┇  ║            '
  '    ║   ║  ║            '
  '    ┇   ║  ┇            '
  '    ║   ┇ ║     ┇       '
  '  ║ ┇   ║ ┇     ║       '
  '  ┇ ║,  ║ ║ |, |┇  ║    '
  '  ║ ║ |,┇ ║ ,||,║,,┇    '
  ',          ""     """   '
  '    """                 '
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
    str=${str//">"/"\033[1;34m"}
    str=${str//"+"/"\033[34m"}
    str=${str//"!"/"\033[1;37m"}

    str=${str//"*"/"\033[47m\033[30m▀"}
    str=${str//"~"/"\033[47m\033[30m▄"}
    str=${str//"█"/"\033[0m\033[37m█"}
    str=${str//"▒"/"\033[30m█"}
    str=${str//"║"/"\033[0;32m║"}
    str=${str//"┇"/"\033[2;32m║"}
    str=${str//"▨"/"\033[0m\033[30m▄"}
    str=${str//"□"/"\033[40m\033[1;30m▀"}
    str=${str//"▤"/"\033[0m\033[1;30m▄"}
    str=${str//"|"/"\033[2;33m█"}
    str=${str//"\""/"\033[2;33m▀"}
    str=${str//","/"\033[2;33m▄"}
    str=${str//"_"/"\033[2;37m▄"}
    str=${str//"@"/"\033[36m█"}
    str=${str//"^"/"\033[0m\033[30m▀"}
    str="$str\033[0m"
  fi

  echo $str
}
