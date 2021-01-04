#!/bin/zsh
mkdir -p ~/Projects/oc
cd ~/Projects/oc
vared -p 'Enter github token: ' -c GITHUB_TOKEN
curl -u "$GITHUB_TOKEN:x-oauth-basic" 'https://api.github.com/orgs/opencounter/repos?per_page=100' | jq '.[].ssh_url' -r | xargs -n 1 -P 8 git clone

cd -

vared -p 'Enter 1password secret key: ' -c ONEPASS_KEY
op signin opencounter joshua@opencounter.com $ONEPASS_KEY

eval $(op signin opencounter)

SIDEKIQ_PASS=`op get item Sidekiq\ Enterprise | jq '.details.sections[] | select(.fields) | .fields[] | select(.t == "bundle_pass").v' -r`
bundle config enterprise.contribsys.com $SIDEKIQ_PASS

cd ~/Projects/oc/opencounter

op get document application.yml > config/application.yml

bundle
yarn

heroku git:remote -a opencounter-v2-staging
git remote rename heroku staging

heroku git:remote -a opencounter-v2
git remote rename heroku production

brew services start postgresql
brew services start redis

rake db:create:all

development restore-from staging

cd ~/.puma-dev
ln -s ~/Projects/oc/opencounter
