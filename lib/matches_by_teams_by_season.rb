# frozen_string_literal: true

require_relative 'read_dataset'
require_relative 'plot_graph'
include Graph

# reduce team name to their abbr: Kolkata Knight Riders => KKR
def short_team_name(team_name)
  temp = team_name.split(' ')
  temp.length == 3 ? temp[0][0] + temp[1][0] + temp[2][0] : temp[0][0] + temp[1][0]
end

# main method
def matches_by_teams_by_season_main
  # read dataset from .csv file
  matches_dataset = read_dataset('matches_2015')

  # hash to store match played by teams in a season: hash[season][team] => 0
  matches_by_team_by_season = Hash.new { |hash, key| hash[key] = Hash.new(0) }

  # required data extraction from dataset
  matches_dataset.each do |match|
    team1 = short_team_name(match['team1'])
    team2 = short_team_name(match['team2'])
    matches_by_team_by_season[match['season']][team1] += 1
    matches_by_team_by_season[match['season']][team2] += 1
  end

  # sort seasons in ascending order
  matches_by_team_by_season.sort_by { |key, _| -key }.to_h
  # puts matches_by_team_by_season
end
