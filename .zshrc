# ~/.zshrc

#PROMPT='[%1d]%# '
#PROMPT='zsh@%m%(!.#.$) '

SPROMPT="%r is correct? [n,y,a,e]: "

LISTMAX=0
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

unlimit
#limit coredumpsize 0
limit -s
umask 022


if [[ $OSTYPE = Linux* || $OSTYPE = linux* ]]; then
    PROMPT='%F{green}%m%f%# '
fi

stty -istrip

# emacs + Meta
bindkey -e
bindkey "^ "  set-mark-command
bindkey "^[f" emacs-forward-word
bindkey "^[b" emacs-backward-word
bindkey '^u'  backward-kill-line
bindkey '^w'  kill-region
bindkey '^i'  expand-or-complete
#export WORDCHARS=''

#bindkey '^I'  list-expand
#bindkey '^Xg' expand-or-complete
#bindkey ' ' magic-space    # also do history expansion on space
#bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Search path for the cd command
#cdpath=(.. ~)
# zsh関数のサーチパス
#fpath=($fpath ~/.zfunc )

#----------------------------------------------------------------
# 補完
#----------------------------------------------------------------
#autoload -U compinit; compinit   #補完のおまじない
zstyle ':completion:*:default' menu select=1  # 補完侯補を動き回る
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない

#----------------------------------------------------------------
#先方予測
#----------------------------------------------------------------
#autoload predict-on
#predict-on

#----------------------------------------------------------------
# オプションの意味は zshoptions(1) を参照のこと
#----------------------------------------------------------------
setopt append_history       # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt share_history        # share command history data
setopt hist_ignore_all_dups # コマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_space
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_save_no_dups    # 古いコマンドと同じものはヒストリファイルに書き出さない
setopt hist_no_store        # historyコマンドは履歴に登録しない
#setopt hist_expand          # 補完時にヒストリを自動的に展開
setopt list_packed          #listをできる限りつめる
setopt auto_remove_slash
setopt auto_param_slash     # ディレクトリ名の補完で一旦末尾の / を追加
#setopt mark_dirs            # ディレクトリにマッチした場合末尾に / を付加
setopt list_types           # 補完候補一覧でファイルの種別を識別マーク表示
unsetopt menu_complete      # 最初にマッチしたものをいきなり挿入はしない
setopt auto_list            # いきなりはリストを出さない
setopt auto_menu            # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_resume          # サスペンド中のプロセスと同じコマンドを実行した場合はリジューム
#setopt correct              # 入力コマンド修正
#setopt auto_correct         # 補完時にスペルチェック
#setopt correct_all          # コマンドライン全てのスペルチェックをする
unsetopt auto_cd            # ディレクトリのみで移動
setopt no_beep              # コマンド入力エラーでBeepを鳴らさない
setopt brace_ccl            # ブレース展開機能を有効にする
setopt bsd_echo
setopt complete_in_word
setopt equals               # =COMMAND を COMMAND のパス名に展開
setopt extended_glob        # 拡張グロブを有効にする
unsetopt flow_control       # (shell editor 内で) C-s, C-q を無効にする
setopt no_flow_control      # C-s/C-q によるフロー制御を使わない
setopt hash_cmds            # 各コマンドが実行されるときにパスをハッシュに入れる
#setopt ignore_eof           # C-dでログアウトしない
#setopt no_checkjobs         # ログアウト時にバックグラウンドジョブを確認しない
setopt long_list_jobs       # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst    # コマンドラインの引数で --PREFIX=/USR などの = 以降も補完可
#setopt mail_warning
setopt multios              # 複数のリダイレクトやパイプなど
#setopt numeric_glob_sort    # ファイル名を数値的にソート
setopt path_dirs            # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit      # 補完候補リストの日本語を適正表示
setopt short_loops          # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる

setopt nobgnice  # バックグランドのジョブのスピードを落とさない
setopt nohup     # ログアウトしてもバックグランドジョブを続ける

setopt auto_name_dirs
setopt always_last_prompt # カーソル位置を保持したままファイル名一覧を順次その場で表示
setopt bash_auto_list
setopt cdable_vars
setopt sh_word_split

unsetopt auto_pushd      # ディレクトリを自動記憶
setopt pushd_ignore_dups # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home     # pushd 引数ナシ == pushd $HOME
setopt pushd_silent      # pushd,popdの度にスタックの中身を表示しない
setopt rm_star_silent    # rm * を実行する前に確認しない
setopt notify            # バックグラウンドジョブが終了したらすぐに知らせる。
setopt clobber           # リダイレクトで上書き可能
setopt no_unset          # 未定義変数の使用禁止
unsetopt null_glob       # グロビングでマッチしないときに警告を出さない

#setopt interactive_comments # コマンド入力中のコメントを認める
#setopt chase_links      # シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value # 戻り値が0以外の場合終了コードを表示
#setopt single_line_zle  # 複数行コマンドライン編集ではなく１行編集モード
#setopt xtrace           # コマンドラインがどのように展開され実行されたかを表示する

setopt globdots    # ドットファイルも補完候補に出す。
