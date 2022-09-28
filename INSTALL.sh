
draw_header() {
  text=$1

  if [ "$text" = "" ]; then
    text='BASH INIT'
  fi

  cl() {
    cls=("1" "2" "3" "4" "5" "6" "7")
    cl_num=$[ $RANDOM % 7 ]
    end_cl=${cls[$cl_num]}

    echo "\033[$1${end_cl}m"
  }

  echo ''
  echo -ne "    \033[0m$(cl 3)░$(cl 3)▒$(cl 3)▓"
  echo -ne "\033[30m$(cl 4) $(cl 4) $(cl 4) $(cl 4)$text$(cl 4) $(cl 4) $(cl 4) "
  echo -ne "\033[0m$(cl 3)▓$(cl 3)▒$(cl 3)░"
  end
  echo ''
}

draw_center() {
  str=$1

  ((window_width=45))
  ((x=$window_width/2-${#str}/2))

  res=$str

  for (( i=0; i < ${x}; ++i )); do
    res="$res "
  done

  echo -e "$res"
}

end() {
  echo -e "\033[0m"
}

draw_header

draw_center "\033[1;31mI will install all the themes"
draw_center "\033[2;31mBut don't worry. Our heaviest theme is 2.0 KB"
echo ''
draw_center "\033[0;34mSelect a theme to be the first you will use:"

for entry in "src/drawings"/*
do
  name=$entry
  name=${name//"src/drawings/"/""}
  name=${name//".sh"/""}

  draw_center "\033[33m$name"
done
end

echo -ne '\033[2;34m>\033[0m '
read choosed_drawing

draw_header 'INSTALLING...'

echo $choosed_drawing> "src/current-drawing.txt"

if [ ! -d "$HOME/my-path" ]; then mkdir "$HOME/my-path"; fi
if [ ! -d "$HOME/my-path/bash-init" ]; then mkdir "$HOME/my-path/bash-init"; fi

cp -r src/* "$HOME/my-path/bash-init/"
chmod +x "$HOME/my-path/bash-init/bash-init.sh"
mv "$HOME/my-path/bash-init/bash-init.sh" "$HOME/my-path/bash-init/bash-init"

bashrc=(
  ''
  '# BASH INIT'
  'if [ -d "$HOME/my-path/bash-init" ]; then'
  '  PATH="$HOME/my-path/bash-init:$PATH"'
  'fi'
  ''
  '. bash-init $0'
  "PS1='\$(set_prompt)'"
  ''
)

for line in "${bashrc[@]}"; do
  echo $line >> "$HOME/.bashrc"
done
