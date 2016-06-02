class Basket

  def initialize
    @items  = []
    @total  = 0
    @vat    = 0
  end

  def scan item
    # do we have such item in store
    validate_item item
    @total += get_price item
    @vat   += get_vat item
  end

  def total
    (@total+@vat).round 2
  end

  private

  # I hope that in scope of this task we have only 3 items
  def get_price item
    case item
      when "001"
        20.00
      when "002"
        33.90
      when "003"
        9.00
    end
  end

  def get_vat item
    case item
      when "001"
        0
      when "002"
        33.90*0.05
      when "003"
        9.00*0.2
    end
  end

  def validate_item item
    raise ItemNotFoundError, item unless ['001', '002','003'].include? item
  end
end


class ItemNotFoundError < StandardError
  def initialize id
    super "Item with id = '#{id}' is not found in our store"
  end
end
