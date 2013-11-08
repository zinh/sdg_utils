$LOAD_PATH << File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.expand_path('../..', __FILE__)

require 'logger'
require 'nilio'
require 'set'
require 'test/unit'
require 'pry'

require 'sdg_utils/testing/assertions'
require 'sdg_utils/testing/smart_setup'
