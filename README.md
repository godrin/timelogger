# Time-logger

A very simplistic time-logging framework.
Just put a "doing" file in this directory and add a call to cron

```
	* * * * * ~path to this file~/cron.rb >/dev/null
```
Install gems:
```
gem install pp json time gli
```
To display:
```
ze read log* |ze view
ze read log* | ze group| ze view
```

Or shorter:
```
./ze run 'read log*|group|view'
```
