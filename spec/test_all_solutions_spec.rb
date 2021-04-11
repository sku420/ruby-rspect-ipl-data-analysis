# frozen_string_literal: true

require 'csv'
require 'umpires_nationality'
require 'matches_by_teams_by_season'
require 'total_runs_by_team'
require 'runs_by_rcb_batsman'
require 'read_dataset'

# tests for read dataset program that reads the from given csv file and return a hash
describe 'read_dataset' do
  umpires_test_dataset = CSV.parse(File.read('./lib/umpires.csv'), headers: true)
  match_test_dataset = CSV.parse(File.read('./lib/matches_2015.csv'), headers: true)

  # method calls
  returned_dataset = read_dataset('umpires')
  returned_match_dataset = read_dataset('matches_2015')

  # tests if the returned hash is same for umpires dataset
  it 'should return the same hash as returned above' do
    expect(returned_dataset).to eq(umpires_test_dataset)
  end

  # tests if the returned hash is same for matches dataset
  it 'should return the same hash as returned above' do
    expect(returned_match_dataset).to eq(match_test_dataset)
  end
end

# tests for umpires nationality method that return a hash with countries as key and count as values
describe 'umpires_nationality_main' do
  # hash including manual calculation over dataset
  manual_calculation = { 'SL' => 2, 'SA' => 5, 'AUS' => 7, 'PAK' => 2, 'NZ' => 4, 'WI' => 1, 'ENG' => 4, 'ZIM' => 1 }

  # method call
  returned_calculation = umpires_nationality_main

  # test if return hash size is same as expected
  it 'checks the size of returned result' do
    expect(returned_calculation.length).to be(manual_calculation.length)
  end

  # test if return result is same as expected
  it 'compare the return result with manual calculation' do
    expect(returned_calculation).to eq(manual_calculation)
  end

  # test the total number of foreign umpires is as expected
  it 'compares total count of foreign umpures' do
    total_count = returned_calculation.sum { |_country, count| count }
    expect(total_count).to be(26)
  end
end

# tests for match by teams bye session returns a hash of hash: hash[session][team] => matches
describe 'matches_teams_season_main' do
  manual_count = { '2014' => { 'KKR' => 16, 'KXP' => 17, 'CSK' => 16, 'MI' => 15, 'RCB' => 14, 'DD' => 14, 'SH' => 14,
                               'RR' => 14 } }
  returned_count = matches_by_teams_by_season_main

  # test if returned hash have the same number of teams
  it 'checks if participated team count is same' do
    expect(returned_count.values.length).to be(manual_count.values.length)
  end

  # test if returned hash is same as manual hash
  it 'compare returned result with manual count' do
    expect(returned_count).to eq(manual_count)
  end
end

# tests for total runs by teams returns hash with teams as key and runs as value
# tested over a small chunk of dataset that have 2 teams and 2 matches between them
describe 'total_runs_by_team_main' do
  manual_analysis_result = { 'KKR' => 290, 'RCB' => 207 }
  returned_result = total_runs_by_team_main

  it 'checks size of returned result' do
    expect(returned_result.length).to be(manual_analysis_result.length)
  end

  # test if returned result is correct
  it 'compare returned result with manual count' do
    expect(returned_result).to eq(manual_analysis_result)
  end

  # test total runs including both the teams are correct
  it 'compares total scores by both teams are same' do
    total_run = returned_result.sum { |_team, run| run }
    expect(total_run).to be(497)
  end
end

# tests for runs by rcb batsman
# tested over a small chunk of dataset of only 2 matches
describe 'runs_by_rcb_batsman_main' do
  manual_analysis_result = { 'CH Gayle' => 7, 'V Kohli' => 5, 'AB de Villiers' => 18, 'Mandeep Singh' => 53,
                             'TM Head' => 75, 'KM Jadhav' => 17, 'STR Binny' => 8 }
  returned_result = runs_by_rcb_batsman_main

  it 'checks size of returned result' do
    expect(returned_result.length).to be(12)
  end

  # test if the returned result is same
  it 'compare returned result with manual count' do
    expect(returned_result).to include(manual_analysis_result)
  end

  # test if the total runs is same as expected
  it 'compares total runs by RCB batsman with total score returned in previous test' do
    total_run = returned_result.sum { |_player, run| run }
    expect(total_run).to be(197)
  end

  # test if the highest scorer is 'TM Head'
  it 'checks if most scorer is TM Head' do
    expect(returned_result.keys[0]).to be('TM Head')
  end
end
