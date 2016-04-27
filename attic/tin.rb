# Let's make some sound.

use_bpm 142

# samples
beats = "/Users/mxs/Work/sonic-pies/tindles/samples/beats/"
melody = "/Users/mxs/Work/sonic-pies/tindles/samples/melody/"
synth = "/Users/mxs/Work/sonic-pies/tindles/samples/synth/"
bass = "/Users/mxs/Work/sonic-pies/tindles/samples/bass/"
slow = "/Users/mxs/Work/sonic-pies/tindles/samples/slow/"

live_loop :sync do
  sleep 1
end

live_loop :beats, sync: :sync do
  with_fx :level, amp: 5 do
    2.times do |i|
      sample beats, i
    end
  end
  8.times do
    sample :bd_tek
    sleep 2
  end
end

live_loop :synth, sync: :sync do
  with_fx :level, amp: 5 do
    #   sample synth, 0
    # sample synth, 1
  end
  sleep 16
end

live_loop :bass, sync: :sync do
  with_fx :level, amp: 5 do
    sample bass, 0
  end
  sleep 16
end

live_loop :slow, sync: :sync do
  with_fx :level, amp: 5 do
    sample slow, 0
  end
  sleep 32
end

live_loop :melody, sync: :sync do
  with_fx :level, amp: 2 do
    with_fx :bitcrusher do
      sample melody, 0, rate: 0.5
    end
  end
  2.times do
    #    sample melody, 0, rate: 1
    sleep 16
  end
end
