;; jisaku.el

(defun left-region(from to string)
  "regionの左端に文字列を入れる。 -0"
  (interactive "r\nsString: ")
  (let ((const-line (count-lines from to))
    (line 0))
    (goto-char from)
    (while (< line const-line)
      (beginning-of-line)
      (insert string)
      (forward-line 1)
      (setq line (+ line 1)))))

(defun right-region(from to string)
  "regionの右端に文字列を入れる。 -0"
  (interactive "r\nsString: ")
  (let ((const-line (count-lines from to))
    (line 0))
    (goto-char from)
    (while (< line const-line)
      (end-of-line)
      (insert string)
      (forward-line 1)
      (setq line (+ line 1)))))


; 引数が負の場合は頭をゼロ埋めする。
(defun write-numbers(number)
  "数を書く -0"
  (interactive "p")
  (let ((line 1)
        (N number)
        (zeropads nil))
    (beginning-of-line)
    (if (< number 0)
        (progn
          (setq N (* number -1))
          (setq zeropads t)))
    (while (<= line N)
      (if (eq zeropads t)
          (insert
           (make-string
            (- (length (number-to-string N))
               (length (number-to-string line)))
            ?0)))
      (insert (format "%d\n" line))
      (setq line (+ line 1)))))

(defun jdate(option)
  "現在の時刻をカーソル位置に挿入する"
  (interactive "sOption[1234]: ")
  (let (date month weekday_name day hour minute second year
             jweekday_name jmonth)
    (setq date (current-time-string))
    (setq weekday_name (substring date 0 3))
    (setq month (substring date 4 7))
    (setq day (string-to-number (substring date 8 10)))
    (setq hour (string-to-number (substring date 11 13)))
    (setq minute (string-to-number (substring date 14 16)))
    (setq second (string-to-number (substring date 17 19)))
    (setq year (string-to-number (substring date 20 24)))

    (if (equal  weekday_name "Sun")
        (setq jweekday_name "日")
      (if (equal  weekday_name "Mon")
          (setq jweekday_name "月")
        (if (equal  weekday_name "Tue")
            (setq jweekday_name "火")
          (if (equal  weekday_name "Wed")
              (setq jweekday_name "水")
            (if (equal  weekday_name "Thu")
                (setq jweekday_name "木")
              (if (equal  weekday_name "Fri")
                  (setq jweekday_name "金")
                (if (equal  weekday_name "Sat")
                    (setq jweekday_name "土"))))))))
    (if (equal  month "Jan")
        (setq jmonth 1)
      (if (equal  month "Feb")
          (setq jmonth 2)
        (if (equal  month "Mar")
            (setq jmonth 3)
          (if (equal  month "Apr")
              (setq jmonth 4)
            (if (equal  month "May")
                (setq jmonth 5)
              (if (equal  month "Jun")
                  (setq jmonth 6)
                (if (equal  month "Jul")
                    (setq jmonth 7)
                  (if (equal  month "Aug")
                      (setq jmonth 8)
                    (if (equal  month "Sep")
                        (setq jmonth 9)
                      (if (equal  month "Oct")
                          (setq jmonth 10)
                        (if (equal  month "Nov")
                            (setq jmonth 11)
                          (if (equal  month "Dec")
                              (setq jmonth 12)))))))))))))
    (if (equal option "1")
        (insert (format "%d年%d月%d日（%s）%d時%d分%d秒" year jmonth
                         day jweekday_name hour minute  second ))
      (if (equal option "2")
          (insert (format "%d月%d日（%s）" jmonth day jweekday_name ))
        (if (equal option "3")
            (insert (format "%d時%d分%d秒" hour minute  second ))
          (if (equal option "4")
              (progn
                (insert (format "%d年%d月%d日（%s）\n\\item （%d時%d分）\n" year jmonth day jweekday_name hour minute))
                (forward-line -1)
                (beginning-of-line)
                (forward-char 6)
                (yank)
                (end-of-line)
                (insert "\n\n")
;                (forward-line 2)
                )))))))

;; 行末の空白文字を削除する。
(defun killblank()
  "killblank"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "[ \t\r]+$" nil t)
    (replace-match "")))

;; 行頭の空白文字を削除する。
(defun killtopblank()
  "killtopblank"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^[ \t]+" nil t)
    (replace-match "")))


;; region の改行文字を全て消去する。

(defun kill-kaigyo-region (from to)
  "regionの改行文字を全て消去する。"
  (interactive "r")
  (let ((const-line (count-lines from to))
        (line 1))
    (goto-char from)
    (while (< line const-line)
      (end-of-line)
      (delete-char 1)
      (setq line (+ line 1)))
    (end-of-line)))

;buffer の先頭で previous-line を実行してもシグナルを出さなくする。
(defun previous-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move (- arg))
    (beginning-of-buffer)))

;; 要注意！この関数名をforward-lineにしては絶対ダメ！
;buffer の最後で next-line を実行してもシグナルを出さなくする。
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

; line-to-top-of-window emacsの本より
(defun line-to-top-of-window ()
  "Move the line point is on to top of window."
  (interactive)
  (recenter 2))


(defun uniq-lines()
  "uniq-lines"
  (interactive)
  (query-replace-regexp "\\([^\n]+\n\\)\\1+" "\\1"))

(make-variable-buffer-local  'jisaku-file-location)

(setq system-identification
      (substring (system-name) 0
                 (string-match "\\..+" (system-name))))


(defun other-window-backward (&optional n)
  "Select N-th previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun insert-regex()
  "現在のカーソルに\(.*\)を挿入。"
  (interactive)
  (insert "\\(.*\\)" ))

;; http://ergoemacs.org/emacs/elisp_unicode_replace_invisible_chars.html
(defun xah-replace-invisible-char ()
  "Query replace some invisible Unicode chars."
  (interactive)
;  (query-replace-regexp "\ufeff\\|\u200b\\|\u200f\\|\u202e\\|\u200e\\|\ufffc" ""))
;  (query-replace-regexp "\u00a0\\|\u180e\\|\u2000\\|\u2001\\|\u2002\\|\u2003\\|\u2004\\|\u2005\\|\u2006\\|\u2007\\|\u2008\\|\u2009\\|\u200a\\|\u200b\\|\u202f\\|\u205f\\|\ufeff" ""))
  (query-replace-regexp "\u00a0\\|\u2000\\|\u2001\\|\u2002\\|\u2003\\|\u2004\\|\u2005\\|\u2006\\|\u2007\\|\u2008\\|\u2009\\|\u200a\\|\u2028\\|\u2029\\|\u202f\\|\u205f\\|\u180e\\|\u200b\\|\u200c\\|\u200d\\|\u2060\\|\u2061\\|\u2062\\|\u2063\\|\u2064\\|\u3164\\|\uffa0\\|\ufeff" ""))

(defun insert-time-and-log()
  "insert date, time, and paste clipboard."
  (interactive)
  (progn
    (insert (format-time-string "%Y-%m-%d\t%H:%M:%S"))
    (insert "\t")
    (yank)
    (insert "\t1\t")))

(defun insert-tab1tabname()
  "tabとnameを入れる。 -0"
  (interactive)
  (insert "\t1\t")
  (yank))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))
