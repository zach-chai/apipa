module Pagination
  DEFAULT_OFFSET = 0
  DEFAULT_LIMIT = 10
  MAX_LIMIT = 100

  def process_offset(offset_range)
    page_start = offset_range['offset'].to_i rescue DEFAULT_OFFSET
    page_limit = offset_range['limit'].to_i rescue DEFAULT_LIMIT

    page_limit = [page_limit, MAX_LIMIT].min
    [page_start, page_limit]
  end
  module_function :process_offset
end
