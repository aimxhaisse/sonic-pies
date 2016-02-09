# Sebastien Rannou <mxs@sbrk.org> @aimxhaisse

# beats

live_loop :beats do
  with_fx :echo, phase: 0.1, mix: 0.05 do
    with_fx :rhpf, cutoff: 90, res: 0.8 do
      with_fx :reverb, mix: 0.6, room: 0 do
        sample :bd_zome, rate: 1, amp: 5
      end
    end
  end
  sleep 1
end

live_loop :beats do
  with_fx :echo, phase: 0.5, mix: 0.1 do
    3.times do
      sample :bd_haus
      sleep 0.5
      sample :sn_dub
      sleep 0.5
    end
    sample :bd_haus
    sleep 0.5
    sample :sn_dub
    sleep 0.25
    sample :sn_dub
    sleep 0.25
  end
end

live_loop :beats do
  beats_flavor = {:mix => 0.9, :sample_rate => 2000, :cutoff => 70}

  with_fx :lpf, **beats_flavor do
    with_fx :bitcrusher, **beats_flavor do
      16.times do
        tick
        sample :bd_haus if spread(1, 4).look
        sample :elec_cymbal, amp: 0.5, beat_stretch: 0.1 if spread(1, 8).look
        synth :bnoise, release: 0, amp: 0.125, attack: 0.3, cutoff: 129, res: 0.5 if spread(1, 8).look
        sleep 0.125
      end
    end
  end
end
