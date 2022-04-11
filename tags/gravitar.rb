require 'digest/md5'
# This IMG tag implements the Gravitar API
#
# @see https://en.gravatar.com/site/implement/images/ Official docs
#
# @param [String] email Email address of the Gravater user
# @return [String] HTML of the IMG tag
#
# @example
#   = gravater_tag 'me@domain.com'
#
def gravatar_tag(email, opts={})
  # todo: handle options
  # Generate Gravatar ID hash from the email
  hash = Digest::MD5.hexdigest email.strip.downcase
  hash.concat "?s=#{opts[:size]}" if opts[:size]
  class_str = %Q[class="#{opts[:class]}" ] if opts[:class]
  # Return the IMG tag containing fully-constructed Gravatar API query
  %Q[<img src="http://www.gravatar.com/avatar/#{hash}" #{class_str}/>]
end