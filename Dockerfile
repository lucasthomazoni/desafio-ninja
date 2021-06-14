FROM ruby:2.7.3

# Workdir
WORKDIR /app
COPY Gemfile Gemfile.lock ./

# Bundle install
RUN bundle -j $(nproc) --retry 5
COPY . ./

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]
