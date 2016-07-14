# A E A B

use_bpm 120

live_loop :main do
  sample :loop_garzul, beat_stretch: 16
  sleep 16
end

_0x03_c = [:a3, :e3, :a3, :b3]

live_loop :chords, sync: :main do
  with_fx :ixi_techno, phase: 8, mix: 0.25 do
    _0x03_c.each do |c|
      use_synth :tri
      play chord(c, :m7), sustain: 4
      sleep 4
    end
  end
end

live_loop :arp, sync: :main do
  use_synth :chiplead
  with_fx :ixi_techno, phase: 8, mix: 0.5 do
    with_fx :wobble, phase: 0.25, mix: 0.5 do
      4.times do
        _0x03_c.each do |c|
          4.times do
            [2, 2, 2, 0, 2, 2, 1, 1].each do |i|
              play chord(c, :m7)[i] + 12, release: 0, sustain: 0.20
              sleep 0.25
            end
          end
        end
      end
    end
  end
end
