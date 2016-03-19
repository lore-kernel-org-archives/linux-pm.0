From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Sat, 19 Mar 2016 03:06:40 +0100
Message-ID: <CAJZ5v0iQhVsyq7o8kbvppENdhvKFCZTSzWswCmELa2ithkm1iA@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
	<20160318173551.675ff6e5@annuminas.surriel.com>
	<CAJZ5v0hLAiVoEn0PbVo++UDrXvizYC0EeAoqj8drS3GR5mQTig@mail.gmail.com>
	<1458352411.14723.55.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34899 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbcCSCGm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 22:06:42 -0400
Received: by mail-lb0-f176.google.com with SMTP id bc4so98677313lbc.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 19:06:41 -0700 (PDT)
In-Reply-To: <1458352411.14723.55.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Sat, Mar 19, 2016 at 2:53 AM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 2016-03-18 at 23:56 +0100, Rafael J. Wysocki wrote:
>> On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > On Fri, 18 Mar 2016 11:32:28 -0700
>> > "Doug Smythies" <dsmythies@telus.net> wrote:
>> >
>> > >
>> > > Energy:
>> > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>> > >
>> > > Trace data (very crude summary):
>> > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load
>> > > (idle state 0)
>> > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less,
>> > > CPU load (not all idle state 0)
>> > This is a bit of a big hammer, but since the polling loop already
>> > uses
>> > full CPU power anyway, this could be harmless, and solve your
>> > problem.
>> >
>> > ---8<---
>> >
>> > Subject: cpuidle: break out of idle polling loop after HLT
>> > threshold
>> >
>> > Staying in the poll loop can be beneficial for workloads that
>> > wake back up very, very quickly, but staying in the poll loop
>> > for too long can waste a lot of power.
>> >
>> > Break out of the idle polling loop if the system has spent more
>> > time in the loop than the threshold for entering the next power
>> > saving mode.
>> >
>> > The poll loop uses full CPU power already, so this will not
>> > increase the power use of the poll loop.
>> >
>> > Signed-off-by: Rik van Riel <riel@redhat.com>
>> > ---
>> >  drivers/cpuidle/driver.c | 21 ++++++++++++++++++++-
>> >  1 file changed, 20 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> > index 389ade4572be..a5dfeafd243f 100644
>> > --- a/drivers/cpuidle/driver.c
>> > +++ b/drivers/cpuidle/driver.c
>> > @@ -181,10 +181,29 @@ static void __cpuidle_driver_init(struct
>> > cpuidle_driver *drv)
>> >  static int poll_idle(struct cpuidle_device *dev,
>> >                 struct cpuidle_driver *drv, int index)
>> >  {
>> > +       /*
>> > +        * Polling is state 0; break out of the polling loop after
>> > the
>> > +        * threshold for the next power state has passed. Doing
>> > this several
>> > +        * times in a row should cause the menu governor to
>> > immediately
>> > +        * select a deeper power state.
>> > +        */
>> > +       u64 limit = drv->states[1].target_residency *
>> > NSEC_PER_USEC;
>> > +       ktime_t start = ktime_get();
>> > +       int i = 0;
>> > +
>> >         local_irq_enable();
>> >         if (!current_set_polling_and_test()) {
>> > -               while (!need_resched())
>> > +               while (!need_resched()) {
>> > +                       ktime_t now;
>> >                         cpu_relax();
>> > +
>> > +                       /* Occasionally check for a timeout. */
>> > +                       if (!(i % 1000)) {
>> > +                               now = ktime_get();
>> > +                               if (ktime_to_ns(ktime_sub(now,
>> > start)) > limit)
>> > +                                       break;
>> > +                       }
>> > +               }
>> >         }
>> >         current_clr_polling();
>> I'm not sure how this is going to help, but maybe I'm missing
>> something.
>>
>> Say we hit the timeout and break out of the loop.  We get back to
>> cpuidle_enter_state() and from there (via a couple of irrelevant
>> steps) to cpuidle_idle_call() and to cpu_idle_loop().  Then, since we
>> are still idle, the while (1) loop continues and we land in
>> menu_select() again.  That will choose polling again (because now
>> there's less time to the next timer than it was last time, so if it
>> didn't choose C1 then, it won't do that now either) and we land in
>> idle_poll() again.
>>
>> So is there anything I'm overlooking?
>
> After about three microseconds of the above, get_typical_interval()
> will return an interval larger than the C1 target residency, or
> fail to find a typical interval, because 3 of the 8 intervals will
> exceed the C1 target residency at that point.
>
> Only repeated very fast wakeups will lead to polling, and just
> a few periods of polling timing out will lead to the system
> reverting to HLT.
>
> In other words, the system will only use polling while it appears
> to be beneficial, and should snap out of that mode very quickly.

OK, thanks!

> The kernel test robot also showed over 6% improvement in (IIRC)
> the wikibench test, with polling being done a little more often.
>
> Other parts of the kernel do pretty much anything for 2% extra
> performance, so if we can find a way to preserve that 6%, without
> hurting power usage significantly, I suspect it may be worthwhile.

Well. OK.  That is a worthy goal, but things in this thread look a bit
too ad-hoc to me to be honest.

I'd like to take one step at a time and in such a way that
improvements are actually confirmed in every step.

Does this sound reasonable?

If so, I first would like to restore the energy consumption in the
Doug's case at least to the level from before commit a9ceb78bc75c
(cpuidle,menu: use interactivity_req to disable polling).  That's what
I'd like to do for 4.6 and possibly before the merge window is over.

After 4.6-rc1, in the 4.7 cycle, we can think about improving
performance here and maybe sacrificing some energy for that, but in a
controlled way as I said above.

What do you think?
