#!/bin/bash

# common aliases
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lla='ll'
alias ls='ls --color=auto'

# common functions
portping () {
  if [[ -n "$1" && -n "$2" ]]; then
    while true; do
      nc -zvw1 "$1" "$2"
      sleep 1
    done
  else
    echo "Usage: portping <host> <port>"
  fi
}
sshcheck () {
  [[ -n "$1" ]] && portping "$1" 22
}
loop () {
  sec=1
  if  [ -n "${1##*[!1-9]*}" ] 2>/dev/null; then
    sec="$1"
    shift
  fi
  while true; do
    "$@"
    sleep "$sec"
    printf -- '--- %.0s' $(seq 1 $((COLUMNS / 4 ))); echo
  done
}

# helper functions
_kliases () {
  if command -v kubectl &>/dev/null; then
    ### k8s zsh alias dump
    alias k=kubectl
    source <(kubectl completion "$(ps -p $$ -o comm=)")
    complete -F __start_kubectl k
    alias kaf='kubectl apply -f'
    alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'
    alias kccc='kubectl config current-context'
    alias kcdc='kubectl config delete-context'
    alias kcgc='kubectl config get-contexts'
    alias kcn='kubectl config set-context --current --namespace'
    alias kcp='kubectl cp'
    alias kcsc='kubectl config set-context'
    alias kcuc='kubectl config use-context'
    alias kdcj='kubectl describe cronjob'
    alias kdcm='kubectl describe configmap'
    alias kdd='kubectl describe deployment'
    alias kdds='kubectl describe daemonset'
    alias kdel='kubectl delete'
    alias kdelcj='kubectl delete cronjob'
    alias kdelcm='kubectl delete configmap'
    alias kdeld='kubectl delete deployment'
    alias kdelds='kubectl delete daemonset'
    alias kdelf='kubectl delete -f'
    alias kdeli='kubectl delete ingress'
    alias kdelj='kubectl delete job'
    alias kdelno='kubectl delete node'
    alias kdelns='kubectl delete namespace'
    alias kdelp='kubectl delete pods'
    alias kdelpvc='kubectl delete pvc'
    alias kdels='kubectl delete svc'
    alias kdelsa='kubectl delete sa'
    alias kdelsec='kubectl delete secret'
    alias kdelss='kubectl delete statefulset'
    alias kdi='kubectl describe ingress'
    alias kdj='kubectl describe job'
    alias kdno='kubectl describe node'
    alias kdns='kubectl describe namespace'
    alias kdp='kubectl describe pods'
    alias kdpvc='kubectl describe pvc'
    alias kdrs='kubectl describe replicaset'
    alias kds='kubectl describe svc'
    alias kdsa='kubectl describe sa'
    alias kdsec='kubectl describe secret'
    alias kdss='kubectl describe statefulset'
    alias kdumpall='kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found --all-namespaces'
    alias kecj='kubectl edit cronjob'
    alias kecm='kubectl edit configmap'
    alias ked='kubectl edit deployment'
    alias keds='kubectl edit daemonset'
    alias kei='kubectl edit ingress'
    alias kej='kubectl edit job'
    alias keno='kubectl edit node'
    alias kens='kubectl edit namespace'
    alias kep='kubectl edit pods'
    alias kepvc='kubectl edit pvc'
    alias kers='kubectl edit replicaset'
    alias kes='kubectl edit svc'
    alias kess='kubectl edit statefulset'
    alias keti='kubectl exec -t -i'
    alias kga='kubectl get all'
    alias kgaa='kubectl get all --all-namespaces'
    alias kgcj='kubectl get cronjob'
    alias kgcm='kubectl get configmaps'
    alias kgcma='kubectl get configmaps --all-namespaces'
    alias kgd='kubectl get deployment'
    alias kgda='kubectl get deployment --all-namespaces'
    alias kgds='kubectl get daemonset'
    alias kgdsa='kubectl get daemonset --all-namespaces'
    alias kgdsw='kgds --watch'
    alias kgdw='kgd --watch'
    alias kgdwide='kgd -o wide'
    alias kgi='kubectl get ingress'
    alias kgia='kubectl get ingress --all-namespaces'
    alias kgj='kubectl get job'
    alias kgno='kubectl get nodes'
    alias kgns='kubectl get namespaces'
    alias kgp='kubectl get pods'
    alias kgpa='kubectl get pods --all-namespaces'
    alias kgpall='kubectl get pods --all-namespaces -o wide'
    alias kgpl='kgp -l'
    alias kgpn='kgp -n'
    alias kgpvc='kubectl get pvc'
    alias kgpvca='kubectl get pvc --all-namespaces'
    alias kgpvcw='kgpvc --watch'
    alias kgpw='kgp --watch'
    alias kgpwide='kgp -o wide'
    alias kgrs='kubectl get replicaset'
    alias kgs='kubectl get svc'
    alias kgsa='kubectl get svc --all-namespaces'
    alias kgsec='kubectl get secret'
    alias kgseca='kubectl get secret --all-namespaces'
    alias kgss='kubectl get statefulset'
    alias kgssa='kubectl get statefulset --all-namespaces'
    alias kgssw='kgss --watch'
    alias kgsswide='kgss -o wide'
    alias kgsw='kgs --watch'
    alias kgswide='kgs -o wide'
    alias kl='kubectl logs'
    alias kl1h='kubectl logs --since 1h'
    alias kl1m='kubectl logs --since 1m'
    alias kl1s='kubectl logs --since 1s'
    alias klf='kubectl logs -f'
    alias klf1h='kubectl logs --since 1h -f'
    alias klf1m='kubectl logs --since 1m -f'
    alias klf1s='kubectl logs --since 1s -f'
    alias kpf='kubectl port-forward'
    alias krh='kubectl rollout history'
    alias krsd='kubectl rollout status deployment'
    alias krsss='kubectl rollout status statefulset'
    alias kru='kubectl rollout undo'
    alias ksd='kubectl scale deployment'
    alias ksss='kubectl scale statefulset'
    ### k8s zsh dump
  fi
}
_tmuxcfg () {
  if [[ ! -e "$HOME/.tmux.conf" ]] && command -v tmux &>/dev/null; then
    sed 's/^ *//' > "$HOME/.tmux.conf" << EOF
      set-option -g activity-action other
      set-option -g assume-paste-time 1
      set-option -g base-index 0
      set-option -g bell-action any
      set-option -g default-command ''
      set-option -g default-shell /bin/bash
      set-option -g default-size 80x24
      set-option -g destroy-unattached off
      set-option -g detach-on-destroy on
      set-option -g display-panes-active-colour red
      set-option -g display-panes-colour blue
      set-option -g display-panes-time 1000
      set-option -g display-time 750
      set-option -g history-limit 250000
      set-option -g key-table root
      set-option -g lock-after-time 0
      set-option -g lock-command "lock -np"
      set-option -g message-command-style bg=black,fg=yellow
      set-option -g message-style bg=yellow,fg=black
      set-option -g mouse on
      set-option -g prefix C-b
      set-option -g prefix2 None
      set-option -g renumber-windows off
      set-option -g repeat-time 500
      set-option -g set-titles off
      set-option -g set-titles-string "#S:#I:#W - \"#T\" #{session_alerts}"
      set-option -g silence-action other
      set-option -g status on
      set-option -g status-bg default
      set-option -g status-fg default
      set-option -g status-format[0] "#[align=left range=left #{status-left-style}]#[push-default]#{T;=/#{status-left-length}:status-left}#[pop-default]#[norange default]#[list=on align=#{status-justify}]#[list=left-marker]<#[list=right-marker]>#[list=on]#{W:#[range=window|#{window_index} #{window-status-style}#{?#{&&:#{window_last_flag},#{!=:#{window-status-last-style},default}}, #{window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{window-status-bell-style},default}}, #{window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{window-status-activity-style},default}}, #{window-status-activity-style},}}]#[push-default]#{T:window-status-format}#[pop-default]#[norange default]#{?window_end_flag,,#{window-status-separator}},#[range=window|#{window_index} list=focus #{?#{!=:#{window-status-current-style},default},#{window-status-current-style},#{window-status-style}}#{?#{&&:#{window_last_flag},#{!=:#{window-status-last-style},default}}, #{window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{window-status-bell-style},default}}, #{window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{window-status-activity-style},default}}, #{window-status-activity-style},}}]#[push-default]#{T:window-status-current-format}#[pop-default]#[norange list=on default]#{?window_end_flag,,#{window-status-separator}}}#[nolist align=right range=right #{status-right-style}]#[push-default]#{T;=/#{status-right-length}:status-right}#[pop-default]#[norange default]"
      set-option -g status-format[1] "#[align=centre]#{P:#{?pane_active,#[reverse],}#{pane_index}[#{pane_width}x#{pane_height}]#[default] }"
      set-option -g status-interval 15
      set-option -g status-justify left
      set-option -g status-keys emacs
      set-option -g status-left "[#{session_name}] "
      set-option -g status-left-length 10
      set-option -g status-left-style default
      set-option -g status-position bottom
      set-option -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=21:pane_title}\" %H:%M %d-%b-%y"
      set-option -g status-right-length 40
      set-option -g status-right-style default
      set-option -g status-style bg=green,fg=black
      set-option -g update-environment[0] DISPLAY
      set-option -g update-environment[1] KRB5CCNAME
      set-option -g update-environment[2] SSH_ASKPASS
      set-option -g update-environment[3] SSH_AUTH_SOCK
      set-option -g update-environment[4] SSH_AGENT_PID
      set-option -g update-environment[5] SSH_CONNECTION
      set-option -g update-environment[6] WINDOWID
      set-option -g update-environment[7] XAUTHORITY
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-option -g word-separators " "
      ###
      set-option -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      ## tmux-aliases
      set-option -g command-alias[100] broadcast-input='set -w synchronize-panes'
EOF
  fi
}

# common conditionals
# config tmux
if [[ "$*" == *"tmux"* ]]; then
  _tmuxcfg
fi

# bash-specific
if [[ "$(ps -p $$ -o comm=)" == "bash" ]]; then
  _kliases
fi

# zsh-specific
if [[ "$(ps -p $$ -o comm=)" == "zsh" ]]; then
  # if oh-my-zsh not present
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    _kliases
  fi
fi