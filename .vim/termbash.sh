
alias tabe='function __tabe() { printf [\"$PWD/$1\",$PPID]"\n" > /dev/tcp/127.0.0.1/23333; }; __tabe'
