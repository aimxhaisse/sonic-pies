# A E A B

use_bpm 120

live_loop :main do
  sample :loop_garzul, beat_stretch: 16
  sleep 16
end

live_loop :ab, sync: :main do
  16.times do
    sample :bd_tek
    sleep 1
  end
end

_0x03_c = [:a3, :e3, :a3, :b3]

live_loop :chords, sync: :main do
  with_fx :panslicer, phase: 0.25, mix: 0.5 do
    _0x03_c.each do |c|
      use_synth :blade
      play chord(c, :m7) - 12, sustain: 4
      use_synth :chipbass
      play chord(c, :m7), sustain: 4
      sleep 4
    end
  end
end

live_loop :mot, sync: :main do
  _0x03_c.each do |c|
    "...xx.......x.xx".ring.each do |t|
      if t == "x"
        use_synth :tb303
        play c + 12, release: 0, sustain: 0.125
      end
      sleep 0.25
    end
  end
end

live_loop :arp, sync: :main do
  use_synth :chiplead
  with_fx :ixi_techno, phase: 16, mix: 0.5 do
    with_fx :wobble, phase: 0.25, mix: 0.5 do
      _0x03_c.each do |c|
        4.times do
          [2, 1, 2, 1, 2, 0, 1, 1].each do |i|
            play chord(c, :m7)[i] + 12, release: 0, sustain: 0.20
            sleep 0.25
          end
        end
      end
    end
  end
end
