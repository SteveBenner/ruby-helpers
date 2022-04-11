# Copyright (C) 2014 Stephen C. Benner
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# The license can be found within the root directory of this
# repository, in the file LICENSE.md

# This is a special tag helper that generates multiple HTML tags in the style of HTML5 Boilerplate,
# meaning each is placed within an IE conditional comment and has special classes applied to it.
# One tag is created for each version of Internet Explorer specified in the first argument.
#
# @see https://github.com/h5bp/html5-boilerplate/blob/v4.3.0/doc/html.md#conditional-html-classes
#
# @note This helper requires a Slim block!
# @note The output of this helper must be HTML escaped!
#
# @param [Range] ie_versions A range of IE versions to generate code for, in which the
#   lowest value represents the oldest version of Internet Explorer supported by your site.
# @param [Hash] attributes One or more HTML attributes to apply to each HTML element created.
# @return [String] Output of given Slim block wrapped in HTML tags within IE conditional comments
#
# @example For a complete example, refer to {https://gist.github.com/SteveBenner/5df58e30de5165a44822 this GitHub gist}.
#   doctype html
#   == conditional_html_tags_for_ie_versions 8..10, lang: 'en'
#     # ... web page content ...
#
def conditional_html_tags_for_ie_versions(ie_versions, attributes={})
  # Create an array from given range that allows us to generate the code via simple iteration
  ie_versions = ie_versions.to_a.unshift(ie_versions.min - 1).push(ie_versions.max + 1)
  # Classes from user-provided String or Array are appended after the default ones
  extra_classes = attributes.delete(:class) { |key| attributes[key.to_s] }

  commented_html_tags = ie_versions.collect { |version|
    # A 'lt-ie' class is added for each supported IE version higher than the current one
    ie_classes  = (version+1..ie_versions.max).to_a.reverse.collect { |j| "lt-ie#{j}" }
    class_str   = ie_classes.unshift('no-js').push(extra_classes).compact.join ' '
    attr_str    = attributes.collect { |name, value| %Q[#{name.to_s}="#{value}"] }.join ' '
    html_tag    = %Q[<html class="#{class_str}"#{' ' unless attr_str.empty?}#{attr_str}>]
    # The first and last IE conditional comments are unique
    version_str = case version
      when ie_versions.min then
        "lt IE #{version + 1}"
      # Side effects in a `case` statement are rarely a good idea, but it makes sense here
      when ie_versions.max
        # This is rather crucial; the last HTML tag must be uncommented in order to be recognized
        html_tag.prepend('<!-->').concat('<!--') # Note that both methods are destructive
        "gt IE #{version - 1}"
      else "IE #{version}"
    end
    %Q[<!--[if #{version_str}]#{html_tag}<![endif]-->]
  }.flatten * $/
  # Return the output from given Slim block, wrapped in the code for commented HTML tags
  [commented_html_tags, yield, $/, '</html>'].join
end