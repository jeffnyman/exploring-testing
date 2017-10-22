# Exploring Testing with Interactive Fiction

This repository will hold work I'm doing with framing testing as both exploratory and scripted. The context here will be [interactive fiction](https://en.wikipedia.org/wiki/Interactive_fiction), specifically with the use of [Inform 7](http://inform7.com/).

Inform 7 is touted as a "design system for interactive fiction based on natural language." The natural language component is interesting because, in the context of Inform, the natural language is not some abstraction layer that sits on top of code. This is not about natural language _parsing_. Here the natural language _is_ code; this is about natural language _programming_.

The types of games that get created are, like any games, those that can be explored. In this case, that exploration is entirely done via the medium of text. And the control mechanism for the game is that of entering in commands and seeing how the game responds. But providing tests for these types of games can be extremely challenging, particularly as the features of the game build up.

## Game Creation

There are two parts to creating interactive fiction with Inform 7. The first of those is the creation of the world as it will be at the start of play. This is what the player will initially encounter. The second aspect are the rules of play. These rules govern what will happen as the player explores the world, trying things out.

## Game Interaction

The core of these kinds of games is players interacting with the environment. This takes place via a kind of "conversation" where the player types in commands to the game -- to a fictional protagonist -- and the game responds to those command requests by saying that protagonist did and what happened as a result. Just like the real world, this game world has rules that apply to it and these rules are what dictates the type of responses.

The Inform 7 manual says that Inform will provide only "provide a basic, penny-plain, vanilla flavored sort of realism." Specifically there are "basic rules of realism" that every Inform project begins with.

What this means is that an Inform game has a set of physical laws built into it already. Some examples are inanimate objects do not spontaneously move or change, one solid object cannot pass through another, there are opaque barriers through which light cannot pass, and so on. These rules can stop many attempted actions.
