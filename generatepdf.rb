require 'rubygems'
require 'PDFkit'
require 'haml'

kit = PDFKit.new("<h1>Hello Jonas</h1>")
kit.to_file('test.pdf')
