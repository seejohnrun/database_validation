module DatabaseValidation

  def self.version
    VERSION.join('.')
  end

  private

  VERSION = [0, 0, 3]

end
