#!/usr/bin/env ruby

require 'json'

sick_object = {
	'meta' => {
		'title' => '',
		'type' => 'Polygon',
		'description' => {}
	},
	'data' => {
		'label' => '',
		'source'=> ''
	}
}

STATE_NUM = '19'
source_codes = Array.new
source_names = Array.new
file_lines = Array.new
file_names = Array.new
sick_objects = Array.new

Dir.foreach('../data/files/jsons') do |filename|
	next if filename == '.' or filename == '..'
	file_names.push(filename)
	base = File.basename(filename, File.extname(filename))
	source_codes.push(base.sub(STATE_NUM, 'ee'))
end

file_lines = File.readlines('../data/files/contenido.txt', chomp: true)

file_lines.each_with_index do |item, index|
	if source_codes.include?(item)
		sick_object['meta']['title'] = file_lines[index+1]
		sick_object['data']['label'] = item.sub('ee', STATE_NUM)	
		sick_objects.push(JSON[sick_object])
	end	
end

p sick_objects
