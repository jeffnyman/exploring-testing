"Interactive Exploration" by Jeff Nyman.

Include TesterStories by Jeff Nyman.
Include i7Spec by Jeff Nyman.

The Test Lab is a room.

The Lobby is a room.
It is south of the Test Lab.

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

[ For asking Kitty to try actions, we have to set her persuasion decision such that she decides 'yes.' Without such persuasion, Kitty will always "have better things to do." ]

Persuasion rule for asking Kitty Pryde to try doing something:
	persuasion succeeds.

[ A reaching inside rule to change the principles of what can be touched. The "container in question" is the one to which the rule is being applied. The "person reaching" is, as its name suggests, the person trying to reach through the barrier in question. More specifically, the "person reaching" can be used to make sure the rule is relevant only to specific people. ]

A rule for reaching inside closed containers:
	if the person reaching is Kitty Pryde:
		if the noun is not the poison gas:
			say "As her hands pass through [the container in question], [run paragraph on]";
			allow access.

[ No one should be able to take the poison gas. The player won't be able to because they will be prevented from even opening the glass box. But Kitty can reach through the glass box, thus it's necessary to make sure that she can't take the gas. ]

Check someone taking the poison gas:
	rule fails.
	
[ Then to make sure this gets handled contextually, we'll handle an unsuccessful attempt. This works with the check for "if the noun is NOT the poison gas" in the rule for reaching inside closed containers. ]

Unsuccessful attempt by Kitty Pryde taking the poison gas:
	say "Kitty looks at you as if you were an idiot. 'How exactly do you expect me to do that?'"

[ There needs to be a way to have a conclusion. One such can happen via a check on every turn to see if the player has been exposed to the gas. ]

Every turn:
	if the player can touch the poison gas for more than one turn:
		say "The poison gas has reached your lungs.";
		if Kitty Pryde can see the player:
			say "Kitty seems to take a disturbing interest in your writhing spasms.";
		end the story.


[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Script Tests ]

[ With the exception of the dying alone (or dying in front of Kitty, depending on which condition you want), the entire test suite can be reduced to one test. ]

Test phasing with "open glass box/ examine message / take the message / Kitty, get the message / look at the box / Kitty, take the gas / Kitty, open the box / south / north / wait".

Test death_alone with "Kitty, open the box / Kitty, go south."


[ +++++++++++++++++++++++++++++++++++++++++++++++++++ ]
[ Spec Tests ]

[ You can't test death states via the scenarios and that's because there is a meta game aspect that occurs: namely, your death. This forces Inform to ask the player what the want to (quit the game, restore a saved position, etc). ]

Scenario:
	context "player can't open the glass box and accidentally kill themselves";
	verify that "open glass box" produces "You're deterred by the swirling bottle-green mist within."
	
Scenario:
	context "player can't examine the message if they're not holding it";
	verify that "examine message" produces "You need to be holding it before you can read it."
	
Scenario:
	context "player can't take message when the glass box is closed";
	verify that "take the message" produces "The glass box isn't open."
	
Scenario:
	context "Kitty can take the message without opening the glass box";
	verify that "Kitty, get the message" produces "As her hands pass through the glass box, Kitty Pryde picks up the message.";
	verify that "examine box" produces "In the glass box are some poison gas."
	
Scenario:
	context "Kitty won't take the poison gas when asked";
	verify that "Kitty, take the gas" produces "Kitty looks at you as if you were an idiot. 'How exactly do you expect me to do that?'"