require 'spec_helper'

describe "muxie DSL" do
  it "generates the correct commands" do
    commands = [
      %{tmux new-window -n AppName},
      %{tmux split-window -p25 -t0},
      %{tmux split-window -p25 -t1 -dh},
      %{tmux split-window -p50 -t2},
      %{tmux send-keys -t 0 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t 1 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t 2 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t 3 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t 0 "vim ." C-m},
      %{tmux send-keys -t 2 "guard" C-m},
      %{tmux send-keys -t 3 "evergreen serve" C-m}
    ]

    Muxie.run do
      window "AppName" do
        root "~/dev/thoughtbot/app"

        vpane 75, "vim ."
        vpane 25 do
          hpane 75
          hpane 25 do
            vpane 50, "guard"
            vpane 50, "evergreen serve"
          end
        end
      end
    end.commands.should == commands
  end
end
