TesterStories by Jeff Nyman begins here.

"This extension exists to keep the source text clean for demonstration purposes as part of the exploratory testing series."

Use American dialect.
Use brief room descriptions.
Use no deprecated features.
Use unabbreviated object names.
Use DICT_WORD_SIZE of 15.

Rule for printing the banner text:
	say "[bold type][story title][roman type][line break]";
	say "[italic type][story headline][roman type][line break]".

To say p: say "[paragraph break]".
To say br: say "[line break]".

To say i -- beginning say_i -- running on: (- style underline; -).
To say /i -- ending say_i -- running on: (- style roman; -).
To say b -- beginning say_b -- running on: (- style bold; -).
To say /b -- ending say_b -- running on: (- style roman; -).

TesterStories ends here.

---- DOCUMENTATION ----

Inform allows paragraph breaks and line breaks to be specified as text substitutions. This extension allows you to shorten the wording:

	say "Here is a line break.[br]"
	say "Here is a paragraph break.[p]"

Inform allows bolding and italic text substitutions. This extension allows you to shorten the wording:

	say "[i]Here is a sentence in italics.[/i]"
	say "[b]Here is a sentence in bold.[/b]"