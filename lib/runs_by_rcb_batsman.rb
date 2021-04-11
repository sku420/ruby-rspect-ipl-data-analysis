# frozen_string_literal: true

require_relative 'read_dataset'
require_relative 'plot_graph'
include Graph

# main method
def runs_by_rcb_batsman_main
  # read dataset from .csv file
  deliveries_dataset = read_dataset('deliveries_2match')

  # hash to store rcb batsmans and their scores
  rcb_batsman = Hash.new(0)

  # extracting required data from dataset: [batsman] => runs
  deliveries_dataset.each do |team|
    rcb_batsman[team['batsman']] += team['batsman_runs'].to_i if team['batting_team'] == 'Royal Challengers Bangalore'
  end
  # puts rcb_batsman

  # getting top 10 batsman from the extracted data
  rcb_batsman.sort_by { |_key, value| -value }.to_h
end
