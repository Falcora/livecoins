livecoins
=========

Keep track of your crypto portfolio.

I started this project when I got sick of constantly checking multiple websites and pages to get my account balances and exchange rates, and then pulling out the calculator to figure out how much I had made mining so far.  Now I can view everything at a glance.

LiveCoins interfaces with the APIs from Cryptsy, Coinbase, and Multipool in order to show your Cryptsy Portfolio at a glance.  Currently it only supports BTC and DOGE, but the code should be fairly simple to modify in order to display the data you are interested in.

This is still a work in progress, so stay tuned for updates which will improve performance, and error handling.  Bear in mind that the Cryptsy and Multipool APIs are frequently slow and unresponsive.  The app attempts to pull new data every 60 seconds.  If a value is not current, it will be shown in a light red color.  It will change to white once it has been updated.

To get started:

1) Open LCHUDViewController

2) Near the top, you will see a bunch of #defines asking for api keys.  Input your api keys, which you can create on Cryptsy, MultiPool, and Coinbase.

3) Sign using your own developer identity, then build and run!

- LiveCoins is a universal app, so it will run great on both iPhone and iPad. 

- Feel free to send pull requests.  Since it is unlikely that Apple would approve an app like this, I figured it would just be a fun open source project.  Working with the authorization on Cryptsy and Multipool was a little tricky, since it implemented HMAC SHA256 and SHA5212 hashes.  I hadn't worked with those before.  If you have had trouble getting these to work in your own projects, feel free to use my code to get started.
