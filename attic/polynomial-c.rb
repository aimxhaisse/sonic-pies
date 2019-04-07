use_bpm 138

chords = [
  chord(:A3, :M, num_octaves: 2),
  chord(:A3, :m, num_octaves: 2),
]

pattern = "12123-12123-123-".ring

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

live_loop :bassline do
  with_fx :ixi_techno, phase: 16, cutoff_min: :C6, cutoff_max: :C7 do
    with_fx :reverb, room: 0.99, damp: 0.25 do
      chords.each do |c|
        2.times do
          mk_bassline(c).each do |n|
            synth :saw, note: n[0], release: n[1], attack: 0, res: 0.99 if n[0] > 0
            sleep 0.25
          end
        end
      end
    end
  end
end
