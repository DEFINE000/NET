trained_net=1;

save("nasnet.mat","trained_net");




system("git init");
system("git lfs install");
system('git config --global user.email "2978985731@qq.com"')
system('git config --global user.name "vc"')
system("git lfs track *")
system("git add .gitattributes")
system('git commit -m "first"');
system('git remote add origin https://github.com/DEFINE000/NET.git')
system("git push origin master");
system("git add *");
system('git commit -m "nb"');
system("git push origin master")










