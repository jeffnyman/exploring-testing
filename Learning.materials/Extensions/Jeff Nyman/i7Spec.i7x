i7Spec (for Glulx only) by Jeff Nyman begins here.

"Support for an xUnit or xSpec style runner. This allows expectations to be stated and checked."

"based on Simple Unit Tests by Dannii Willis and Command Unit Testing by Xavid"

Use authorial modesty.

Part 1 - Spec Testing - Not For Release

Scenario rules is a rulebook.

Running the spec tests is an action out of world.

Understand "run the test scenarios" and "run scenarios" and "run the specifications" and "run specifications" and "run the spec test/tests" and "run spec test/tests" and "spec test/tests" and "spec" as running the spec tests.

The expectation count is a number that varies.
The success count is a number that varies.

Carry out running the spec tests (this is the run all spec tests rule):
	now the expectation count is 0;
	follow the scenario rules.

To context (T - text):
	echo "[line break]SCENARIO: [T]".

To verify that (command - text) produces (expected - text):
	add command to the command queue;
	add expected to the expectation queue;
	add "" to the arg queue.

To verify that (str - text) substitutes to (expected - text):
	add "!echo" to the command queue;
	add expected to the expectation queue;
	add str to the arg queue.

To do (command - text):
	add command to the command queue;
	add "" to the expectation queue;
	add "" to the arg queue.

Section 1 - Schedule Output for Display

The command queue is a list of text that varies.
The expectation queue is a list of text that varies.
The arg queue is a list of text that varies.

To echo (T - text):
	add "!echo" to the command queue;
	add "" to the expectation queue;
	add T to the arg queue.

Section 2 - Reading a Command

The expected output is text that varies.

Rule for reading a command when the command queue is not empty (this is the i7Spec execute queued commands rule):
	let the new command be entry 1 in the command queue;
	change the text of the player's command to the new command;
	now the expected output is entry 1 in the expectation queue;
	remove entry 1 from the command queue;
	remove entry 1 from the expectation queue;
	remove entry 1 from the arg queue;
	if the expected output is empty:
		say "> [italic type][new command][roman type][line break][run paragraph on]";
	else:
		say "Evaluating: [italic type][new command][roman type][line break][run paragraph on]";
		start spec-capturing text.

First before reading a command when the expected output is not empty (this is the i7Spec process current expectation after the command finishes rule):
	process current expectation.

Before reading a command when the command queue is not empty (this is the i7Spec handle queued echoes rule):
	while the command queue is not empty and entry 1 in the command queue exactly matches the text "!echo":
		if entry 1 from the expectation queue is empty:
			say "[bold type][entry 1 from the arg queue][roman type][line break]";
		else:
			increase the expectation count by 1;
			let S be entry 1 from the arg queue;
			if S exactly matches the text entry 1 from the expectation queue:
				increase the success count by 1;
				say "[S][line break]";
			else:
				say "[bold type]Expectation failed:[roman type] substituted as '[S]', not '[entry 1 from the expectation queue]'!";
		remove entry 1 from the command queue;
		remove entry 1 from the expectation queue;
		remove entry 1 from the arg queue.

Last before reading a command when the command queue is empty and the expectation count is not 0 (this is the i7Spec print results after emptying command queue rule):
	if the expectation count is the success count:
		say "[line break]Results: all [success count]/[expectation count] expectations passed!";
	else:
		say "[line break]Results: [success count]/[expectation count] expectations passed.";
	now the expectation count is 0;
	now the success count is 0.

Section 3 - Process Expectation

To process current expectation:
	stop spec-capturing text;
	let the result be "[the spec-captured text]";
	[
	This next line might need a bit of explanation. If there are more than two newlines
	at the end of the command, none of them are removed. The reason for this is that
	regular expression support in Inform doesn't handle what are called non-greedy
	captures properly in all cases. "Greedy" refers to matching the longest-possible
	string, as opposed to matching the smallest-possible string. The reason this can't
	be counted on in Inform is a bit unclear.
	]
	if the result matches the regular expression "^(.*<^\n>)\n{1,2}$":
		let the result be text matching subexpression 1;
	increase the expectation count by 1;
	if the result exactly matches the text expected output:
		increase the success count by 1;
		say "[result][paragraph break]";
	else:
		replace the text "[paragraph break]" in the result with "[bracket]paragraph break[close bracket]";
		replace the text "[paragraph break]" in the expected output with "[bracket]paragraph break[close bracket]";
		replace the text "[line break]" in the result with "[bracket]line break[close bracket]";
		replace the text "[line break]" in the expected output with "[bracket]line break[close bracket]";
		say "[bold type]Expectation failed:[roman type] produced '[result]', not '[expected output]'!";
	now the expected output is "".

Part 2 - Text Capturing - Not For Release

[ This is essentially duplicating the functionality of Text Capture by Eric Eve. There are simply different names for certain aspects based on the fact that the only text capturing occuring is in the context of the spec test execution. ]

Section 1 - Define a Use Option

Use maximum spec-capture buffer length of at least 256 translates as (- Constant SPEC_CAPTURE_BUFFER_LEN = {N}; -). 

Section 2 - Define Phrases

To start spec-capturing text:
	(- StartSpecCapture(); -)

To stop spec-capturing text:
	(- EndSpecCapture(); -).

To say the/-- spec-captured text:
	(- PrintSpecCapture(); -).

Section 3 - Implementation

Include (- Global spec_capture_active = 0; -).

Include (-

Array spec_captured_text --> SPEC_CAPTURE_BUFFER_LEN + 1;

Global text_spec_capture_old_stream = 0;
Global text_spec_capture_new_stream = 0;

[ StartSpecCapture i;
	if (spec_capture_active ==1)
		return;
	
	spec_capture_active = 1;
	text_spec_capture_old_stream = glk_stream_get_current();
	text_spec_capture_new_stream = glk_stream_open_memory_uni(spec_captured_text + WORDSIZE, SPEC_CAPTURE_BUFFER_LEN, 1, 0);
	glk_stream_set_current(text_spec_capture_new_stream);
];

[ EndSpecCapture len;
	if (spec_capture_active == 0)
		return;
	
	spec_capture_active = 0;
	glk_stream_set_current(text_spec_capture_old_stream);
	@copy $ffffffff sp;
	@copy text_spec_capture_new_stream sp;
	@glk $0044 2 0; ! stream_close
	@copy sp len;
	@copy sp 0;
	spec_captured_text-->0 = len;
	
	if (len > SPEC_CAPTURE_BUFFER_LEN) {
		spec_captured_text-->0 = SPEC_CAPTURE_BUFFER_LEN;
	}
];

[ PrintSpecCapture len i;
	len = spec_captured_text-->0;
	
	for (i = 0 : i < len : i++) {
		glk_put_char_uni(spec_captured_text-->(i + 1));
	}
];

-).

i7Spec ends here.

---- DOCUMENTATION ----

Inform lets you have "test" commands that check out how your game plays by following a sequence of commands. What that functionality doesn't do is allow you to check the responses in an easy way.

This extension lets you create spec (specification) tests. These are modeled as scenarios that you can give descriptive names to and then provide an output expectation check in the form of a "verify" command.

These really aren't unit tests as some of the other extensions have provided because they don't test the actions of a single method. Rather they are a specification or acceptance test that makes sure that certain expected output occurs as the result of a command. But that command may also have a context that has to be provided.

Chapter 1 - Writing Scenarios

Spec tests are somewhat similar to the "test" command provided by Inform. This is because a specification test is essentially a series of commands, although it can also just be a single command. In this context, however, those commands are defined as part of scenario rules. A basic example would be:

	Scenario:
		context "the player can examine themselves";
		verify that "examine me" produces "As good-looking as ever."

The "context" instruction provides a bit of text that allows you to define what a scenario is specificially verifying. This also serves as a nice indication of where tests begin and end in terms of the eventual report output.

The "verify that ... produces" instruction is the meat of the extension. What happens here is a command is executed and the output of that command is captured. That output is then compared to whatever you said should be produced when that command is run. If the expectation and the actual output do not match, then an expectation failure is generated.

It is possible to provide commands as part of a test that are not to be verified but that are necessary in order for something to be verified. For example, let's say you want to test the ability of an NPC to follow a particular order given by the player. But in order for that to happen, the NPC needs to be hypnotized. You could do something like this:

	Scenario:
		context "NPCs will only follow orders if hypntoized";
		do "hypnotize Jane";
		verify that "Jane, go south" produces "Jane heads off to the south."

Here the "do" instruction just executes a command without doing anything with it. You can have as many of these instructions in your test as you want. They are somewhat akin to 'setup' style statements in xUnit or xSpec type test runners.

Chapter 2 - Running Scenarios

Since these are meant to be specification ('spec') tests, you can run the tests manually simply by using the "spec" command.

There are various other equivalent commands you can use, like "run scenarios", "run specifications", "run spec tests", and so on.

Chapter 3 - Understanding Spec Execution

Section 1 - Test State

This extension currently doesn't support restoring the original game state. What this means is that these spec tests will operate in context of whatever the current game state is. That includes a game state that may have been set up by other tests running. This makes this extension very different from what a unit or spec test platform should provide: each test being independent and relying on a fixed state that can established for each test.

This also means that tests can 'leak' into other tests. For example, if you have a test that runs that takes an object then that object will be in the player's possession for all other tests.

Section 2 - Delayed Test Instruction Execution

The way the spec tests work, a series of commands are queued up during the reading of the scenario rules. After they are queued up, then they are executed. But this means any instructions you put in the scenarios will be executed right at the start. This means normal world state commands cannot be used as part of a setup or teardown procedure. For example, consider this:

	Scenario:
		context "NPCs will only follow orders if hypntoized";
		now Jane is hypnotized;
		verify that "Jane, go south" produces "Jane heads off to the south.";
		now Jane is alert.

Here the idea is perhaps a 'setup' and 'teardown' procedure. The idea is that to test whether Jane (an NPC) will follow orders (which will only happen if, in this case, she is hypnotized), the setup is to hypnotize Jane with a "now" instruction, perform the verification, and then reset the situation by changing Jane's state back to alert with a second "now" instruction.

The problem is, given how the extension currently has to work, the "now" instructions would be executed before the "verify" test.

Section 3 - Capturing Text

Expectation ("verify") instructions rely on capturing the text that is entered and this is done based on an extension called Text Capture, written by Eric Eve. However, it's possible someone will be using that extension along with this one. For that reason, a second text capture implementation is provided in i7Spec which can co-exist with the standard Text Capture extension.

It's worth noting that text capture has a 256 character limit on the length of captured text. For commands with longer expected output, you might want to increase this via a "Use" option, as such:

	Use maximum spec-capture buffer length of at least 512.

Section 4 - Clarification Questions

The extensions that i7Spec is based on do allow for some handling of clarification questions. The problem is that, currently, the only way to handle these is to require manual intervention by pausing test execution and having you enter 

Section 5 - Glulx Only

This extension is only relevant for Glulx. Supporting the Z-machine is possible but Glulx is (and has to be) the future, so I don't see a reason to support continued dependence on the Z-machine.
