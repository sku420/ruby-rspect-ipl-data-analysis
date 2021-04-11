# frozen_string_literal: true

require_relative 'read_dataset'
require_relative 'plot_graph'
include Graph

# reduce country name to their abbr: West Indies => WI, Australia => AUS
def short_country_name(name)
  if name.include? ' '
    temp = name.split(' ')
    temp[0][0] + temp[1][0]
  else
    name[0..2].upcase
  end
end

# main method
def umpires_nationality_main
  # read dataset from .csv file
  umpires_dataset = read_dataset('umpires')

  # hash to store umpires by nationality
  foreign_umpires = Hash.new(0)

  # extracting required data from dataset [nationality] => umpires count
  umpires_dataset.each do |umpire|
    country = short_country_name(umpire['Nationality'])
    foreign_umpires[country] += 1 if umpire['Nationality'] != 'India'
  end

  # return hash: hash[country] => count
  foreign_umpires
end
