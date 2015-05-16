'use strict'

module.exports =

  CONFIG_CREATED      : -> 'Config file created!.'
  ADD_FILE            : (file) -> "'#{file}' added."
  ALREADY_FILE        : (file) -> "'#{file}' is already added."
  DETECTED_FILE       : (file) -> "Detected '#{file}' in the directory."
  NOT_DETECTED_FILE   : (file) -> "'#{file}' doesn't detected in the directory."
  CREATED_VERSION     : (version) -> "Created version '#{version}'."
  CURRENT_VERSION     : (version) -> "Current version is '#{version}'."
  NOT_VALID_VERSION   : (version) -> "version '#{version}' provided to release is not valid."
  NOT_GREATER_VERSION : (last, old) -> "version '#{last}' is not greater that the current '#{old}' version."