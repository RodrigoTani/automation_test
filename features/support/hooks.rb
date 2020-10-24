require 'benchmark'

# Driver Configuration
  # API
if HEADLESS
  Capybara.register_driver :chrome_headless do |app|
    options = ::Selenium::WebDriver::Chrome::Options.new

    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1400,1400')

    Capybara::Selenium::Driver.new(app, {browser: :chrome, options: options})
  end

  Capybara.configure do |config|
    config.default_driver = :chrome_headless
  end

  # Outros Sistemas
elsif 
  Capybara.register_driver :selenium do |app|
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120
  
    Capybara::Selenium::Driver.new(app, {browser: :chrome, http_client: client})
  end
  
  Capybara.configure do |config|
    config.default_driver = :selenium 
  end

  Capybara.current_session.driver.browser.manage.delete_all_cookies
  Capybara.page.driver.browser.manage.window.maximize
end

$dados = {}
Before do |scenario|
end

After do |scenario|
end

at_exit do
  p "Email:#{$email}"
  p "Senha:#{$senha}"
end

