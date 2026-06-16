#!/usr/bin/env ruby
# 构建 Jekyll 静态站点
# 用法：ruby build.rb

require 'jekyll'

config = {
  'source' => Dir.pwd,
  'destination' => '_site',
  'env' => ENV['JEKYLL_ENV'] || 'development'
}

puts "构建 Jekyll 站点..."
Jekyll::Commands::Build.process(config)
puts "构建完成！输出目录: _site"
