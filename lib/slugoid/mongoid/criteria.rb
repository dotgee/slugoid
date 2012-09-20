module Mongoid
  class Criteria

    def find_with_slug(*args)
      ids = args.__find_args__
      raise_invalid if ids.any?(&:nil?)
      ids.flatten!

      if @klass.respond_to?(:acts_as_slugoid_options) && !ids.first.is_a?(::Moped::BSON::ObjectId)
        if ids.size > 1
          return self.in(@klass.acts_as_slugoid_options[:store_as] => ids)
        else
          return self.find_by(@klass.acts_as_slugoid_options[:store_as] => ids.first)
        end
      else
        for_ids(ids).execute_or_raise(ids, args.multi_arged?)
        # find_without_slug(ids)
      end
    end
    alias_method_chain :find, :slug

    def for_ids_with_slug(ids)
      ids.flatten!
      if ids.first.is_a?(::Moped::BSON::ObjectId)
        return for_ids_without_slug(ids)
      else 
        if ids.size > 1
          self.in(@klass.acts_as_slugoid_options[:store_as] => ids)
        else
          self.where(@klass.acts_as_slugoid_options[:store_as] => ids.first)
        end
        self
      end
    end
    # alias_method_chain :for_ids, :slug
  end
end
