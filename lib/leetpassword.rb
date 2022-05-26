#!/usr/bin/env ruby

# file: leetpassword.rb

require 'random_word'

class LeetPassword

  # note: nowadays it's typical for passwords to be required to
  #       contain at least 1 symbol, 2 uppercase characters and 2 numerals
  #
  def self.generate(max_len=nil, subs: {i: '1', o: '0', e: '3'},
                    symlist: ['@'], upcase: 2, symchar: 1, debug: false,
                    verbose: true)

    max_len += symchar if max_len

    if max_len and max_len <= 6 then
      raise "max length must be greater than 6 characters"
    end

    rawnoun = RandomWord.nouns.next
    hint1 = rawnoun.clone
    noun = rawnoun.gsub(/_/,'')
    if max_len then
      until noun.length >= 6 and noun.length <= max_len
        rawnoun = RandomWord.nouns.next
        hint1 = rawnoun.clone
        noun = rawnoun.gsub(/_/,'')
      end
    end


    subs.each{|k,v| noun.gsub!(k.to_s,v)}

    if noun.length > 7 then

      n = upcase / 2
      r = upcase - n
      noun.sub!(/[a-z]{#{n}}/) {|x| x.upcase}
      noun.sub!(/[a-z]{#{r}}/) {|x| x.upcase}

      noun +=  symlist.sample
      puts 'returning a noun' if debug
      puts 'hint: ' + hint1 if verbose
      return [noun, :noun, hint1]
    end

    rawadj = RandomWord.adjs.next
    hint2 = rawadj.clone
    adj = rawadj.gsub(/_/,'')

    if max_len then
      until adj.length >= 6 and adj.length <= max_len
        rawadj = RandomWord.adjs.next
        hint2 = rawadj.clone
        adj = rawadj.gsub(/_/,'')
      end
    end


    subs.each{|k,v| adj.gsub!(k.to_s,v)}

    if adj.length > 7 then
      n = upcase / 2
      r = upcase - n
      adj.sub!(/[a-z]{#{n}}/) {|x| x.upcase}
      adj.sub!(/[a-z]{#{r}}/) {|x| x.upcase}
      adj +=  symlist.sample
      puts 'returning an adjective' if debug
      puts 'hint: ' + hint2 if verbose
      return [adj, :adj, hint2]
    end

    hint = hint1 + ' ' + hint2

    if max_len then

      words = [noun, adj]

      n = upcase / 2
      r = upcase - n
      words[0].sub!(/.{#{n}}/) {|x| x.upcase}
      words[-1].sub!(/.{#{r}}/) {|x| x.upcase}
      words.insert 1, symlist.sample(symchar)

      if (words.join).length <= max_len then
        puts 'returning a maxlen word' if debug
        puts 'hint: ' + hint if verbose
        return [words.join, :maxlen, hint]
      else
        LeetPassword.generate(max_len, verbose: verbose)
      end

    else

      words = [noun, adj]
      n = upcase / 2
      r = upcase - n

      words[0].sub!(/.{#{n}}/) {|x| x.upcase}
      words[-1].sub!(/.{#{r}}/) {|x| x.upcase}
      words.insert 1, symlist.sample(symchar)
      puts 'words: ' + words.inspect if debug
      puts 'returning a variable length' if debug
      puts 'hint: ' + hint if verbose
      return [words.join, :varlen, hint]

    end

  end

  # This method makes it easier to remember the password since it consists of
  # the following:
  #
  #   * 2 words
  #   * each word is capitalized
  #   * the letters i, e, o are replaced with the numbers 1, 3, and
  #     0 respectively
  #   * the words are separated by the @ symbol
  #   * a password never longer than 12 characters
  #
  def self.easygen()
    pwd, type, hint = self.generate(12, verbose: false) until type == :maxlen
    puts 'hint: ' + hint
    return pwd
  end
end

if __FILE__ == $0 then
  RandomWord.generate
end
