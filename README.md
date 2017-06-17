# Git deploy

This is simple script that allows you to deploy your project to the server using git. It is most suited as simple file control on private network. It is designed to work on Linux servers.

## Installation

Clone this repository to server on which you want to initialize your remotes.

```
git clone https://github.com/kunokdev/git-deploy
```

## Usage

There are two ways to execute this script: (you might need to use `sudo`)

### Interactive mode:  

`sudo ./git-deploy.sh -i`

It will ask you to enter each argument step by step. First prompt is required, other two can fall to defaults (suggestions)

### With arguments:

 `sudo .git-deploy.sh REPO_NAME REPOS_PATH DEPLOY_PATH`

- REPO_NAME - name of repository, this will be used as directory name in filesystem
- REPOS_PATH - absolute path to directory where your git files will be stored
- DEPLOY_PATH - absolute path to directory where you want your files to be deployed

## What it does?

When you run this script on the server, it initializes git directory and deployment directory on that machine. It exposes ssh git remote.

Then from your development machine you can add remote to your working repository and push your code and it will automatically deploy it as well.

### Remote

This is how your command for adding git remote should look like:

```
git remote add <remote_name> ssh://root@10.10.10.10:2222/srv/git-repo-name 
```

- `ssh://` is protocol to be used
- `root` is user
- `@10.10.10` represents server IP
- `:2222` represents port (omitted in most cases)
- `/srv/git-repo-name` represents absolute path to your git repo on the server 

Then you can push as usual and it will automatically deploy usable files to the server too.

```
git push <remote_name> <branch_name>
```

## When is it useful?

I usually use it to deploy CRON scripts to worker servers within network. It can be used to deploy anything else as well, such as PHP. Your deploy path should be `/var/www/html/<project_name>` and your project will be accessible on the server if you have default Apache web server configuration enabled.

## License

MIT
