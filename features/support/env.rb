
require 'httparty'
require 'rspec'
require 'pry'
require 'json'
require 'yaml'
require 'colorize'
require 'faker'
require 'open-uri'
require 'date'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rails'
require 'pg'

Pry.config.color = true
# Environment definitions

AMB = ENV['AMB'] || 'hom'
HEADLESS = ENV['HL'] || false

BASE_URL = YAML.load_file('./config/environment.yml')[AMB]