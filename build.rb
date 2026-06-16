#!/usr/bin/env ruby
# 构建 Jekyll 静态站点
# 用法：ruby build.rb

require 'jekyll'
require 'fileutils'

config = {
  'source' => Dir.pwd,
  'destination' => '_site',
  'env' => ENV['JEKYLL_ENV'] || 'development'
}

puts "构建 Jekyll 站点..."
Jekyll::Commands::Build.process(config)

puts "复制 WebP 图片到 _site 目录..."
src_img_dir = File.join(Dir.pwd, 'assets', 'img')
dest_img_dir = File.join(Dir.pwd, '_site', 'assets', 'img')

FileUtils.mkdir_p(dest_img_dir)

Dir.glob(File.join(src_img_dir, '**', '*.webp')) do |webp_file|
  relative_path = webp_file.sub(src_img_dir, '')
  dest_file = File.join(dest_img_dir, relative_path)
  FileUtils.mkdir_p(File.dirname(dest_file))
  FileUtils.cp(webp_file, dest_file)
end

puts "构建完成！输出目录: _site"
