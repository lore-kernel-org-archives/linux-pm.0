From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
Date: Sun, 9 Dec 2018 22:49:03 +0100
Message-ID: <CAJZ5v0h5-BOzPmBAMUChTxb74XO9VxQdv1RL0yj2d3VYvd1yOA@mail.gmail.com>
References: <1688146.Dmze7u1T7F@aspire.rjw.lan> <20181207125700.GA20256@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207125700.GA20256@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 7, 2018 at 1:57 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 07, 2018 at 12:57:00PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
> >
> > Add two new metrics for CPU idle states, "above" and "below", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too short or too long for it (respectively).
> >
> > These mertics help to estimate the quality of the CPU idle governor
>
> s/mertics/metrics

Right, thanks!

> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a replacement for https://patchwork.kernel.org/patch/10714995/ with
> > the metrics renamed and some documentation confusion cleaned up.  Thanks!
> >
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
> >  Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
> >  drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
> >  drivers/cpuidle/sysfs.c                            |    6 ++++
> >  include/linux/cpuidle.h                            |    2 +
> >  5 files changed, 55 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
> >       struct cpuidle_state *target_state = &drv->states[index];
> >       bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
> >       ktime_t time_start, time_end;
> > -     s64 diff;
> >
> >       /*
> >        * Tell the time framework to switch to a broadcast timer because our
> > @@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
> >               local_irq_enable();
> >
> >       if (entered_state >= 0) {
> > +             s64 diff, delay = drv->states[entered_state].exit_latency;
>
> I am probably pointing out something that has been already debated,
> apologies if so.
>
> exit_latency is the *worst* case exit latency for idle states that involve
> multiple CPUs, we can't say for certain it is the latency that was
> actually experienced by the idle state exit.

Right.

> It can be microseconds (eg CPU resume) vs milliseconds (eg groups of
> cpus resume).
>
> I think the current approach (which may only understimate the "below" by
> substracting the worst case value) is reasonable but I pointed this out
> since I do not know how these stats will be used.

This is on purpose.

I want to count the cases when the selected state has been off for certain.

Thanks,
Rafael
