class ScramblePair

  EXCEPTIONS = [
    "AI","AY","EA","EE","EO","IO","OA","OO","OY","YA",
    "YO","YU","BL","BR","CH","CK","CL","CR","DR","FL",
    "FR","GH","GL","GR","KL","KR","KW","PF","PL","PR",
    "SC","SCH","SCR","SH","SHR","SK","SL","SM","SN","SP",
    "SQ","ST","SW","TH","THR","TR","TW","WH","WR"
  ]

  #---------------------------------------------#

  def initialize(regular_text, scrambled_text)
    @regular_text = regular_text
    @scrambled_text = scrambled_text
  end

  #---------------------------------------------#

  def check_scramble_quality
    if !is_scrambled?
      puts "#{@scrambled_text} is not a scramble of #{@regular_text}"
    elsif is_poor_scramble?
      puts "#{@scrambled_text} is a poor scramble of #{@regular_text}"
    elsif is_good_scramble?
      puts "#{@scrambled_text} is a good scramble of #{@regular_text}"
    else
      puts "#{@scrambled_text} is a fair scramble of #{@regular_text}"
    end
  end

  #---------------------------------------------#

  def is_scrambled?
    @regular_text != @scrambled_text
  end

  #---------------------------------------------#

  def is_poor_scramble?
    if first_char_in_same_place?
      return true
    end
    if consecutive_chars_in_same_place?
      return true
    end
    false
  end

  #---------------------------------------------#

  def is_good_scramble?
    unless looks_real?
      return false
    end
    true
  end

  #---------------------------------------------#

  def looks_real?
    @scrambled_text.length.times do |index|
      next if @scrambled_text[index+1] == nil
      #check for two vowels or two consonant in a row
      if is_vowel?(@scrambled_text[index])
        if is_vowel?(@scrambled_text[index+1])
          if !meets_exception? index
            return false
          end
        end
      else
        #consonant by default
        if is_consonant? @scrambled_text[index+1]
          if !meets_exception? index
            return false
          end
        end
      end
    end
    true
  end

  #---------------------------------------------#

  def first_char_in_same_place?
    @regular_text[0] == @scrambled_text[0]
  end

  #---------------------------------------------#

  def consecutive_chars_in_same_place?
    @regular_text.split('').each_cons(2) do |chars|
      merged_chars = chars.join('')
      if @regular_text.index(merged_chars) == @scrambled_text.index(merged_chars)
        return true
      end
    end
    false
  end

  #---------------------------------------------#

  def any_chars_in_same_place?
    @regular_text.length.times do |index|
      if @regular_text[index] == @scrambled_text[index]
        return true
      end
    end
    false
  end

  #---------------------------------------------#

  def is_consonant?(letter)
    !is_vowel? letter
  end

  #---------------------------------------------#

  def is_vowel?(letter)
    "aeiouy".include? letter.downcase
  end

  #---------------------------------------------#

  def meets_exception?(index)

    char1 = @scrambled_text[index]
    char2 = @scrambled_text[index+1]
    char3 = @scrambled_text[index+2]

    #two consonants in a row are ok if they are the same
    if (char1 == char2) and (is_consonant?(char1) and is_consonant?(char1))
      return true
    end

    composed_chars = char1+char2
    if EXCEPTIONS.include? composed_chars
      return true
    end

    if char3 != nil
      composed_chars = composed_chars+char3
      if EXCEPTIONS.include? composed_chars
        return true
      end
    end

    false
  end

end
