gulp  = require 'gulp'
karma = require('karma').server

gulp.task 'test', (done) ->
    karma.start
        configFile: __dirname + '/karma.conf.coffee'
        singleRun: true
    , done

gulp.task 'default', ['test']
