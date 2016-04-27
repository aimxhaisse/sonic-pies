live_loop :slow, sync: :sync do
  with_fx :level, amp: 5 do
    with_fx :wobble, phase: 128, invert_wave: [1, 0].ring.tick(:wphase) do
      with_fx :bitcrusher do
        with_fx :panslicer, phase: 4, mix: 0.25 do
          4.times do
            sample slow, 0, rate: -1
            sleep 32
          end
        end
      end
    end
  end
end
