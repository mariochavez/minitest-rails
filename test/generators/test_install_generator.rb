require "helper"
require "generators/mini_test/install/install_generator"

class TestInstallGenerator < GeneratorTest

  def test_install_generator
    assert_output(/create  test\/test_helper.rb/m) do
      MiniTest::Generators::InstallGenerator.start
    end
    assert File.exists? "test/test_helper.rb"
    contents = File.read "test/test_helper.rb"
    assert_match(/require "rails\/test_help"/m, contents)
    assert_match(/require "minitest\/rails"/m, contents)
    if Rails::VERSION::STRING >= "4.0"
      assert_match(/ActiveRecord::Migration.check_pending\!/m, contents)
    else
      refute_match(/ActiveRecord::Migration.check_pending\!/m, contents)
    end
  end

end
