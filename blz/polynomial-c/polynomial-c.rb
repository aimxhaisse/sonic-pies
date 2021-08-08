# Polynomial C - Aphex Twin Cover
#
# Made with Sonic Pi (sonic-pi.net) & BLZ Audio (blz.sbrk.org)


use_bpm 138

chords = [
  #
  [64, 69, 73], [64, 68, 73]
]

pattern = "12123-12123-123-".ring

define :rdn do |x, y|
  return x + y * rand
end

define :mk_bassline do |c|
  i = 0
  seq = []
  until i == pattern.length
    note = pattern[i] == '-' ? 0 : c[pattern[i].to_i - 1]
    release = 0.24
    seq.push([note, release])
    i += 1
  end
  return seq
end

live_loop :bass_motive do
  flavor = 1
  offset = 12
  
  if flavor == 0
    sleeps = [2, 2, 1, 1, 2]
    sustains = [0.2, 0.4, 0.3, 0.1, 0.7]
  else
    sleeps = [2, 1.0, 1.0, 0.5, 3.5]
    sustains = [0.2, 0.2, 0.1, 0.1, 0.3]
  end
  
  2.times do |i|
    sleeps.length.times do |j|
      note = chords[(i + (j / 4)) % 2][1] + offset
      midi note, sustain: sustains[j], channel: 4, vel: rdn(78, 80)
      sleep sleeps[j]
    end
  end
end

live_loop :bass do
  chords.each do |c|
    2.times do
      midi c[0], sustain: 7, vel_f: 0.5, channel: 3
      midi c[1] + 12, sustain: 7, vel_f: 0.5, channel: 3
      midi c[2] - 12, sustain: 7, vel_f: 0.5, channel: 3
      sleep 8
    end
  end
end

live_loop :arp do
  chords.each do |c|
    2.times do
      mk_bassline(c).each do |n|
        midi n[0], sustain: n[1], vel_f: 0.5, channel: 2 if n[0] != 0
        sleep 0.25
      end
    end
  end
end

patterns = [
  [
    ".H.H.HH.HH.HHHHH",
  ],
  [
    "k.k.....k.k.....",
    "..K.............",
    "....s..s....s...",
    "....S..S....S...",
    ".H.H.HH.HH.HHHHH",
  ],
]

live_loop :drums do
  current = 1
  offset = 36
  4.times do
    16.times do |i|
      patterns[current].each do |p|
        midi 0 + offset, channel: 1 if p[i] == 'k'
        midi 1 + offset, velocity: 128, channel: 1 if p[i] == 'K'
        midi 2 + offset, channel: 1 if p[i] == 's'
        midi 3 + offset, channel: 1 if p[i] == 'S'
        midi 6 + offset, vel: [200, 97, 102, 130, 200, 96].ring[i], channel: 1 if p[i] == 'H'
      end
      
      sleep 0.25
    end
  end
end
