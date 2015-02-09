# This tag allows you to load one or more font families into your page via the Google Fonts API
#
# @see https://developers.google.com/fonts/ The Web Fonts Project
# @see http://www.google.com/fonts Google Fonts Repository
#
# @note This tag MUST be placed in the <head></head> section of your webpage.
#
# @overload google_fonts(family)
#   Load a single font family in the default 'normal' style
#   @param [String, Symbol] family Name of a single font family to load
#
# @overload google_fonts(family, style)
#   Load a specific style of given font family
#   @param [String, Symbol] family Name of the font family to load
#   @param [String, Symbol, Integer] style Name of the font family style to load
#
# @overload google_fonts(family, styles)
#   Load multiple styles of specified font family
#   @param [String, Symbol] family Name of the font family to load
#   @param [Array<String, Symbol, Integer>] styles Styles of specified font family to load.
#
# @overload google_fonts(families)
#   Load multiple font families in the default 'normal' style
#   @param [Array<String, Symbol>] family List of font families to load
#
# @overload google_fonts(families, style)
#   Load the same style of multiple font families
#   @param [Array<String, Symbol>] families List of font families to load
#   @param [Array<String, Symbol, Integer>] style Name of the style of all loaded font families
#
# @overload google_fonts(families, styles)
#   Load the same set of styles of multiple font families
#   @param [Array<String, Symbol>] families List of font families to load
#   @param [Array<String, Symbol, Integer>] styles List of styles to load from each font family
#
# @overload google_fonts(mapping)
#   Load one or more styles of one or more font families according to their mapping
#   @param [Hash{String, Symbol => String, Symbol, Integer, Array<String, Symbol, Integer>}] mapping Keys
#     represent font families which may be assigned one or more styles in a convenient format
#
# @return [String] HTML of the link tag
#
# @example
#   = google_fonts(:inconsolata, :italic)       # use Symbols
#   = google_fonts('Inconsolata', 'bold')       # use Strings
#   = google_fonts('Droid Serif', :b)           # use abbreviations for bold (b) italic (i) or both (bi)
#   = google_fonts('Droid Serif', 700)          # use the numerical weight
#   = google_fonts('Lato', [100, 300, 400])     # use multiple weights
#   = google_fonts('Lato', [100, :b, 'italic']) # mix and match data types (whoaaa)
#
#   # Load multiple font families at once, in the same styles
#   = google_fonts([:inconsolata, :lato, :droid_serif])
#   = google_fonts([:inconsolata, :lato, :droid_serif], :i)
#   = google_fonts(['Lato', 'Droid Sans'], [400, :bolditalic])
#
#   # Specify exactly which styles of which fonts you need, all in a single convenient Hash
#   = google_fonts(lato: 100, 'Droid Sans' => :bold, 'Philosopher' => [100, 300, 400])
#
# @todo: this feels like tacky code. Redo in a more elegant manner someday
def google_fonts(*query)
  raise ArgumentError, 'Expected at least one font.' if query.empty?
  if query.first.is_a? Hash
    query = [*query.first].transpose
    query = [query.first, query.last.to_enum]
  end
  api_base_url = 'http://fonts.googleapis.com/css'
  # Build query stringby iterating through given font families and styles
  query_string = '?family=' + [*query.first].collect { |family|
    # Stringify and title-case family names, replacing underscores with spaces
    family_str = family.to_s.split(/ |_/).map(&:capitalize).join('+')
    # Append any given styles to current font family string
    if query[1]
      # Using an Enumerator allows for mapping different styles to each font family
      styles = query.last.is_a?(Enumerator) ? query.last.next : query.last
      # [API] styles are enumerated after a colon, and delineated by a comma
      family_str << ':' << [*styles].join(',')
    end
    family_str
  }.join('|') # [API] families are separated by the pipe character
  # Return the link tag containing the fully-constructed Google Fonts API query
  %Q[<link rel="stylesheet" type="text/css" href="#{api_base_url + query_string}" />]
end