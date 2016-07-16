# Arrakis base - base 16

use_bpm 142

define :arrakis do |what|
  arrakis_base_dir = "/Users/mxs/Work/sonic-pies/songs/arrakis/samples/"
  
  unless ["beats", "melody", "synth", "bass", "slow"].include? what
    raise "Invalid sample dir"
  end
  
  return arrakis_base_dir + what
end
