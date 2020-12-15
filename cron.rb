#!/usr/bin/env ruby

Dir.chdir File.dirname(__FILE__)

logname="log_#{Time.now.strftime("%Y%m%d")}_auto.txt"
lines= []
begin
lines = IO.readlines(logname)
rescue
end

def getTime(s)
    if s
        x = s.scan(/^([0-9][0-9]):([0-9][0-9]) .*/)[0]
        if x
            x.map{|i|i.to_i}
        else 
            [0,0]
        end
    else
        [0,0]
    end
end
lastline = (lines[-1]||'').chomp
preline = (lines[-2]||'').chomp
topic1 = lastline.gsub(/^..... /,'')
topic2 = preline.gsub(/^..... /,'')
topic = File.open("doing"){|f|f.read}.split("\n").select{|l|not l=~/^*\// and not l=~/^\*/ and not l=~/^ *$/}[0].chomp
newline = (Time.now.strftime("%H:%M") + " "+ topic).chomp
if lastline != newline
    oh,om = getTime(lastline)
    ch,cm = getTime(newline)
    o = oh*60+om
    c = ch*60+cm
    if topic1==topic2 and topic1 == topic
        pp o,c
        if c<o+3
        # replace only last line
        File.open(logname,"w"){|o|
            lines[-1]=newline
            o.puts lines
        }
        else
        File.open(logname,"a"){|o|
            o.puts format("%02d:%02d stop",oh,om)
            o.puts newline
        }

        end
    else
        File.open(logname,"a"){|o|
            o.puts newline
        }
    end
end
