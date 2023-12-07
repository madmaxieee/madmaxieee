#! /usr/bin/env bash

# cd to the root of the repo
cd "$(git rev-parse --show-toplevel)" || exit 1

git switch main

stats_url="https://github-readme-stats-madmaxieee.vercel.app/api/top-langs?username=madmaxieee&exclude_repo=Tower-Defense&hide=verilog,html,qml,matlab,css,makefile&layout=donut"
top_langs_url="https://github-readme-stats-madmaxieee.vercel.app/api?username=madmaxieee&show_icons=true"
dark_theme="&theme=tokyonight"

date=$(date '+%Y-%m-%d')

rm -rf ./assets/*.svg
curl -s "$stats_url" > "./assets/stats-light-$date.svg"
curl -s "$top_langs_url" > "./assets/top-langs-light-$date.svg"
curl -s "$stats_url$dark_theme" > "./assets/stats-dark-$date.svg"
curl -s "$top_langs_url$dark_theme" > "./assets/top-langs-dark-$date.svg"

tmp_file=$(mktemp)

sed "s/stats-dark.*\.svg/stats-dark-$date.svg/" README.md |
sed "s/stats-light.*\.svg/stats-light-$date.svg/" |
sed "s/top-langs-dark.*\.svg/top-langs-dark-$date.svg/" |
sed "s/top-langs-light.*\.svg/top-langs-light-$date.svg/" > "$tmp_file"

mv "$tmp_file" README.md

git add --all
git commit -m "chore: update stats at $date"
git push origin main
