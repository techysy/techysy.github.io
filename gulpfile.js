var gulp = require('gulp');
var sass = require('gulp-sass')(require('sass'));
var prefix = require('gulp-autoprefixer');
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant');
var cache = require('gulp-cache');
var cp = require('child_process');
var browserSync = require('browser-sync');
var webp = require('gulp-webp');

var jekyll   = process.platform === 'win32' ? 'jekyll.bat' : 'jekyll';

// Build the Jekyll Site
gulp.task('jekyll-build', function (done) {
    return cp.spawn( jekyll , ['build'], {stdio: 'inherit'})
        .on('close', done);
});

// Rebuild Jekyll and page reload
gulp.task('jekyll-rebuild', gulp.series('jekyll-build', function (cb) {
    browserSync.reload();
    cb();
}));

// Wait for jekyll-build, then launch the Server
gulp.task('browser-sync', gulp.series('sass', 'jekyll-build', function() {
    browserSync({
        server: {
            baseDir: '_site'
        },
        notify: false
    });
}));

// Compile files
gulp.task('sass', function () {
    return gulp.src('assets/css/sass/main.scss')
        .pipe(sass({
            outputStyle: 'expanded'
        }).on('error', sass.logError))
        .pipe(prefix(['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true }))
        .pipe(gulp.dest('_site/assets/css'))
        .pipe(browserSync.reload({stream:true}))
        .pipe(gulp.dest('assets/css'));
});

// Compression images
gulp.task('img', function() {
	return gulp.src('assets/img/**/*')
		.pipe(cache(imagemin({
			interlaced: true,
			progressive: true,
			svgoPlugins: [{removeViewBox: false}],
			use: [pngquant()]
		})))
		.pipe(gulp.dest('_site/assets/img'))
		.pipe(browserSync.reload({stream:true}));
});

// Generate WebP images
gulp.task('webp', function() {
	return gulp.src('assets/img/**/*.{jpg,jpeg,png}')
		.pipe(webp({
			quality: 80,
			preset: 'photo'
		}))
		.pipe(gulp.dest('assets/img'));
});

// Watch scss, html, img files
gulp.task('watch', function () {
    gulp.watch('assets/css/sass/**/*.scss', gulp.series('sass'));
    gulp.watch('assets/js/**/*.js', gulp.series('jekyll-rebuild'));
    gulp.watch(['*.html', '_layouts/*.html', '_includes/*.html', '_pages/*.html', '_posts/*'], gulp.series('jekyll-rebuild'));
});

// Default task
gulp.task('default', gulp.series('browser-sync', 'watch'));
