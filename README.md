# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/kconragan/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks from within the dotfiles directory

```
$ stow .
```
