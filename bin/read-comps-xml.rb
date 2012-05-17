#!/usr/bin/env ruby
#
# Reads 'comps.xml' from RedHat/CentOS/Scentific Linux
#
#
# Marcus Vinicius Fereira            ferreira.mv[ at ].gmail.com
# 2011-11
#

require 'rubygems'
require 'xmlsimple'
require "pp"

doc = XmlSimple.xml_in( File.open("./c.xml") )

group_name = ''
gr_default = Hash.new
gr_extra = Hash.new


doc['group'].each do |g|

  group_name = g['id'].to_s
# puts "Parsing: " + group_name

  ### First: default groups
  if g['default'].to_s == 'true'

    gr_default[ group_name ] = g['packagelist'][0]['packagereq']

  ### Second: remaining groups, exclude language packs
  elsif g['langonly'].nil?

#   puts "Group: #{group_name}"
#   puts "Group def" if g['packagelist'][0].empty?
#   pp g['packagelist']
    gr_extra[ group_name ] = g['packagelist'][0]['packagereq'] unless g['packagelist'][0].empty?

  end

end # group
puts "\n\n"

def pkg_split ( group )

  group.keys.sort.each do |gr|

    puts "###"
    puts "### Group: " + gr + " ### {"
    puts "###"
    puts "# @" + gr

    # split by type
    rpm = Hash.new
    group[ gr ].each do |pkg|
      rpm[ pkg['type'] ] ||= []   # initialize hash of array
      rpm[ pkg['type'] ] << pkg['content']
    end

    # [ 'mandatory', 'default', 'optional' ].each do |k|
    rpm.keys.sort.each do |k|

      puts "# " + gr + ": " + k + "   # {"

      # show by type
      rpm[ k ].sort.each do |v|
        puts       v if k == 'mandatory'
        puts       v if k == 'default'
        puts "-" + v if k == 'optional'
      end # v

      puts "# }\n"
    end # k

    puts "### }\n\n"

  end # group

end # def


puts <<HEADER
###
### Packages      # {
###    default: installed if package is selected
###    mandatory: always installed
%packages

HEADER

### Process default groups packages
pkg_split( gr_default )

### Extra groups
#pkg_split( gr_extra )

puts <<EXTRA
###
### Extra groups
###
EXTRA
gr_extra.keys.sort.each do |gr|

  puts "-@" + gr

end

puts "\n\n"

