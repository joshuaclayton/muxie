require 'spec_helper'

describe "muxie DSL" do
  it "generates the correct commands" do
    commands = [
      %{tmux new-window -n AppName},
      %{tmux split-window -p25},
      %{tmux select-pane -t1},
      %{tmux split-window -p25 -dh},
      %{tmux select-pane -t2},
      %{tmux split-window -p50},
      %{tmux select-pane -t0},
      %{tmux send-keys -t0 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t1 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t2 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t3 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t0 "vim ." C-m},
      %{tmux send-keys -t2 "guard" C-m},
      %{tmux send-keys -t3 "evergreen serve" C-m}
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

  it "more than two splits per pane" do
    commands = [
      %{tmux new-window -n AppName},
      %{tmux split-window -p34 -dh},
      %{tmux split-window -p50 -dh},
      %{tmux select-pane -t2},
      %{tmux split-window -p34},
      %{tmux select-pane -t2},
      %{tmux split-window -p50},
      %{tmux select-pane -t0},
      %{tmux send-keys -t0 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t1 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t2 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t3 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t4 "cd ~/dev/thoughtbot/app" C-m},
      %{tmux send-keys -t0 "vim ." C-m},
      %{tmux send-keys -t1 "tail -f log/test.log" C-m},
    ]

    Muxie.run do
      window "AppName" do
        root "~/dev/thoughtbot/app"

        vpane 34, "vim ."
        vpane 33, "tail -f log/test.log"
        vpane 33 do
          hpane 34
          hpane 33
          hpane 33
        end
      end
    end.commands.should == commands
  end
end
