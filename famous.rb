# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

notes = [
  0,    :As3, :G3, :F3,
  :Ds3, :Cb3, :C3, :Cb3,
  :Ds3, :Ds3, :F3, :G3,
  :As3, :G3,  :C3, :G3
].ring

live_loop :tb do
  use_synth :tb303
  use_synth_defaults \
    release: 0.5,
  sustain: 0.5,
  attack: 0.0125,
  cutoff_sustain: 0.05,
  cutoff_release: 0.05,
  cutoff_slide: 1,
  cutoff: 90

  n = notes.tick
  play n

  sleep 0.125
end
