# CHANGELOG

## 2026-06-16

### Bug Fixes

1. **GitHub Actions branch listening issue**
   - Problem: Code was pushed to `master` branch, but workflow was listening on `main` branch
   - Fix: Changed branch from `main` to `master` in [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L6)

2. **npm ci missing lock file**
   - Problem: `npm ci` requires `package-lock.json`, which doesn't exist in the project
   - Fix: Changed command from `npm ci` to `npm install --legacy-peer-deps` in [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L44)

3. **npm cache configuration**
   - Problem: `setup-node` configured with `cache: 'npm'` requires `package-lock.json`
   - Fix: Removed `cache: 'npm'` from [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L39)

4. **node-sass Python version incompatibility**
   - Problem: `node-sass` requires Python 2, but GitHub Actions Ubuntu environment only has Python 3
   - Fix: Upgraded to `gulp-sass@5.x` and `sass` (dart-sass), removed `node-sass` dependency

5. **gulp version upgrade**
   - Problem: `gulp-sass@5.x` requires `gulp@4.x`
   - Fix: Upgraded `gulp` from `^3.9.1` to `^4.0.2` in [package.json](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/package.json#L12)

6. **gulp task name conflict with variable name**
   - Problem: `var sass = require('gulp-sass')(...)` conflicts with `gulp.task('sass', ...)` task name, causing "Task never defined: sass" error
   - Fix: Renamed task from `sass` to `compile-sass`, updated build script in [package.json](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/package.json#L22)

7. **pngquant-bin missing system dependency**
   - Problem: `pngquant-bin` requires `libpng-dev` to compile on Ubuntu
   - Fix: Added `sudo apt-get install -y libpng-dev` step in [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L41-L42)

8. **WebP images not copied to _site directory**
   - Problem: Jekyll default build doesn't copy WebP files in subdirectories
   - Fix: Added `cp -r assets/img/*.webp assets/img/**/*.webp _site/assets/img/` step in [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L55-L56)

### Improvements

1. **package.json build script**
   - Added WebP generation: `gulp sass && gulp webp` → `gulp compile-sass && gulp webp`

2. **gulpfile.js syntax upgrade**
   - Upgraded gulp 3.x array-style task dependencies to gulp 4.x `gulp.series()` syntax
   - Moved sass compiler initialization inside the task to avoid variable name conflicts

3. **Gemfile.lock removed**
   - Removed Windows-generated `Gemfile.lock` to avoid cross-platform dependency conflicts
