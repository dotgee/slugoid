module Mongoid
  class Criteria
    def for_ids_with_slug(*args)
      raise args.inspect
    end
    alias_method_chain :for_ids, :slug
  end
end
