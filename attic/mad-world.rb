# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse
#
# Loop based on Mad world from Tears for fears

use_bpm 120

mad = "~/mad.wav"
load_sample mad

define :sample_chunk do |what, beat, dur, delay|
  beat = beat / 8.0
  dur = dur / 8.0
  sample what, beat_stretch: 8, start: beat, finish: beat + dur, amp: 5
  sleep delay
end

comment do
  sample_chunk(mad, 6, 0.5, 0)     # bass 2
  sample_chunk(mad, 0.0, 0.5, 0.5) # beat
  sample_chunk(mad, 7.5, 0.5, 0)   # trump
  sample_chunk(mad, 3.5, 0.5, 0.5) # synth
  sample_chunk(mad, 1.0, 0.5, 0)
  sample_chunk(mad, 0.5, 0.5, 0.5) # bass 1
  sample_chunk(mad, 7.0, 0.5, 0)   # trump
  sample_chunk(mad, 3.0, 0.5, 0.5) # synth
end

live_loop :sampling do
  uncomment do
    3.times do
      sample_chunk(mad, 6, 0.5, 0)     # bass 2
      sample_chunk(mad, 0.0, 0.5, 0.5) # beat
      sample_chunk(mad, 7.5, 0.5, 0)   # trump
      sample_chunk(mad, 3.5, 0.5, 0.5) # synth
      sample_chunk(mad, 1.0, 0.5, 0)
      sample_chunk(mad, 0.5, 0.5, 0.5) # bass 1
      sample_chunk(mad, 7.0, 0.5, 0)   # trump
      sample_chunk(mad, 3.0, 0.5, 0.5) # synth
    end

    sample_chunk(mad, 6, 0.5, 0)     # bass 2
    sample_chunk(mad, 1.0, 0.75, 0)   # trump
    sample_chunk(mad, 0.0, 0.5, 0.5) # beat
    sample_chunk(mad, 7.5, 0.5, 0)   # trump
    sample_chunk(mad, 3.5, 0.5, 0.5) # synth
    sample_chunk(mad, 2.5, 0.5, 0)
    sample_chunk(mad, 0.5, 0.5, 0.5) # bass 1
    sample_chunk(mad, 7.0, 0.5, 0)   # trump
    sample_chunk(mad, 3.0, 0.5, 0.5) # synth
  end
end
