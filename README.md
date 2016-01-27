Oyster Card Challenge
====================

This is a solution to Makers Academy's [Oystercard Challenge](https://github.com/makersacademy/course/tree/master/oystercard).

This solution uses a test-driven approach, with unit and feature tests implemented using [RSpec](http://rspec.info).

## Installation

Need to clone the repository and then change into the directory:

```
$ git clone git@github.com:Andrew47/Oyster_card.git
$ cd Oyster_card
```
Will need to run `bundle`. This will install any required files.

## Usage

To use the program, run pry and load the oystercard.rb file:

```
$ pry
$ require './lib/oystercard'
```
Then a new Oyster Card can be created (`oystercard = Oystercard.new`) and a new
station (`station = Station.new('name',1)`). The first argument is the station's
name. The second argument is the station's zone.

###The Customer can

* View their card's balance: `oystercard.balance`
* Add money (e.g. £1): `oystercard.top_up(1)`
* Journey between stations:

```
entry_station = Station.new('entry', 1)
exit_station = Station.new('exit', 2)
oystercard.touch_in(entry_station)
oystercard.touch_out(exit_station)
```
* See list of previous trips: `oystercard.journey_history`
* See zone of station: `station.zone`

The customer cannot have a balance above £90 on their card. The fare is calculated
dependent on the zones of the entry and exit stations. This is deducted from the
Oyster Card balance. Fines are charged when touching in or out is missed.

## User Stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
## Contributors

* [Andrew Burnie](https://github.com/Andrew47)
* [Michael Lennox](https://github.com/michaellennox) michael@michaellennox.me
* [Colin McCulloch](https://github.com/ColinMcCulloch)
* [Chris Wynne](https://github.com/Wynndow)
* [Tom Bradley](https://github.com/trbradley)
* [Sara Tateno](https://github.com/saratateno)
* [Katie Smith](https://github.com/klssmith)
