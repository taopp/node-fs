# Extension of nodes fs utils
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
fs = require 'fs'
path = require 'path'
async = require 'async'


# Find binary in node_modules or parent
# -------------------------------------------------
#
# __Arguments:__
#
# * `bin`
#   name of the binary to search for
# * `dir`
#   Module directory to start search from.
# * `callback(err, file)`
#   The callback will be called just if an error occurred or after finished.
#   The file is the path to the binary if found.
npmbin = module.exports.async = (bin, dir, cb) ->
  unless cb
    cb = dir
    dir = path.dirname __dirname
  file = path.join dir, 'node_modules', '.bin', bin
  # search for file
  fs.exists file, (exists) ->
    return cb null, file if exists
    # find in parent
    parent = path.join dir, '..', '..'
    if parent is dir
      return cb "Could not find #{bin} program."
    npmbin bin, parent, cb

# Find binary in node_modules or parent(synchronous)
# -------------------------------------------------
#
# __Arguments:__
#
# * `bin`
#   name of the binary to search for
# * `dir`
#   Module directory to start search from.
#
# __Return:__
#
# * `callback(err, file)`
#   The callback will be called just if an error occurred or after finished.
#   The file is the path to the binary if found.
npmbinSync = module.exports.sync = (bin, dir) ->
  unless cb
    cb = dir
    dir = path.dirname __dirname
  file = path.join dir, 'node_modules', '.bin', bin
  # search for file
  return file if fs.exists file
  # find in parent
  parent = path.join dir, '..', '..'
  if parent is dir
    return cb "Could not find #{bin} program."
  npmbinSync bin, parent
