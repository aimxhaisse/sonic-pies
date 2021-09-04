# Polynomial C - Aphex Twin Cover
#
# Made with Sonic Pi (sonic-pi.net) & BLZ Audio (blz.sbrk.org)


use_bpm 138

chords = [
  [64, 69, 73], [64, 68, 73]
]

pattern = "12123-12123-123-".ring

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
  offset = 12
  2.times do |i|
    midi chords[i][1] + offset, sustain: 0.6, channel: 4, vel: 120
    sleep 2
    midi chords[i][1] + offset, sustain: 1.1, channel: 4, vel: 120
    sleep 2
    midi chords[i][1] + offset, sustain: 0.8, channel: 4, vel: 120
    sleep 1
    midi chords[i][1] + offset, sustain: 0.8, channel: 4, vel: 120
    sleep 1
    midi chords[(i + 1) % 2][1] + offset, sustain: 0.7,  channel: 4, vel: 120
    sleep 2
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
        midi n[0], sustain: n[1], vel_f: 0.5, channel: 2 if n[1] != 0
        sleep 0.25
      end
    end
  end
end

patterns = [
  [
    "k.k.....k.k.....",
    "....s..s....s...",
    ".H.H.HH.HH.HHHHH",
  ],
  [
    "k.k.....k.k.....",
    "....s..s....s...",
    ".H.H.HH.HH.HHHHH",
    "..k.k.k.kkkk.kk.",
  ],
  [
    "k.k.....k.k.....",
    "....s..s....s...",
    ".H.H.HH.HH.HHHHH",
    "....K..K....K...",
  ]
]

live_loop :drums do
  style = 2
  offset = 24
  16.times do |i|
    patterns[style].each do |p|
      midi 12 + offset, channel: 1 if p[i] == 'k'
      midi 14 + offset, channel: 1 if p[i] == 's'
      midi 24 + offset, vel: [200, 97, 102, 130, 200, 96].ring[i], channel: 1 if p[i] == 'H'
      midi 15 + offset, channel: 1 if p[i] == 'K'
    end
    
    sleep 0.25
  end
end

