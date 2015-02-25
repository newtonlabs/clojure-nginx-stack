#!/bin/bash

rm .vagrant/machines/default/virtualbox/synced_folders
vagrant reload --provision
