# ptomulik-backport_package_settings

[![Build Status](https://travis-ci.org/ptomulik/puppet-backport_package_settings.png?branch=master)](https://travis-ci.org/ptomulik/puppet-backport_package_settings)

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
    * [Setup requirements](#setup-requirements)
3. [Development](#development)

## Overview

Backport `package_settings` to older versions of Puppet.

The `package` resource has a `package_settings` feature and property in Puppet
3.5.0 and later. The property, however, is missing in older puppet versions.
This module brings the `package_settings` feature back to any older version of
Puppet if it doesn't have one.

## Setup

### Setup Requirements

You must enable **pluginsync** in your `puppet.conf`.

### Beginning with backport_package_settings

To backport `package_settings` put the following line in front of your package
provider:

    require 'puppet/backport/type/package/package_settings'

To use `package_settings`, your provider should implement at least these
methods:

  - `package_settings`
  - `package_settings=(value)` 
  - `package_settings_insync?(should,is)` 

It may also optionally implement the following methods:

  - `package_settings_validate(value)`,
  - `package_settings_munge(value)`,
  - `package_settings_should_to_s(should,newvalue)`,
  - `package_settings_is_to_s(should,currentvalue)`,
  - `package_settings_change_to_s(currentvalue,newvalue)`

## Development
The project is held at github:
* [https://github.com/ptomulik/puppet-backport_package_settings](https://github.com/ptomulik/puppet-backport_package_settings)
Issue reports, patches, pull requests are welcome!
