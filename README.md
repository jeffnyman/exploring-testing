# Exploring Testing with Interactive Fiction

This repository will hold work I'm doing with framing testing as both exploratory and scripted. The context here will be [interactive fiction](https://en.wikipedia.org/wiki/Interactive_fiction), specifically with the use of [Inform 7](http://inform7.com/).

Inform 7 is touted as a "design system for interactive fiction based on natural language." The natural language component is interesting because, in the context of Inform, the natural language is not some abstraction layer that sits on top of code. This is not about natural language _parsing_. Here the natural language _is_ code; this is about natural language _programming_.

The types of games that get created are, like any games, those that can be explored. In this case, that exploration is entirely done via the medium of text. And the control mechanism for the game is that of entering in commands and seeing how the game responds. But providing tests for these types of games can be extremely challenging, particularly as the features of the game build up.

## Game Files

### Source File

There is one core [story file](https://github.com/jeffnyman/exploring-testing/blob/master/Learning.inform/Source/story.ni) that will contain all of the source code for the main game. Inform 7 is somewhat unique among programming languages in that you can only have one source file for your core game.

### Extension Files

The core story file can reference files called "extensions." There are two of my own that will always be included.

* [TesterStories](https://github.com/jeffnyman/exploring-testing/blob/master/Learning.materials/Extensions/Jeff%20Nyman/TesterStories.i7x)
* [i7Spec](https://github.com/jeffnyman/exploring-testing/blob/master/Learning.materials/Extensions/Jeff%20Nyman/i7Spec.i7x)

Extension files are situated such that they go in a directory based on the name of the author.

### Examples

You will notice in the source text lines like _[ Example 215: Magneto's Revenge ]_. These comments are referring to examples that I have taken from the official Inform 7 manuals, but generally repurposed to some extent for pedagogical purposes.

The example number and name will never be modified so that you can easily reference the originals in the Inform 7 manual. This approach allows me to leverage existing material but change it to provide more focused examples of implementation, backed up by tests.

## Game Writing and Playing

The person who creates the interactive fiction is it's author. That's simple enough. But what about the player? The player is obviously the human being playing the game. But that player is controlling a fictional protagonist in the game world. That protagonist is sometimes called the player character (PC). There are also other characters that might be part of a game and those are traditionally called non-player characters (NPCs). Taken together, any entity modeling a person or animal or living entity in such a game world is referred to as an _actor_.

## Game Creation

There are two parts to creating interactive fiction with Inform 7. The first of those is the creation of the world as it will be at the start of play. This is what the player will initially encounter. The second aspect are the rules of play. These rules govern what will happen as the player explores the world, trying things out.

## Game Interaction

In terms of interaction, the core idea is players interacting with an environment. This takes place via a kind of "conversation" where the player types in commands to the game and the game responds to those command requests by saying what the actor who received the command did and what happened as a result. Just like the real world, this game world has rules that apply to it and these rules are what dictates the type of responses.

The Inform 7 manual says that Inform will provide only "provide a basic, penny-plain, vanilla flavored sort of realism." Specifically there are "basic rules of realism" that every Inform project begins with.

What this means is that an Inform game has a set of physical laws built into it already. Some examples are inanimate objects do not spontaneously move or change, one solid object cannot pass through another, there are opaque barriers through which light cannot pass, and so on. These rules can stop many attempted actions. A very common example is that built-in rules ensure that actions are rejected if the actor would need to touch something that's out of reach or see something that's invisible.

## Game Actions

When a player explores interactive fiction, that exploration takes the form of a series of actions. The author's role, when creating such interactive fiction, is thus responding to those actions. As per the above, Inform imposes rules on actions. But it's also possible for authors to impose extra rules on those actions.

It's this interplay of action and rule that provides fertile ground for considering how to test such games, both in exploratory and scripted fashion.
