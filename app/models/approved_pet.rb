class ApprovedPet
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new()
  end

end
