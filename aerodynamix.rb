# Aerodynamix - by s. rannou <mxs@sbrk.org> @aimxhaisse
#
# An attempt to recreate 'Daft Punk - Aerodynamic'

use_bpm 123

# Base sample extracted from Il Maqcuillage Lade - Sister Sledge

aero_base = "~/il-maquillage-lady-sample.aiff"
load_sample aero_base

# Introduction

live_loop :intro do
  sync :do_intro

  use_synth :pretty_bell
  use_synth_defaults release: 4, decay: 2, amp: 4, attack_level: 1.5, release_level: 0.5, decay_level: 0.125

  with_fx :reverb, root: 0.75 do
    play :A3
    sleep 8
  end
end

# Verse

define :aero_sample do |samples, alt|
  # 1 beat = 0.0625, 0.5 beat = 0.03125
  use_sample_defaults beat_stretch: 16, amp: 3

  samples.each do |what|
    sample aero_base, start: 0.934, finish: 0.96525 if what == :bass_1
    sample aero_base, start: 0.653, finish: 0.68425 if what == :bass_2
    sample aero_base, start: 0.090, finish: 0.1525 if what == :guit_1
    sample aero_base, start: 0.465, finish: 0.49625 if what == :guit_2
    sample aero_base, start: 0.465, finish: 0.480625 if what == :guit_3 and alt
  end
end

live_loop :verse do
  sync :do_verse

  alt = [false, false, false, true].ring.tick(:flavor)
  do_invert_flanger = [0, 1].ring.tick(:invert_flanger)

  samples = [[[:bass_1], 0.5],
             [[:guit_1, :guit_3], 0.25],
             [[:bass_1], 0.5],
             [[:guit_3], 0.25],
             [[:bass_1], 0.5],
             [[:guit_2], 0.5],
             [[:guit_1], 1],
             [[:bass_2], 0.5]]

  samples.each do |s, delay|
    aero_sample(s, alt)
    sleep delay
  end
end

# Guitare Solo

solo_chords = [
  [:D3, :Fs2, :B2],
  [:D3, :Gs2, :B2],
  [:G3, :B2, :E3],
  [:E3, :A2, :Cs3],

  [:D3, :Fs3, :B2],
  [:D3, :Gs3, :B2],
  [:G3, :B2, :E3],
  [:E3, :A2, :Cs3],
]

live_loop :solo do
  sync :do_solo

  use_synth :zawa
  use_synth_defaults attack: 0.03, sustain: 0.17, release: 0.1, res: 0.8, phase: 2, wave: 2, amp: 1

  with_transpose 12 do
    c = solo_chords.ring.tick(:patterns)
    with_fx :bitcrusher, sample_rate: 8000, mix: 0.5 do
      4.times do
        melody = c.dup
        melody.push(c[1])
        tick_reset :note
        4.times do
          n = melody.ring.tick(:note)
          play note: n
          sleep 0.25
        end
      end
    end
  end
end

live_loop :aerodynamix do
  4.times do
    cue :do_intro
    sleep 8
  end
  16.times do
    cue :do_verse
    sleep 4
  end
  16.times do
    cue :do_solo
    sleep 4
  end
  16.times do
    cue :do_solo
    cue :do_verse
    sleep 4
  end
  cue :do_intro
  stop
end
