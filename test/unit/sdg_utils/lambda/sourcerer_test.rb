require 'my_test_helper.rb'
require 'parser/current'
require 'sdg_utils/lambda/sourcerer'

module SDGUtils
  module Lambda

    class SourcererTest < Test::Unit::TestCase
      include SDGUtils::Testing::SmartSetup
      include SDGUtils::Testing::Assertions
      include SDGUtils::Lambda::Sourcerer

      def test1
        src = "
def x(a)
  x = if a > 0 then 1
      else          2    
      end
  x + 2
end"

        expected_instr = "
def x(a)
  x = (a > 0) ? 1 : 2 
  x + 2
end"

        ast = parse_string(src)
        instr = reprint(ast) do |node, parent, anno|
          case node.type
          when :if then
            cond_src = compute_src(node.children[0], anno)
            then_src = compute_src(node.children[1], anno)
            else_src = compute_src(node.children[2], anno)
            "(#{cond_src}) ? #{then_src} : #{else_src}"
          else
            nil
          end
        end
        assert_equal_ignore_whitespace expected_instr, instr
      end

      def test2
        ex = assert_raise(Parser::SyntaxError) do
          parse_string("def x")
        end
        assert @err_msg
        @err_msg = nil
      end

      def on_parse_error(diag)
        @err_msg = diag.render
      end
    end

  end
end
