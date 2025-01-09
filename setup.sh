#!/bin/sh

if command -v omz &> /dev/null
then
  echo "Oh-my-zsh is already installed."
else
  echo "Oh-my-zsh is not installed. Installing Oh-my-zsh..."
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

echo "Initiate Homebrew setup..."
# Check if Homebrew is installed
if command -v brew &> /dev/null
then
  echo "Homebrew is already installed."
else
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Make sure Homebrew is up-to-date
echo "Updating Homebrew..."
brew update

# Install packages from the Brewfile
if [ -f ~/dev/dotfiles/Brewfile ]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file=~/dev/dotfiles/Brewfile
else
  echo "No Brewfile found at ~/dev/dotfiles/Brewfile."
fi

# Cleanup Homebrew
echo "Running Homebrew cleanup..."
brew cleanup

echo "Homebrew setup is done!"

source(./.macos)
