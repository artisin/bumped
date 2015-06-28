'use strict'

CSON    = require 'season'
fs      = require 'fs-extra'
async   = require 'neo-async'
Util    = require './Bumped.util'
Semver  = require './Bumped.semver'
Config  = require './Bumped.config'
Logger  = require './Bumped.logger'
DEFAULT = require './Bumped.default'
MSG     = require './Bumped.messages'

module.exports = class Bumped

  constructor: (opts = {}) ->
    process.chdir opts.cwd if opts.cwd?
    @pkg    = require '../package.json'
    @config = new Config this
    @semver = new Semver this
    @logger = new Logger opts.logger
    @util   = new Util this
    this

  start: ->
    [opts, cb] = DEFAULT.args arguments
    return cb() unless @config.rc.config
    @load opts, cb

  load: ->
    [opts, cb] = DEFAULT.args arguments
    @config.load => @semver.sync opts, cb

  init: =>
    [opts, cb] = DEFAULT.args arguments

    tasks = [
      (next) => @config.autodetect opts, next
      (next) => @config.save opts, next
      (next) => @semver.sync opts, next
    ]

    async.waterfall tasks, (err, result) =>
      @logger.errorHandler err, cb
      @end opts, cb

  end: ->
    [opts, cb] = DEFAULT.args arguments

    return @semver.version opts, cb unless opts.outputMessage

    if @config.rc.files.length is 0
      @logger.warn MSG.NOT_AUTODETECTED()
      @logger.warn MSG.NOT_AUTODETECTED_2()

    @semver.version opts, =>
      @logger.success MSG.CONFIG_CREATED() if opts.outputMessage
      cb()
