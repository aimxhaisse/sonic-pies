use_bpm 138

chords = [
  chord(:D3, :M, num_octaves: 2),
  chord(:D3, :m, num_octaves: 2),
  chord(:F3, :M, num_octaves: 2),
  chord(:E3, :m, num_octaves: 2)
]

pattern = "31-32-3132-1213-".ring

define :mk_bassline do |c|
  i = 0
  seq = []
  until i == pattern.length
    note = pattern[i] == '-' ? 0 : c[pattern[i].to_i]
    release = pattern[i + 1] == '-' ? 1 : 0.35
    seq.push([note, release])
    i += 1
  end
  return seq
end

define :mk_melody do |c|
  i = 0
  seq = []
  until i == pattern.length
    note = pattern[i] == '1' ? c[pattern[i].to_i] + 12 : 0
    seq.push(note)
    i += 1
  end
  return seq
end

live_loop :pads do
  with_fx :ixi_techno, phase: 8, cutoff_min: :C5, cutoff_max: :C7 do
    chords.each do |c|
      synth :fm, sustain: 7.5, release: 2, note: c, amp: 1.1
      sleep 8
    end
  end
end

live_loop :mel do
  with_fx :reverb do
    chords.each do |c|
      2.times do
        mk_melody(c).each do |n|
          synth :fm, note: n + 12, release: 2, amp: 0.75 if n
          sleep 0.25
        end
      end
    end
  end
end

live_loop :bassline do
  with_fx :ixi_techno, phase: 32, cutoff_min: :C6, cutoff_max: :C7 do
    with_fx :reverb, room: 0.99, damp: 0.25 do
      chords.each do |c|
        2.times do
          mk_bassline(c).each do |n|
            synth :saw, note: n[0], release: n[1], attack: 0 if n[0] > 0
            sleep 0.25
          end
        end
      end
    end
  end
end
