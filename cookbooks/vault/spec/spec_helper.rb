# for some reason
# allow_any_instance(Chef::RunContext::CookbookCompiler).to receive(:each_cookbook_dep)
# does not work, override with direct implementation

class Chef
  class RunContext
    class CookbookCompiler
      def each_cookbook_dep(cookbook_name, &block)
        # null implementation
      end
    end
  end
end