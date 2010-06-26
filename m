From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Sat, 26 Jun 2010 09:54:00 -0700 (PDT)
Message-ID: <18366.69939.qm__46546.9190422029$1277571310$gmane$org@web180315.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark gross <640e9920@gmail.com>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Arve@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a repeat of an issue I posted before, but
which for some reason I never saw email back ...

basically, I think the notion of counting wakeup
events seems dubious on common hardware, so the
focus might perhaps better be placed on ensuring
userspace just receives events rather than
trying to track events which in one context ended
up being wakeup events.=A0 (That's simpler, and the
system is by definition awake if it can handle any
events at all.)

Thing is, "wakeup" is, for e.g. most ARMs, just a hardware attribute of wha=
t's otherwise a routine
event, which happens in other contexts and needs
to be handled consistently .... nothing special
about having woken the system too, the result ought to
be the same regardless (from the user P.O.V.) ...=A0 (Common Examples inclu=
de SoC peripheral IRQs that can wake the system (including GPIO and other t=
ypes
of external IRQ signal.)

BRIEFLY:  if that event doesn't arrive reliably,
it's an issue regardless of wakeup:  either TX from
kernel, or RX in userspace. Such bugs would need to
be fixed.  Having them fixed will help the wakeup scenarios too of course.

(The raciness issues might boil down to something as simple as not letting =
userspace know about transition events to/from suspend states, but that iss=
ue
ought to be cleanly separable; ISTR other messages on the suspend blocker t=
hreads have shown how to work with such clean factoring.)



So trying to track whether a given event is what
woke the system will often be implausible, since
several such events might each have fired (one
or more concurrent wakeup sources, even ... it
could be indeterminate which one[s] happened.)
And the event could fire without being a wakeup.

Yes, there are a few cases (like USB remote wakeup
signaling and some PCI mechanisms, plus a few BIOS
assisted situations) where certain events may be
identifiable as wakeup sources, perhaps runtime not
system-wide).=A0 But the common case just includes
an event, not the ability to know that event had
the "woke whole system from low power state"
side effect too.




> +=A0=A0=A0 =A0=A0=A0 The
> /sys/power/wakeup_count file allows user space to avoid
> +=A0=A0=A0 =A0=A0=A0 losing wakeup events
> when transitioning the system into a sleep
> +=A0=A0=A0 =A0=A0=A0 state.=A0 Reading
> from it returns the current number of registered
> +=A0=A0=A0 =A0=A0=A0 wakeup events and it
> blocks if some wakeup events are being
> +=A0=A0=A0 =A0=A0=A0 processed at the
> time the file is read from.=A0
