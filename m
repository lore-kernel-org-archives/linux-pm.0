From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 15:44:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008061505070.9303-100000__19622.0966442072$1281124005$gmane$org@netrider.rowland.org>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> count, tells you how many times the wakelock was activated. If a
> wakelock prevented suspend for a long time a large count tells you it
> handled a lot of events while a small count tells you it took a long
> time to process the events, or the wakelock was not released properly.

As noted, we already have this.

> expire_count, tells you how many times the timeout expired. For the
> input event wakelock in the android kernel (which has a timeout) an
> expire count that matches the count tells you that someone opened an
> input device but is not reading from it (this has happened several
> times).

This is a little tricky.  Rafael's model currently does not allow
wakeup events started by pm_wakeup_event() to be cancelled any way
other than by having their timer expire.  This essentially means that
for some devices, expire_count will always be the same as count and for
others it will always be 0.  To change this would require adding an
extra timer struct, which could be done (in fact, an earlier version of
the code included it).  It would be nice if we could avoid the need.

Does Android use any kernel-internal wakelocks both with a timer and =

with active cancellation?

> wake_count, tells you that this is the first wakelock that was
> acquired in the resume path. This is currently less useful than I
> would like on the Nexus One since it is usually "SMD_RPCCALL" which
> does not tell me a lot.

This could be done easily enough, but if it's not very useful then =

there's no point.

> active_since, tells you how long a a still active wakelock has been
> active. If someone activated a wakelock and never released it, it will
> be obvious here.

Easily added.  But you didn't mention any field saying whether the =

wakelock is currently active.  That could be added too (although it =

would be racy -- but for detecting unreleased wakelocks you wouldn't =

care).

> total_time, total time the wake lock has been active. This one should
> be obvious.

Also easily added.

> sleep_time, total time the wake lock has been active when the screen was =
off.

Not applicable to general systems.  Is there anything like it that =

_would_ apply in general?

> max_time, longest time the wakelock was active uninterrupted. This
> used less often, but the battery on a device was draining fast, but
> the problem went away before looking at the stats this will show if a
> wakelock was active for a long time.

Again, easily added.  The only drawback is that all these additions =

will bloat the size of struct device.  Of course, that's why you used =

separately-allocated structures for your wakelocks.  Maybe we can =

change to do the same; it seems likely that the majority of device =

structures won't ever be used for wakeup events.

> >> and I would prefer that the kernel interfaces would
> >> encourage drivers to block suspend until user space has consumed the
> >> event, which works for the android user space, instead of just long
> >> enough to work with a hypothetical user space power manager.

Rafael doesn't _discourage_ drivers from doing this.  However you have
to keep in mind that many kernel developers are accustomed to working
on systems (mostly PCs) with a different range of hardware devices from
embedded systems like your phones.  With PCI devices(*), for example,
there's no clear point where a wakeup event gets handed off to
userspace.

On the other hand, there's no reason the input layer shouldn't use
pm_stay_awake and pm_relax.  It simply hasn't been implemented yet.

Alan Stern

(*) Speaking of PCI devices, I'm not convinced that the way Rafael is =

using the pm_wakeup_event interface in the PCI core is entirely =

correct.  The idea is to resolve the race between wakeup events and =

suspend.  The code assumes that a wakeup event will be consumed in 100 =

ms or less, which is a reasonable assumption.

But what sorts of things qualify as wakeup events?  Right now, the code
handles only events coming by way of the PME# signal (or its platform
equivalent).  But that signal usually gets activated only when a PCI
device is in a low-power mode; if the device is at full power then it
simply generates an IRQ.  It's the same event, but reported to the
kernel in a different way.  So consider...

Case 1: The system is suspending and the PCI device has already been
	placed in D3hot when an event occurs.  PME# is activated,
	the wakeup event is reported, the suspend is aborted, and the =

	system won't try to suspend again for at least 100 ms.  Good.

Case 2: The system is running normally and the PCI device is at full
	power when an event occurs.  PME# isn't activated and =

	pm_wakeup_event doesn't get called.  Then when the system
	tries to suspend 25 ms later, there's nothing to prevent it
	even though the event is still being processed.  Bad.

In case 2 the race has not been resolved.  It seems to me that the =

only proper solution is to call pm_wakeup_event for _every_ PCI =

interrupt.  This may be too much to add to a hot path, but what's the =

alternative?
