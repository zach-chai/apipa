module Ohm
  class Set
    def sort_and_paginate(attribute_name, direction, offset_limit)
      if attribute_name == SortParams::DEFAULT_SORT
        sort order: direction, limit: offset_limit
      else
        sort_by attribute_name, order: "ALPHA #{direction}", limit: offset_limit
      end
    end
  end
end
