From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 05 May 2015 00:12:14 +0200
Message-ID: <286173531.vzKW1UoxJJ@vostro.rjw.lan>
References: <1413881397.30379.7.camel@hadess.net> <CAOesGMg6UBuF=OJ-JdAUx-sD5MnLL8+Ag=xeJFmr-Dxezti2YA@mail.gmail.com> <CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53220 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750732AbbEDVrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 17:47:14 -0400
In-Reply-To: <CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>, John Stultz <john.stultz@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, April 30, 2015 11:54:51 AM Chirantan Ekbote wrote:
> On Thu, Apr 30, 2015 at 10:23 AM, Olof Johansson <olof@lixom.net> wrote:
> > Hi,
> >
> > On Thu, Apr 30, 2015 at 10:10 AM, John Stultz <john.stultz@linaro.org> wrote:
> >> On Thu, Apr 30, 2015 at 9:25 AM, Bastien Nocera <hadess@hadess.net> wrote:
> >>> On Tue, 2014-10-21 at 10:04 -0700, John Stultz wrote:

Thanks for CCin me, John!

Let's also CC linux-pm as the people on that list may be generally interested
in this thread.

> >>>> On Tue, Oct 21, 2014 at 1:49 AM, Bastien Nocera <hadess@hadess.net>
> >>>> wrote:
> >>>> > Hey,
> >>>> >
> >>>> > GNOME has had discussions with kernel developers in the past, and,
> >>>> > fortunately, in some cases we were able to make headway.
> >>>> >
> >>>> > There are however a number of items that we still don't have
> >>>> > solutions
> >>>> > for, items that kernel developers might not realise we'd like to
> >>>> > rely
> >>>> > on, or don't know that we'd make use of if merged.
> >>>> >
> >>>> > I've posted this list at:
> >>>> > https://wiki.gnome.org/BastienNocera/KernelWishlist
> >>>> >
> >>>> > Let me know on-list or off-list if you have any comments about
> >>>> > those, so
> >>>> > I can update the list.
> >>>>
> >>>> As for: 'Export of "wake reason" when the system wakes up (rtc alarm,
> >>>> lid open, etc.) and wakealarm (/sys/class/rtc/foo/wakealarm)
> >>>> documentation'
> >>>>
> >>>> Can you expand more on the rational for the need here? Is this for UI
> >>>> for power debugging, or something else?
> >>>
> >>> This is pretty much what I had in mind:
> >>> https://www.chromium.org/chromium-os/chromiumos-design-docs/lucid-sleep
> >>>
> >>> I guess I didn't make myself understood.
> >>
> >> My, admittedly quick skim, of that design document seems to suggest
> >> that lucid sleep would be a new kernel state. That would keep the
> >> kernel in charge of determining the state transitions (ie:
> >> SUSPEND-(alarm)->LUCID-(wakelock
> >> release)->SUSPEND-(alarm)->LUCID-(power-button)->AWAKE). Then it seems
> >> userspace would be able to query the current state. This avoids some
> >> of the races I was concerned with trying to detect which irq woke us
> >> from suspend from userspace.
> >>
> 
> Tomeu has been working on making things so that we don't need a new
> kernel state.

Which is good, because adding a new kernel state like that to the mainline is
out of the question as far as I'm concerned.

>  Adding him on cc so he can correct me if I say
> something wrong.  The current idea is to have userspace runtime
> suspend any unneeded devices before starting a suspend.  This way the
> kernel will leave them alone at resume.  This behavior already exists
> in the mainline kernel.  Getting the wakeup reason can be accomplished
> by having the kernel emit a uevent with the wakeup reason.  This is
> the only change that would be necessary.

Well, that needs to be thought through carefully in my view, or it will
always be racy.

You cannot really only rely on wakeup events that have already happened,
because something requiring you to bring up the full UI may happen at
any time.  In particular, it may happen when you're about to suspend again.

For this reason, it looks like you need something along the lines of
the wakeup_count interface, but acting on subsets of devices.

It actually shouldn't be too difficult to split the existing wakeup
counter into a number of subcounters each tracking a subset of wakeup
sources and one of them might be used as the "full UI wakeup" condition
trigger in principle.

> >> That said, the Power Manager section in that document sounds a little
> >> racy as it seems to rely on asking userspace if suspend is ok, rather
> >> then using userspace wakelocks, so I'm not sure how well baked this
> >> doc is.

You cannot be "a little" racy.  Either you are racy, or you aren't.  If you
are, it's only a matter of time until someone hits the race.  How often
that will happen depends on how hard the race is to trigger and how many
users of the feature there are.  Given enough users, quite a number of them
may be unhappy.

> I'm not sure I understand what you are saying here.  If you're saying
> that the kernel is asking userspace if suspend is ok, then I can say
> that that's definitely not the case.  Currently from the kernel's
> perspective a lucid sleep resume isn't really different from a regular
> resume.  We have a hack in each driver that we care about that
> basically boils down to an if statement that skips re-initialization
> if we are entering lucid sleep.  If userspace tries to access that
> device in lucid sleep, it just gets an error.  This has actually
> caused us some headache (see the GPU process section of the doc),
> which is why we'd like to switch to using the runtime suspend approach
> I mentioned above.

That's a good plan, because that's the only way you can satisfy all of the
dependencies that may be involved.

> If instead you're saying that the power manager needs to ask the rest
> of userspace whether suspend is ok, you can think of the current
> mechanism as a sort of timed wake lock.  Daemons that care about lucid
> sleep register with the power manager when they start up.  The power
> manager then waits for these daemons to report readiness while in
> lucid sleep before starting another suspend.  So each daemon
> effectively acquires a wake lock when the system enters lucid sleep
> and releases the wake lock when it reports readiness to the power
> manager or the timeout occurs.

I think what John meant was exactly what I said above: You need a race
free mechanism to verify whether or not it is OK to suspend again (ie.
whether or not there are any unhandled events that would have woken you up
had they happened while suspended) when you're about to.  You *also* need
to be able to determine (in a race free way) whether or not any of them
require you to bring up the UI.

It looks like your use case is actually more complex than the Android's one. :-)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
