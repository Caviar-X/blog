mkdir working
cp -r ./homepage/* ./working/
hexo gen
mv ./public ./working/blog
mkdir ./working/mdbackup
cp -r ./source/* ./working/mdbackup
cp ./themes/hexo-theme-keep/_config.yml ./working/_config.yml
cp ./upload.sh ./working/upload.sh
cd working
git init
git branch -M main
git add .
git commit -m "update on: $(date)"
git push -f git@github.com:Caviar-X/blog.git main
cd ..
rm -rf working