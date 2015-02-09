# Helpers for outputting text and other forms of content to be rendered in templates and web pages

# Generates copyright text from a name, using the current year as default date.
#
# @param name       [String]  Legal entity which holds the copyright
# @param start_date [Integer] Begin year for copyright
# @param end_date   [Integer] End year for copyright
#
def copyright(name, start_date=Time.now.year, end_date=Time.now.year)
  "Copyright © #{start_date}-#{end_date} #{name}. All rights reserved."
end

# @author Nathan Henderson <nathos@nathos.com>
# @return [String] Beginning and ending years for a Copyright
def copyright_from(start_year)
  end_year = Date.today.year
  (start_year == end_year) ? start_year.to_s : "#{start_year}-#{end_year}"
end

# @author Fabien Piuzzi <http://demenzia.net/>
# @return [String] The current date
def display_date(date)
  # See {Date#strftime} for complete formatting documentation
  if date.is_a?(Date)
    date.strftime("%e %B %Y")
  else
    date
  end
end

# @author Fabien Piuzzi <http://demenzia.net/>
# @return [String] Current age of person who'se birthday was given
def display_age(birthday)
  now = Date.today
  now.year - birthday.year - (Date.new(now.year, birthday.month, birthday.day) > now ? 1 : 0)
end

# @param [#first, #last, Hash] name An object with individual components of a person's name
def full_name(name)
  "#{name.first || name[:first] || name['first']} #{name.last || name[:last] || name['last']}"
end

# Generates a Hash from given email address for use in a Gravatar URL according
# to the procedure documented at: https://en.gravatar.com/site/implement/hash/
#
# @param [String] Email address of a Gravater user
# @return [String] MD5 hash of given email
#
def gen_gravater_email_hash(email)
  Digest::MD5.hexdigest email.strip.downcase
end