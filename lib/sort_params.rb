class SortParams
  DEFAULT_SORT = 'id'
  DEFAULT_DIRECTION_PARAMS = ['ASC', 'DESC']

  attr_reader :sort_attributes, :direction_params

  def initialize sort_attributes, direction_params = DEFAULT_DIRECTION_PARAMS
    @sort_attributes = sort_attributes
    @direction_params = direction_params
  end

  def process raw_sort_param
    sort_params = parse raw_sort_param
    sort_params = sort_params.select { |sort_param| sort_attributes.include? sort_param[:sort_by] }
    if sort_params.first.nil?
      default_sort_params
    else
      sort_params.first
    end
  end

  def parse raw_sort_param
    return [] unless raw_sort_param.is_a?(String)

    sort_array = []
    sort_params = raw_sort_param.split(',')

    sort_params.each do |sort_param|
      match = /(-)?(.+)/.match(sort_param)
      direction = match[1] ? direction_params[1] : direction_params[0]
      sort_array << { sort_by: match[2], direction: direction }
    end

    sort_array
  end

  def default_sort_params
    { sort_by: DEFAULT_SORT, direction: direction_params[0] }
  end
end
