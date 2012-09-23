SICKBAY: A BASIC with ring buffers
==================================

(These are the original notes I wrote up for the idea of using a call ring
buffer in a BASIC-like language, because I don't know where else to put them
and it seems a shame to just throw them out -- Ed.)

Oftentimes, hardware influences programming language design.  The most
notorious example is probably the call stack, almost omnipresent in processor
architecture.  The most common case for routines is where one routine calls
another, and we expect control to return from the called routine and resume
inside the first routine at a point just after the call was made.  This
nesting of activations is reflected in the FIFO nature of the call stack.
The control flow of exceptions may seem more complicated, but it too adheres
to this FIFO nature; the only difference is that control may resume at a point
several callers up the stack.

However there are many flexible and useful patterns of control, such as
first-class activation records, closures, co-routines, escape procedures, and
general continuations, which do not adhere to this stricture.  The activation
lifetime of each of these may outlive the activation lifetime of the thing
that called it.  If we wish to support a less strict relationship between
callers and callees, we need a correspondingly more flexible memory management
structure than a stack.  Generally this is approached by allocating these
control structures on the heap, possibly as an optimization assigning stack
allocation to ones which upon analysis are indeed found to have FIFO behaviour.

But here, we take a slightly different data structure as our backing store
for control flow, and consider how much more flexibility this allows in our
language's control constructs.  The data structure is more capable than a FIFO
stack, but can be mapped just as efficiently to hardware; it is less flexible
than a general heap, but decidedly less complex, requiring no garbage
collection.  This data structure is the _ring buffer_.

Recall that a ring buffer is a fixed span of memory cells which supports the
operations of a deque: there is an allocated area inside the span, and records may
be appended and removed from either end of it.  Should the appending of a record
cause the allocated area to exceed either end of the span of memory, it "wraps
around" and is stored at the other end of the span.  Thus the total capacity of the
ring buffer is always the size of the span. The "wrap around" behaviour can be
efficiently computed using binary logic if the size of the span is a power of two.

The push and pop operations of the FIFO stack correspond to the call and
return operations on routines.  Our ring buffer has two more operations, which we'll
call "push-bottom" and "pop-bottom", which correspond to two new operations
on routines, which we'll call "prepend" and "truncate".  Prepending is essentially
adding a routine that is executed after the "main" routine quits, and truncating is
essentially removing the main routine so that the program quits when returning
from the last routine that main routine called.

(Of course, "quit" is subjective.  When a program quits, all that really
happens is that the operating system resumes.)
