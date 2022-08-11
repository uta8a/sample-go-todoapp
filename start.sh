#!/bin/bash -e

nvim -u init.vim -c UpdateRemotePlugins -c PlugUpdate -c UpdateRemotePlugins -c q -c q

