From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 16:48:10 -0700
Message-ID: <200606221648.10799.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606221621230.5772-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221621230.5772-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 1:31 pm, Alan Stern wrote:
> On Thu, 22 Jun 2006, David Brownell wrote:
> =

> > > 	 The PM core _should_ be
> > > able to handle a device being added or removed while some parts of
> > > the system are suspended or frozen, just so long as the actual parent=
 is
> > > still awake.  Uevents can safely be queued until userspace is unfroze=
n or =

> > > otherwise able to process them.
> > =

> > Fixing that involves updating pm core locking, ISTR.  I've thought that
> > the root cause of the issue is that the list of devices to be suspended
> > is created at the wrong time ... very early and globally scoped, not
> > on-demand and privately scoped.
> =

> I believe this has been fixed for quite a while. =


That's been said, but nonetheless the last few times I've tried to do
things like handling disconnect processing anything other than very
late (after khubd got woken up again), it was still deadlocksville.
Yes, this is _after_ folk have said "this has been fixed...".


> The list of devices to =

> be suspended is persistent and is maintained over the lifetime of the
> system (devices are added during device_add and removed during
> device_del).  That way the ordering is automatically correct; suspend
> works from the end of the list to the start and resume goes from the start
> to the end.  Thus devices are suspended in the opposite order of discover=
y =

> and resumed in the order of discovery.

That applies only during system sleep state transitions.  If you
try to invoke selective suspend (only part of the driver model tree
rather than the whole thing), all such ordering is ignored.  And
for USB, selective suspend is a fundamental mechanism for reducing
systems' runtime power usage.


> > > I'm concerned about remote wakeup events arriving at inconvenient tim=
es
> > > during STR or STD.  Sometimes you might want them to abort the suspen=
d,
> > > sometimes you might want to just drop them, and sometimes you might w=
ant
> > > them to wake the system up right after it goes to sleep.  It would be=
 nice
> > > to get this straightened out.
> > =

> > Well, wakeup events in general, not just USB ones.  They can be the same
> > as regular IRQs ... which seems to suggest that driver-specific coding =
may
> > be needed.
> =

> Maybe.  Also to be considered is the fact that much of wakeup handling ha=
s =

> to take place in a process context,

But "much" is not "all", and in particular isn't the part that causes the
pm_ops.enter() primitive to return, leaving the suspend state and triggering
the resume() sequence.  On x86 there maybe ACPI black magic there, but on
other platforms Linux has more freedom to do the Right Things.   I'll menti=
on
some as-yet unmerged 2.6.17-at91 patches [1][2] (armv4t) as illustrative,
and maybe an especially good example because the hardware is so simple.

- Dave

[1] http://maxim.org.za/AT91RM9200/2.6/
[2] http://marc.theaimsgroup.com/?l=3Dlinux-arm-kernel&m=3D114839995519368&=
w=3D2
