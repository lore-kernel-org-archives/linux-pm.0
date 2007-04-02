From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Mon, 2 Apr 2007 12:16:21 -0700
Message-ID: <200704021216.22280.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0704021000450.1743-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704021000450.1743-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 02 April 2007 7:16 am, Alan Stern wrote:
> On Saturday March 31, 2007, David Brownell wrote:
> =

> > Change how the PM list is constructed, so that devices are added right
> > after their parents (when they have one) rather than at the end of the
> > list.  ...
> > =

> > This patch has a potential downside for devices that have multiple
> > power dependencies and which "just happened to work" before.
> =

> Dave:
> =

> Would you mind retracting this patch?  It will interfere with some work
> I've been doing in USB, work that relies on exactly the sort of multiple =

> power dependency you mention.

It's out there for discussion right now more than merging.

What the driver model does now is problematic.  Even if the clockevent
stuff gets different fixes, those driver model issues still exist:  the
existence of dependencies that are not part of the device tree.


> The problem is this: When a low- or full-speed USB device is resumed =

> following a power loss (this is part of the "persistent USB" patch), it's =


Yeah, that "persistent USB" stuff that I don't like at all!   Power off
is power off, and should be treated just like any other case of the USB
circuit being broken.  (Offtopic here, of course.)


> necessary for the corresponding EHCI root hub to be resumed first so that =

> the port's OWNER bit can be set properly.
> =

> It works fine as long as devices are resumed in order of registration,
> because a low- or full-speed USB device can't be registered before the
> high-speed root hub.  (If it was, it would be disconnected when the
> high-speed root hub initialized and took control of the port.)  So this
> isn't a "just happened to work" situation; it really is a critical
> ordering dependency.

No, it's a "just happened to work" because the only ordering promise
that was explicitly made is that the parent/child relationships will
be obeyed.  Any additional ordering dependency is out-of-scope of the
current driver model -- and that's a proble that eventually needs to
be fixed.

This is the kind of thing that the pm_parent relationship was (AFAICT)
originally supposed to handle.  Of course, it doesn't/can't, given the
current implementation ... that relationship is never used.


> The clock source problem can be solved in other ways.  For instance, righ=
t =

> now things are set up so that clock sources are registered at various =

> random times and the clockevents code adapts to use the best available =

> device, right?.

Clocksource ~=3D counter, clockevent ~=3D timer irq ... you're mixing the
two, they're different!  Both can be registered at various times; and
the best available instance of both is used.  (Unfortunately "best" is
not a static policy on x86 hardware.)


> So simply arrange for a clock source to "depart" as it is  =

> suspended; then clockevents can fall back to using other lower-precision =

> sources.  As long as devices suspend in reverse order of discovery, the =

> system should always function properly.

It's not that simple though, especially with HPET.  The BIOS may expect
the PIT to work, but Linux currently (and problematically!) uses HPET in
"legacy replacement mode".  And ISTR the problems are coming up when the
system is already in a low-functionality state:  IRQs off everywhere,
even timer ticks have stopped.

- Dave
