require 'note'

class Slurper

  attr_accessor :note_file, :notes

  def self.slurp(note_file, reverse, tag)
    slurper = new(note_file)
    Note.config
    slurper.load_notes
    slurper.prepare_notes
    slurper.notes.reverse! unless reverse
    slurper.create_notes(tag)
  end

  def initialize(note_file)
    self.note_file = note_file
  end

  def load_notes
    self.notes = YAML.load(yamlize_note_file)
  end

  def prepare_notes
    notes.each { |note| note.prepare }
  end

  def create_notes(tag)
    puts "Preparing to slurp #{notes.size} notes into ProjectNotifier..."
    notes.each_with_index do |note, index|
      begin
        unless tag.nil?
          tags = note.tag_list || ""
          list_of_tags = tags.split(",")
          tag.split(",").each do |tag_param|
            list_of_tags << tag_param
          end
          
          note.tag_list = list_of_tags.join(",")
        end
        if note.save  
          puts "#{index+1}. #{note.subject}"
        else
          puts "Slurp failed. #{note.errors.full_messages}"
        end
      rescue ActiveResource::ConnectionError => e
        msg = "Slurp failed on note "
        if note.attributes["subject"]
          msg << note.attributes["subject"]
        else
          msg << "##{options[:reverse] ? index + 1 : notes.size - index }"
        end
        puts msg + ".  Error: #{e}"
      end
    end
  end

  protected

  def yamlize_note_file
    IO.read(note_file).
      gsub(/^/, "    ").
      gsub(/    ==.*/, "- !ruby/object:Note\n  attributes:").
      gsub(/    body:$/, "    body: |")
  end

end
