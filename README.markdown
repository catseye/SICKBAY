SICKBAY
=======

SICKBAY is an esoteric dialect of BASIC with two salient features:

*   While most BASICs support a call stack which is used to implement `GOSUB`
    and `RETURN`, SICKBAY uses a _call ring buffer_, which supports not only
    `GOSUB` and `RETURN` but also `PROLONG` and `CUTSHORT`.
*   While some BASICs support computed line numbers in `GOTO` and `GOSUB`,
    SICKBAY supports computed line numbers only in line number definitions.
    It thus lacks an `IF` statement because, similar to [Strelnokoff][], it
    doesn't need one.

This is the reference distribution for SICKBAY.  It contains:

*   the normative description (i.e. specification) of the language -- see the
    file `SICKBAY.markdown` in the `doc` directory.
*   other notes on the language, also in the `doc` directory.
*   SAWBONES, Cat's Eye Technologies' reference implementation of SICKBAY,
    written in Python, in the `script` directory.
*   several small example SICKBAY programs in the `eg` directory.

For more information on the language, see the [SICKBAY article][] on the
[esolangs.org wiki][].

[Strelnokoff]: http://catseye.tc/projects/strelnokoff/
[SICKBAY article]: http://esolangs.org/wiki/SICKBAY
[esolangs.org wiki]: http://esolangs.org/wiki/
