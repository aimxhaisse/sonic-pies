# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

live_loop :saws do
  use_synth :dsaw
  with_fx :reverb do
    with_fx :bitcrusher, sample_rate: 5000 do
      8.times do
        play chord(scale(:C3, :minor_pentatonic).choose), release: 1, attack: 0.5, cutoff: rrand(40, 70)
        sleep 1
      end
    end
  end
end
