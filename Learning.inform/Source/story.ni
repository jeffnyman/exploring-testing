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

[ We bypass the rules for a given action -- opening something, in this case -- and we do something else. Here the 'do something else' is simply telling the player why the action was not taken as intended. The action, at this point, is immediately ended. ]

Instead of opening the glass box:
	say "You're deterred by the swirling bottle-green mist within."

[ We can add a condition onto the rule with "when". ]

Instead of examining the message when the player is not carrying the message:
	say "You need to be holding it before you can read it."



[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Script Tests ]

Test me with "open glass box / examine message / take the message".


[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Spec Tests ]

Scenario:
	context "player can't open the glass box and accidentally kill themselves";
	verify that "open glass box" produces "You're deterred by the swirling bottle-green mist within."
	
Scenario:
	context "player can't examine the message if they're not holding it";
	verify that "examine message" produces "You need to be holding it before you can read it."
	
Scenario:
	context "player can't take message when the glass box is closed";
	verify that "take the message" produces "The glass box isn't open."