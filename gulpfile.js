'use strict';
var browserify, gp, gulp, path, source;

gulp = require('gulp');

gp = (require('gulp-load-plugins'))({
  lazy: false
});

path = require('path');

browserify = require('browserify');

source = require('vinyl-source-stream');

gulp.task('html', function() {
  return gulp.src('app/index.jade').pipe(gp.plumber()).pipe(gp.jade({
    pretty: true,
    basedir: "app/",
    locals: {
      pageTitle: 'Famo.us built with Gulp'
    }
  })).pipe(gulp.dest('www'));
});

gulp.task('js', function() {
  return browserify({
    entries: ['./app/js/main.coffee'],
    extensions: ['.coffee', '.js']
  }).transform('coffeeify').transform('deamdify').transform('debowerify').transform('uglifyify').bundle().pipe(source('main.js')).pipe(gulp.dest('www/js'));
});

gulp.task('css', ['img'], function() {
  return gulp.src('app/css/*.scss').pipe(gp.plumber()).pipe(gp.rubySass({
    compass: true,
    style: 'compressed',
    loadPath: ['bower_components', '.']
  })).pipe(gp.cssmin({
    keepSpecialComments: 0
  })).pipe(gp.autoprefixer('last 1 version')).pipe(gulp.dest('www/css'));
});

gulp.task('img', function() {
  // return gulp.src(['app/img/*.jpg', 'app/img/*.png']).pipe(gp.cache(gp.imagemin({
  //   optimizationLevel: 3,
  //   progressive: true,
  //   interlaced: true
  // }))).pipe(gulp.dest('www/img'));
  return gulp.src(['app/img/**/*.jpg', 'app/img/**/*.png']).pipe(gulp.dest('www/img'));
});

gulp.task('video', function() {
  return gulp.src(['app/video/*.*']).pipe(gulp.dest('www/video'));
});


gulp.task('font', function(){
  return gulp.src('app/css/fonts/**/*').pipe(gulp.dest('www/css/fonts'));
});

gulp.task('clean', function() {
  return gulp.src(['www', 'tmp'], {
    read: false
  }).pipe(gp.clean({
    force: true
  }));
});

gulp.task('build', ['html', 'js', 'css', 'font','video']);

gulp.task('default', ['clean'], function() {
  return gulp.start('build');
});

gulp.task('connect', ['default'], function() {
  return gp.connect.server({
    root: 'www',
    port: 9000,
    livereload: true
  });
});

gulp.task('watch', ['connect'], function() {
  return gulp.watch('app/**/*', {
    read: false
  }, function(event) {
    var ext, reloadasset, taskname;
    ext = path.extname(event.path);
    taskname = null;
    reloadasset = null;
    switch (ext) {
      case '.jade':
        taskname = 'html';
        reloadasset = 'www/index.html';
        break;
      case '.scss':
        taskname = 'css';
        reloadasset = 'www/css/main.css';
        break;
      case '.coffee':
      case '.js':
        taskname = 'js';
        reloadasset = 'www/js/main.js';
        break;
      default:
        taskname = 'img';
        reloadasset = "www/img/" + (path.basename(event.path));
    }
    gulp.task('reload', [taskname], function() {
      return gulp.src(reloadasset).pipe(gp.connect.reload());
    });
    return gulp.start('reload');
  });
});