# Module that can be included (mixin) to create and parse TSV data
module TsvBuddy
  # @data should be a data structure that stores information
  #  from TSV or Yaml files. For example, it could be an Array of Hashes.
  attr_accessor :data
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  def take_tsv(tsv)
    lines = tsv.split("\n")
    keys = lines[0].split("\t").map!(&:chomp)
    lines.shift
    survey = []
    lines.each do |line|
      values = line.split("\t")
      record = Hash.new
      keys.each_index { |index| record[keys[index]] = values[index].chomp }
      survey.push(record)
    end
    @data = survey
  end
  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    reverse = @data
    first_hash = reverse[0]
    keys_array = first_hash.keys
    line = ''
    keys_array.each { |key| line.concat(key + "\t") }
    line.chomp!("\t") << "\n"
    reverse.each do |record|
      record.each_value { |value| line << value + "\t" }
      line.chomp!("\t") << "\n"
    end
    line
  end
end
