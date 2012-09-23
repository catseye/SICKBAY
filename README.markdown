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

For a full description of the language, see the [SICKBAY article][] on the
[esolangs.org wiki][].

This is the reference distribution for SICKBAY.  It contains SAWBONES,
Cat's Eye Technologies' reference implementation of SICKBAY, written in
Python.
