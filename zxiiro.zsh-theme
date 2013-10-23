#############################################################################
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#############################################################################

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}✈"

function showgit() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    gitinfo="$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$( git_prompt_status )%{$fg[white]%B%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    text=" %B<$gitinfo>%b"
    echo $text
}

function showloc() {
    hostname=$(who am i | cut -f2 -d\( | cut -f1 -d\))
    echo $hostname
}

# Set a random colour if logged in via ssh
function setloccolour() {
    text="%{$reset_color%}"
    hostname=`hostname`
    if [ ! -f "$HOME/.zxiiro-theme/sshcolor-$hostname" ]
    then
        mkdir $HOME/.zxiiro-theme
        echo `shuf -i 133-163 -n 1` > "$HOME/.zxiiro-theme/sshcolor-$hostname"
    fi
    SSHCOLOR=`cat "$HOME/.zxiiro-theme/sshcolor-$hostname"`

    if [ -n "$SSH_CLIENT" ]
    then
        text="%{$FG[$SSHCOLOR]%}"
    fi
    echo $text
}

PROMPT=$'
%{$fg[red]%}/--{%{$reset_color%}[%!]%(!.%UROOT%u.%n)@%{$(setloccolour)%}%m%{$reset_color%}:%l%{$fg[red]%}}----{%{$reset_color%}%~%{$fg[red]%}}--
| %{$reset_color%}%T$(showgit)%{$fg[red]%} %#%{$reset_color%} '
PS2=$'%{$fg[red]%}| %{$fg[blue]%}%B>%b%{$reset_color%} '
RPS1='%D{%Y-%m-%d}'

