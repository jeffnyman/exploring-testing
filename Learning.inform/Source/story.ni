"Interactive Exploration" by Jeff Nyman.

Include TesterStories by Jeff Nyman.
Include i7Spec by Jeff Nyman.

The Test Lab is a room.

[ =================================================== ]
[ Example 215: Magneto's Revenge ]

Kitty Pryde is a woman in the Test Lab.

A glass box is a container in the Test Lab.
It is closed, openable, and transparent.

In the glass box is some poison gas.
In the glass box is a thing called a message.




[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Script Tests ]

Test me with "open glass box / examine message".


[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Spec Tests ]

Scenario:
	context "player can't open the glass box and accidentally kill themselves";
	verify that "open glass box" produces "You're deterred by the swirling bottle-green mist within."
	
Scenario:
	context "player can't examine the message if they're not holding it";
	verify that "examine message" produces "You need to be holding it before you can read it."