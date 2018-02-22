def sluggish_octopus(arr)
  arr.each_with_index do | el1, i1 |
    longest = true
    arr.each_with_index do | el2, i2 |
      next if i1 == i2
      longest = false if el2 > el1
    end
    return el1 if longest
  end
end

def dominant_octopus
  
end

def clever_octopus(arr)
  longest = arr[0]

  arr.each do | el |
    if el.length > longest.length
      longest = el
    end
  end

  longest
end
