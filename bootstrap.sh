#!/bin/sh
# Script to build iOS-UI-Catalog project

# setup Gems, Brews and Mints
echo "Install Gems and Brews"
bundle install
brew bundle

# install dependencies via Carthage
echo "Install dependencies via Carthage"
carthage bootstrap --no-use-binaries --cache-builds --platform ios

# set projectname
open UI-Catalog.xcodeproj
