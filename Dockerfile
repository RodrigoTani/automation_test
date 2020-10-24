FROM ruby:2.6.6

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Set timezone
RUN echo "America/Sao_Paulo" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN TZ='America/Sao_Paulo'; export TZ
WORKDIR /usr/src/app/

# install required gem files for Capybara
COPY ./Gemfile /usr/src/app/Gemfile
COPY ./Gemfile.lock /usr/src/app/Gemfile.lock

# RUN gem update -i /usr/local/lib/ruby/gems/2.5.0 bundler
RUN gem install bundler:2.1.4
RUN bundle install

# install chrome web
RUN apt-get update -y && \
       wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
       dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install chrome local
# ADD chrome64_68.deb /usr/src/app/chrome64_68.deb
RUN apt-get update -y && \
    apt-get install -y libnss3 fonts-liberation libappindicator3-1 libasound2 \
                        libatk-bridge2.0-0 libgtk-3-0 libnspr4 libx11-xcb1 libxss1 \
                        apt-utils libxtst6 lsb-release xdg-utils
RUN dpkg -i  chrome64_68.deb; apt-get -fy install

RUN apt-get update -y && \
 apt-get install -y unzip xvfb --no-install-recommends apt-utils qt5-default libqt5webkit5-dev \
 gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x freetds-dev  \
 libxi6 libgconf-2-4

# install chromedriver and place it ib paths
RUN CHROMEDRIVER_VERSION="85.0.4183.87" && \
   mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
   curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
   unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
   rm /tmp/chromedriver_linux64.zip && \
   chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
   ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

