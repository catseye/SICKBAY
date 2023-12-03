SICKBAY
=======

_Wiki entry_ [@ esolangs.org](https://esolangs.org/wiki/SICKBAY)
| _See also:_ [ILLGOL](https://codeberg.org/catseye/Illgol-Grand-Mal#illgol-grand-mal)
∘ [yucca](https://codeberg.org/catseye/yucca#yucca)

- - - -

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
    file [`SICKBAY.md`](doc/SICKBAY.md) in the `doc` directory.
*   other notes on the language, also in the `doc` directory.
*   SAWBONES, Cat's Eye Technologies' reference implementation of SICKBAY,
    written in Python, in the `script` directory.
*   several small example SICKBAY programs in the `eg` directory.

For more information on the language, see the [SICKBAY article][] on the
[esolangs.org wiki][].

Other Implementations
---------------------

Jeremy List has written a SICKBAY interpreter in Haskell.  It can be found
here: [sickbay.hs][].

[Strelnokoff]: https://catseye.tc/projects/strelnokoff/
[SICKBAY article]: https://esolangs.org/wiki/SICKBAY
[esolangs.org wiki]: https://esolangs.org/wiki/
[sickbay.hs]: https://gist.github.com/quickdudley/51660f98be16653682cf9a8249a57dcb
