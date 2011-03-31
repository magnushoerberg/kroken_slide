require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'haml'
require 'dm-core'
require 'pdfkit'
require 'json'

require './models/model'
require './app'

run KrokenSlide
