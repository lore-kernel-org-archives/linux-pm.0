From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Sat, 28 Feb 2009 11:06:40 +0100
Message-ID: <200902281106.41793.rjw__35505.6899752983$1235815803$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902270948540.2926-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0902271221360.3111@localhost.localdomain>
	<d6200be20902271954q16697282ia056d4f40ab49184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902271954q16697282ia056d4f40ab49184@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday 28 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Fri, Feb 27, 2009 at 12:30 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Fri, 27 Feb 2009, Alan Stern wrote:
> >>
> >> Perhaps these aren't all the sort of usage you're talking about, but I
> >> bet most of them are.  It certainly looks like more than just ARM.
> >> Maybe not all that much more, but definitely more.  And the number will
> >> only grow in the future.
> >
> > Are you really sure? Because it can't be x86. I'm pretty sure that that=
 is
> > simply not how x86 wake events _work_ - they're not interrupts.
> =

> They are not interrupts on every arm platform that implements set_wake
> either, but it is useful to pretend that they are. If the platform
> code reads the wakeup status and marks the corresponding interrupt
> pending, the driver does not need to know if the event occurred before
> or after the system entered the low power state. I don't know if this
> can be implemented on x86, but it might be worth looking into.

That would have been a new feature, no?  And I don't think anyone except for
you does it.  So, what you're saying boils down to "please don't break my n=
ew
feature that hasn't been merged yet".

> > And that's the big point that people seem to be missing here: the whole
> > "wake up interrupt" thing is not some generic model in the first place.=
 I
> > strongly suspect that it literally only works on certain architectures.
> =

> My point was that it was not specific to our platform. I don't have a
> problem fixing our platform if this patch is merged, but this is case
> where a change to the generic code breaks some platforms.

Quite frankly, I don't really think it will break anything else than your
platform.

Still, if Linus agrees, I can put the loop suggested by him directly into
sysdev_suspend().  Linus?

> I don't think there is a good reason to make the fix arm specific, trivia=
l or
> not, since any platform implementing set_wake may run into the race
> condition that this patch introduced. If the platform does not
> implement set_wake, IRQ_WAKEUP never gets set, and the fix should not
> have any effect.

The point is, if we put anything like this into the generic code, platforms
start to rely on this and it will become more and more difficult to change =
at
the generic level if need be.

The fact that your platform relies on the generic code to disable IRQs on
the CPU at a particular point shows the mechanism very well. :-)

Thanks,
Rafael
