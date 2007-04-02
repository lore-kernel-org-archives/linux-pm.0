From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Mon, 2 Apr 2007 16:04:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704021557270.29713-100000@netrider.rowland.org>
References: <200704021216.22280.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704021216.22280.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Apr 2007, David Brownell wrote:

> What the driver model does now is problematic.  Even if the clockevent
> stuff gets different fixes, those driver model issues still exist:  the
> existence of dependencies that are not part of the device tree.

> No, it's a "just happened to work" because the only ordering promise
> that was explicitly made is that the parent/child relationships will
> be obeyed.  Any additional ordering dependency is out-of-scope of the
> current driver model -- and that's a proble that eventually needs to
> be fixed.
> =

> This is the kind of thing that the pm_parent relationship was (AFAICT)
> originally supposed to handle.  Of course, it doesn't/can't, given the
> current implementation ... that relationship is never used.

Just so.  In fact, there almost certainly are other dependencies that =

nobody is aware of, simply because they have never had a chance to bite.

Such things can be rather difficult to pin down when they occur.  I would
be happy enough to leave matters as they are, with a strict LIFO approach.  =

If someone ever tries to parallelize suspend/resume in multiple threads,
they will have their work cut out for them -- even probing ran into
trouble when attempts were made to parallelize it, and it's a lot simpler.


> It's not that simple though, especially with HPET.  The BIOS may expect
> the PIT to work, but Linux currently (and problematically!) uses HPET in
> "legacy replacement mode".  And ISTR the problems are coming up when the
> system is already in a low-functionality state:  IRQs off everywhere,
> even timer ticks have stopped.

I know nothing about the workings of the HPET and other clock code.  My =

point was this: Suspend passes through various intermediate stages in =

which some devices are available and others aren't.  So long as those =

stages are exact duplicates (in reverse order) of the stages that occurred =

during startup, it should be possible to make them all work.

Alan Stern
