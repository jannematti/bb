function bb --argument-names cmd file
  # echoing only red errors
  set_color red

  set -l remote_url (string split '/' (_split_remote_url))
  set -l owner $remote_url[1]
  set -l repo (string replace '.git' '' $remote_url[2])
  set -l branch (command git rev-parse --abbrev-ref HEAD ^/dev/null)
  set -l current_dir (string split $repo'/' $PWD)[2]
  set -l matching_remote (string length (string match '*/'$branch (git branch -r) ^/dev/null))
  set -l command $cmd
  
  if test -z $repo
    echo "Bitbucket remote repository not found"
    return
  end

  if test (count $matching_remote) -eq 0
    echo "Bitbucket remote branch not found"
    return
  end

  if test -n "$command"
    switch $command
      case commits c
        set end commits/branch/$branch
      case branches b
        set end branches
      case pull-requests pr
        set end pull-requests
      case pipelines pl
        set end addon/pipelines/home
      case deployments
        set end addon/pipelines/deployments
      case downloads
        set downloads
      case boards
        set end addon/trello/trello-board
      case settings
        set end admin
      case '*'
        set end src/$branch/$cmd
    end
  else
    if test -z $current_dir
      set end src/$branch
    else
      set end src/$branch/$current_dir
    end
  end

  set -l url https://bitbucket.org/$owner/$repo/$end

  if test -z $bb_browser
    open $url ^/dev/null
  else
    open -a $bb_browser $url ^/dev/null
  end
end

function _split_remote_url
  set -l git_remote_url (git remote get-url origin ^/dev/null)
  
  if set -q $git_remote_url
    return
  end

  switch $git_remote_url
    case "git*"
      echo (string split 'bitbucket.org:' $git_remote_url)[2]
    case "*https*"
      echo (string split 'bitbucket.org/' $git_remote_url)[2]
  end
end
