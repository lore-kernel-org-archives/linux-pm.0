From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 09:43:04 -0700
Message-ID: <200606150943.05188.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141948.23107.david-b@pacbell.net>
	<20060615083921.GB9423@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615083921.GB9423@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 1:39 am, Pavel Machek wrote:
> =

> > Actually it would be interesting to hear counter-arguments to this
> > position:
> > =

> > 	We already HAVE that two-phase thing going on, at
> > 	least for swsusp.  In phase I a PM_EVENT_FREEZE
> > 	gets sent.  Then in phase II a PM_EVENT_SUSPEND gets
> > 	tries to really suspend things.
> > =

> > One counter-argument might be that "phase I.5 resumes those devices"
> > is a problem.  Another might be that "FREEZE should not be sent to
> > the console(s), the swap device, or their parents".  I suspect there
> > are a few more issues mixed up in there too.
> =

> This is FAQ:

Which seems to suggest that you are Frequently giving a useless
Answer to the Question ... and in this case, not the question
which was asked.  You're doing that "attack the straw man"
thing again.

 =

> Q: I do not understand why you have such strong objections to idea of
> selective suspend.

Not a question, and it's not clear who "you" is.  Presumably, "Pavel"?
Plus it doesn't relate to the position sketched above.


> A: Do selective suspend during runtime power managment, that's
> okay. But
> its useless for suspend-to-disk. (And I do not see how you could use
> it for suspend-to-ram, I hope you do not want that).

That's a bunch of non-answers of course.

And re the parenthetical comment ... to use ACPI terminology for
just a moment (without assuming ACPI!), it's trivially true that
there are different device suspend states, and that real system
sleep states like S1 and S3 (plus many non-ACPI variants thereof)
can accomodate multiple device suspend states.

So for example a device enabled as a wakeup event source might use
a less aggressive suspend state than one which doesn't need to offer
any functionality while the system is in that sleep state.  In
some cases those "less aggressive suspend" states _are_ exactly
equivalent to an un-suspended device.  (Not with PCI PM of course,
but with some other hardware frameworks.)

 =

> Lets see, so you suggest to

Actually I asked for counter-arguments to a position, which was
intended as a request not to enter the usual flamewar that shows
up whenever someone observes that Linux-PM has a few issues that
affect swsusp.  At this time, I had offered no suggestion.

Those flames are, as always, tedious and needless.


> * SUSPEND all but swap device and parents
> * Snapshot
> * Write image to disk
> * SUSPEND swap device and parents
> * Powerdown
> =

> Oh no, that does not work,

Oddly enough, it wasn't even mentioned in the position I was
asking a response to.  This is what's called a "straw man"
attack ... when rather than actually address an issue that's
been raised, someone sets up a _different_ issue, attacks
that, and than treats the original issue as resolved:

  http://www.nizkor.org/features/fallacies/straw-man.html

Attacking a straw man is as efficaceous as putting pins
into a voodoo doll ... at least, in terms of addressing
the original question.
