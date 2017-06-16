#!/bin/bash
if ! [[ $1 ]]; then
  echo -e "\e[44m
  == GIT DEPLOY == \e[m
  A script for quick and simple git deployment environment initialization on the server
  For more info see:
  https://github.com/kunokdev/git-deploy

  There are two ways to execute this script:

  1) Interactive mode:  ./git-deploy.sh -i

  2) With arguments: .git-deploy.sh REPO_NAME REPOS_PATH DEPLOY_PATH
      REPO_NAME - name of repository, this will be used as directory name in filesystem
      REPOS_PATH - absolute path to directory where your git files will be stored
      DEPLOY_PATH - absolute path to directory where you want your files to be deployed
  "
  exit 1
fi

if [[ $1 == "-i" ]]; then
  MODE="interactive"
else
  if [[ $4 ]]; then
    echo "Expecting only 3 arguments, ignoring argument 4 and above"
  fi
  if ! [[ $1 && $2 && $3 ]]; then
  echo "
  Not enough arguments. Need 3 arguments:
    REPO_NAME - name of repository, this will be used as directory name in filesystem
    REPOS_PATH - absolute path to directory where your git files will be stored
    DEPLOY_PATH - absolute path to directory where you want your files to be deployed
  "
  exit 1
  fi
fi

if [[ $MODE == "interactive" ]]; then
  clear
  echo "Git deploy: interactive mode. For usage information run script without any params."
  echo "Repository name?" && read REPO_NAME
  echo "Git repository absolute path? (/srv/$REPO_NAME)" && read REPO_PATH
  echo "Deploy repository absolute path? ($HOME/$REPO_NAME)" && read DEPLOY_PATH
  if ! [[ $REPO_NAME ]]; then
    echo "You must specify repo name!"
    exit 1
  fi
  if ! [[ $REPO_PATH ]]; then
    REPO_PATH="/srv/$REPO_NAME"
  fi
  if ! [[ $DEPLOY_PATH ]]; then
    DEPLOY_PATH="$HOME/$REPO_NAME"
  fi
else
  REPO_NAME=$1 && REPO_PATH=$2 && DEPLOY_PATH=$3
fi

echo $REPO_NAME $REPO_PATH $DEPLOY_PATH

mkdir $REPO_PATH
mkdir $DEPLOY_PATH

cd $REPO_PATH
git init --bare
cd hooks
touch post-receive
echo "#!/bin/sh
git --work-tree=$DEPLOY_PATH --git-dir=$REPO_PATH checkout -f" >> post-receive
chmod +x post-receive

echo "
Resolved:
  - Git directory: $REPO_PATH
  - Deploy directory: $DEPLOY_PATH
Remote:
  ssh://user@ip:port$REPO_PATH
"
