# Prime-Challenge

Tests can be run from the turffle console. There is a lot of room for improvement: 

Calculating the APY more accurately or establishing a better way to allow the user to withdraw only after a certain amount of time has elapsed.

The vault itself is designed to support multiple tokens, initially I thought of using IERC20 to import the tokens and keep track of them using a `ticker`.

The main problem I faced at this point is that the `vualtTest.js` file doesn't behave as expected with deposits. 

The same code though behaves properly when being run from the scripts. 

I've therefore commented out a section of `vualtTest.js` in favor of a script file that handles the requirements. 
