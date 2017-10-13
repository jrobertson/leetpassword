#!/usr/bin/env ruby

# file: leetpassword.rb

require 'random_word'

class LeetPassword

  def self.generate(max_len=nil, subs={i: '1', o: '0', e: '3'})

    if max_len and max_len <= 6 then
      raise "max length must be greater than 6 characters"
    end

    noun = RandomWord.nouns.next.gsub(/_/,'')   
    if max_len then
      until noun.length >= 6 and noun.length <= max_len
        noun = RandomWord.nouns.next.gsub(/_/,'')      
      end
    end

    subs.each{|k,v| noun.gsub!(k.to_s,v)}
    return noun if noun.length > 7

    adj = RandomWord.adjs.next.gsub(/_/,'')
    if max_len then
      until adj.length >= 6 and adj.length <= max_len
        adj = RandomWord.adjs.next.gsub(/_/,'')     
      end
    end

    subs.each{|k,v| adj.gsub!(k.to_s,v)}

    return adj if adj.length > 7    

    if max_len then
      if (adj+noun).length <= max_len then
        return adj + noun
      else
        LeetPassword.generate(max_len,subs)
      end
    else
      return adj + noun
    end
  end
end

if __FILE__ == $0 then
  RandomWord.generate
end
