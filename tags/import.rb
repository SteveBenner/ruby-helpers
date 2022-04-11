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
require 'pathname'

# This tag represents an HTML import, and might fall into the category of 'web components'
#
# @param [URL] url Name of the HTML source file for this import (with or without extension)
# @return [String] HTML tag of the format: <link rel="import" href="#{url}">
#
def import(url)
  %Q[<link rel="import" href="#{url}/#{Pathname(url).sub_ext '.html'}">]
end