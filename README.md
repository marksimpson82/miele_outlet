# miele_outlet
Pulls down a price list .pdf file and diffs it against the previous known version (if any).

This ~~is~~ was an excuse to learn a little more PowerShell, but I ported it to bash.

I scripted it for a few reasons. I wanted to buy a product but ...
* There's no easy way to identify changes to the stock list
* The Miele outlet store updates its stock list sporadically (sometimes multiple times a day, sometimes a few times per week) which results in a lot of ctrl-F5ing for little reward
* Searching PDFs is a grubby operation

With this script, you can quickly see new stock.

## Requirements
diff.exe and Beyond Compare (bcompare.exe) must be installed and in the path. If you don't have Beyond Compare, just switch out the command for your favourite tool.

## Extensions
Run it on a cron and send a notification when a new stock list is published. Similarly, you can run pdf -> text and run your own grep commands (e.g. "dishwasher") so that you can ignore irrelevant updates.

Why would you want to do this? Well, 'cause people are f-a-s-t. If you see something on this list, there's a good chance it'll be snapped up inside the hour. 
