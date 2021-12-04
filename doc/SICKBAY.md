SICKBAY
=======

This document describes the SICKBAY programming language.  SICKBAY is an
esoteric dialect of BASIC with two salient features:

*   While most BASICs support a call stack which is used to implement `GOSUB`
    and `RETURN`, SICKBAY uses a _call ring buffer_, which supports not only
    `GOSUB` and `RETURN` but also `PROLONG` and `CUTSHORT`.
*   While some BASICs support computed line numbers in `GOTO` and `GOSUB`,
    SICKBAY supports computed line numbers only in line number definitions.
    It thus lacks an `IF` statement because, similar to [Strelnokoff][], it
    doesn't need one.

[Strelnokoff]: http://catseye.tc/projects/strelnokoff/

Syntax
------

A SICKBAY program is a series of lines.  Each line must have a line number
(which may be an expression.)  Unlike BASIC, adjacent tokens must be
separated by one or more spaces, if they would otherwise look like one word
(e.g. you need `PRINT A%`, not `PRINTA%`.)

The language's syntax is defined by the following EBNF (plus some
pseudo-productions for terminals) grammar:

    SICKBAY   ::= {Line}.
    Line      ::= IntExpr Stmt {":" Stmt} Newline.
    Stmt      ::= "REM" ArbText
               | "LET" IntVar "=" IntExpr
               | "GOTO" IntConst
               | "GOSUB" IntConst
               | "RETURN" | "END"
               | "PROLONG" IntConst
               | "CUTSHORT"
               | "DIM" "RING" "(" IntExpr ")"
               | "PRINT" (StrConst | IntExpr | "CHR$" IntExpr) [";"]
               | "INPUT" (IntVar | "CHR$" IntVar)
               .
    IntExpr   ::= IntVar
               | IntConst
               | "RND%" "(" IntExpr ")"
               | "(" IntExpr IntOp IntExpr ")"
               .
    IntOp     ::= "+" | "-" | "*" | "/".
    IntVar    ::= IntId ["(" IntExpr ")"].
    IntId     ::= /[A-Z][A-Z0-9]%/.
    IntConst  ::= /[0-9][0-9]*/.
    StrConst  ::= /"[^"]*"/.
    ArbText   ::= /[^\n]*/.
    Newline   ::= /\n+/.

Semantics
---------

Many of the SICKBAY statements have meanings very similar to those in BASIC,
and I appeal to your knowledge of that language to make this description
complete.

### Execution ###

Lines are executed in numerical order, which may have nothing to do with the
order they appear in the program text; however, if two lines have the same
line number, the one which appears first in the program text takes precedence
(the other lines with the same number are not "seen" during execution.)
Execution begins initially from the lowest-numbered line in the program.

Line numbers are "live"; they are recomputed from their expressions each time
execution progresses from one line to the next.  (Two acceptable ways to
implement this are: every time a variable _x_ changes, recalculate the line
number of every line that uses _x_ in its line expression; or, just before
any jump or proceeding to the next line, recalculate all line numbers.)

Attempting to proceed to the next line when there are no more higher-numbered
lines in the program causes `END`.  `END` is an alias for `RETURN`.  `RETURN`
(or `CUTSHORT`) with nothing on the call ring buffer ends the program and
returns to the operating system.

The call ring buffer is of fixed size, and contains line numbers (concrete
line numbers, not expressions.)  If no size is chosen before any
`GOSUB`/`RETURN`/`PROLONG`/`CUTSHORT` is executed, a default size of 10 line
numbers will be used.  A `DIM RING` statement may be executed to set the size
of the ring buffer if it has not yet been set.  (If it has already been set,
an error occurs.)

`GOSUB` pushes the current line number onto the top of the call ring buffer
and moves execution to the line with the number given to it.  `RETURN` pops a
line number from the top of the call ring buffer and moves execution to the
next line in the program strictly following that line number.  `RETURN` does
not continue to execute remaining statements on the same line as the `GOSUB`
after colons (see clarifying example below.)

`PROLONG` pushes the given line number onto the _bottom_ of the call ring
buffer.  `CUTSHORT` pops a line number from the _bottom_ of the call ring
buffer.  Neither of these change the flow of execution immediately.  The
practical effect of `PROLONG` is to pretend that a `GOSUB` was made from a
line number before the first real `GOSUB` was ever made, effectively adding
some code that will be executed after the program ends.  The practical effect
of `CUTSHORT` is to make the program end prematurely, when attempting to
`RETURN` to the rootmost caller (initially this would be the "main program".)

If space in the call ring buffer is exhausted, an error occurs.

In `GOTO` and `GOSUB`, if the given line number does not exist at the time
the statement is executed, an error occurs.

### Variables ###

All variables initially have the value zero.  Any variable may be used as an
array; the variable itself is just an alias for the first element of the
array, i.e. `H% = H%(0)`.  Arrays don't have bounds and don't need
dimensioning.

Integers may be negative.  However, the syntax for integer constants only
allows non-negative integers; to give a negative constant, an expression such
as `(0 - 100)` must be used.  Note that this means a negative line number
cannot be jumped to, as `GOTO` et al must be followed by an integer constant,
not an expression.  (However, a negative line number may be _returned_ to, as
it is possible to write a program which begins executing at a negative line
number and makes a `GOSUB` from it.)

Operators have no precedence; parentheses must be used around all operations
(see grammar).

Like Strelnokoff, `/` is integer division, truncating downwards, and
evaluating to zero if the divisor is zero (there is no division by zero
error.)

The `RND%(`_n_`)` function evaluates to an integer from 0 to _n_-1, chosen
randomly.  If _n_ is zero or negative, an error occurs.

### I/O ###

Integer expressions may be printed; they are formatted as decimal numerals,
possibly preceded by a negative sign, but, unlike most BASICs, not preceded
or followed by any spaces.  The ASCII character for a given integer value may
be printed with the `PRINT CHR$` form.  Literal strings may also be printed,
but only one thing may (and exactly one thing must) be printed per `PRINT`
statement (so to just print a blank line, print a null string literal.)
Anything printed with a `PRINT` statement will be followed by a newline,
unless the semicolon is given after the statement, which suppresses the
newline.

The `INPUT IntVar` form accepts an integer, formatted as decimal numerals,
possibly preceded by a negative sign, from the input stream, and places it in
the variable.  Any whitespace preceding, and the first whitespace following
the integer is swallowed up; if the integer is not followed by at least one
whitespace character, an error occurs.  The `INPUT CHR$ IntVar` form accepts
a single character from the input stream and places its ASCII value in the
variable.
