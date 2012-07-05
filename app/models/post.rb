require 'stanford-core-nlp'
require 'rjb'

class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :user_id, :micropost_id
  
  before_save { |post| post.content = parse(content) }
  
  def micropost
      @micropost ||= Micropost.find(micropost_id) unless micropost_id.blank?
  end
  
  def parse(content)
    #if !@micropost.content.blank? then
      
	    pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)
	    content = StanfordCoreNLP::Text.new(content)
	    pipeline.annotate(content)

	    content.get(:sentences).each do |sentence|
		    root = sentence.get(:tree)
		
		    # Get each token(word) of each sentence
		    sentence.get(:tokens).each do |token|
			    #puts token.get(:value).to_s

			    # Store location
			    if token.get(:named_entity_tag).to_s == "LOCATION" then
				    puts token.get(:value).to_s
				    return token.get(:value).to_s
			    end
		    end
	    end
	  #end
  end
end
