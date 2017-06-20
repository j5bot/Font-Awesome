#!/bin/bash

# rm -rf original/scss original/less
mkdir -p original
if [ -f original/scss ]; then
  rm -rf src/assets/font-awesome/scss
fi
if [ -f original/less ]; then
  rm -rf src/assets/font-awesome/less
fi

cp -R src/assets/font-awesome/scss original/scss
cp -R src/assets/font-awesome/less original/less

pushd src/assets/font-awesome/scss

grep -r '^\s*\.' -l --null . | xargs -0 sed -i 's#\.\([a-z#][^\:,. )]*\)#[data-am-fa~="\1"]#g'
grep -r '^\s*&\.' -l --null . | xargs -0 sed -i 's#\.\([a-z#][^\:,. )]*\)#[data-am-fa~="\1"]#g'

grep -r '{{"\] alias }}' -l --null . | xargs -0 sed -i 's#{{"] alias }}#{{ alias }}"]#g'
grep -r 'icon\[data-am-fa~="aliases"\]' -l --null . | xargs -0 sed -i 's#icon\[data-am-fa~="aliases"\]#icon.aliases#g'
grep -r '{{"\] icon\[data-am-fa~="id"\] }}' -l --null . | xargs -0 sed -i 's#{{"\] icon\[data-am-fa~="id"\] }}#{{ icon.id }}"]#g'

grep -r '\[data-am-fa~="sass""\]' -l --null . | xargs -0 sed -i 's#\[data-am-fa~="sass""\]#.sass"#g'

popd

pushd src/assets/font-awesome/less

grep -r '^\s*\.' -l --null . | xargs -0 sed -i 's#\.\([a-z@][^\:,. )]*\)#[data-am-fa~="\1"]#g'
grep -r '^\s*&\.' -l --null . | xargs -0 sed -i 's#\.\([a-z@][^\:,. )]*\)#[data-am-fa~="\1"]#g'

grep -r '{{"\] alias }}' -l --null . | xargs -0 sed -i 's#{{"] alias }}#{{ alias }}"]#g'
grep -r 'icon\[data-am-fa~="aliases"\]' -l --null . | xargs -0 sed -i 's#icon\[data-am-fa~="aliases"\]#icon.aliases#g'
grep -r '{{"\] icon\[data-am-fa~="id"\] }}' -l --null . | xargs -0 sed -i 's#{{"\] icon\[data-am-fa~="id"\] }}#{{ icon.id }}"]#g'

# grep -r '\[data-am-fa~="sass""\]' -l --null . | xargs -0 sed -i 's#\[data-am-fa~="sass""\]#.sass"#g'

popd


# cp bulma.sass bulma-attribute-selectors.sass

# sed -i 's#sass/#sass-attribute-selectors/#g' bulma-attribute-selectors.sass

# echo '/* @import "bulma.sass" */' >> bulma-attribute-selectors.sass

# mkdir -p logs
# echo 'Recreated bulma-attribute-selectors.sass at: ' $(date) >> logs/bulma-attribute-selectors.log

# mkdir -p dist/bulma/css
# mkdir -p dist/bulma-attribute-selectors/css
