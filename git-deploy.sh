echo "
 Git deploy
 "
#
echo "Enter project name: "
read project_name
#
echo "Enter git path: "
read git_path
#
echo "Enter deploy path: "
read deploy_path

#
cd $deploy_path && mkdir $project_name
cd $git_path && mkdir $project_name.git
cd $git_path/$project_name.git/
git init --bare
cd hooks
touch post-receive
echo "#!/bin/sh
git --work-tree=$deploy_path/$project_name --git-dir=$git_path/$project_name.git checkout -f" >> post-receive
chmod +x post-receive

echo "
Resolved:
  - Git directory: $git_path/$project_name.git
  - Deploy directory: $deploy_path/$project_name
Remote:
  ssh://user@ip:port/$git_path/$project_name.git
"
