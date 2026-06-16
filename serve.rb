#!/usr/bin/env ruby
# 启动 Jekyll 本地开发服务器
# 用法：ruby serve.rb

require 'jekyll'

config = {
  'source' => Dir.pwd,
  'destination' => '_site',
  'host' => '0.0.0.0',
  'port' => 4000,
  'watch' => true,
  'livereload' => false
}

puts "启动 Jekyll 服务器..."
puts "访问地址: http://localhost:4000"
puts "按 Ctrl+C 停止"
puts ""

Jekyll::Commands::Serve.process(config)
