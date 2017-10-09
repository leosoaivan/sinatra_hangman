# Sinatra Hangman
A Ruby implementation of Hangman, a morbid guessing game, now on the web! Read more about it on [Wikipedia](https://en.wikipedia.org/wiki/Hangman_(game)).

This app was originally designed as a command-line script and eventually re-designed for online consumption through the Sinatra framework. The biggest issue I ran into doing so was working with sessions. A number of behaviors exist around sessions, namely evaluating a player's guess. This indicated that a Class object could possibly be constructed around these behaviors, but I couldn't figure out how design a class that could persist alongside sessions.

## Installation
1. None needed. Check it out [here](https://fierce-island-53975.herokuapp.com/)!

## Running the tests
1. Make sure you have RSpec installed

    `gem install rspec`

2. Run the tests!

    `$ rspec`

## Built With
* [Sinatra](http://www.sinatrarb.com/) - Web framework
* [Heroku](https://www.heroku.com/home) - Cloud platform/server

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## To-Do
1. Add testing for HelperUtils
2. Extract guess-evaluating behaviors into a class, perhaps one that takes Sinatra sessions as an argument.

## License
N/A
