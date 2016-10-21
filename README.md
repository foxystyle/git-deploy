# Git deploy

This is simple script that allows you to deploy your project to the server using git.


## Installation

Use `git clone` to download this script to your local machine or server.

## Usage

Execute script like `./git-deploy.sh` or `sh git-deploy.sh`. Fill three inputs. Git repo is where your git files will be stored, deploy repo is where your actual folder will be deployed.

## Remote

Add ssh remote such as:
```
git remote add <remote_name> ssh://user@ip:port/absolute/path/<project_name>.git
```

And then push like:

```
git push <remote_name> <branch_name>
```

## When to use it

I usually use it to deploy web projects to the server or when I want to access my projects from anywhere as most simple as possible, without copy-pasting stuff on Dropbox.

## Contribution

There is nothing much to do here, but any contribution is welcome.
