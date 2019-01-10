From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Thu, 10 Jan 2019 11:20:05 +0100
Message-ID: <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 10:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/12/2018 12:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add two new metrics for CPU idle states, "above" and "below", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too short or too long for it (respectively).
> >
> > These metrics help to estimate the quality of the CPU idle governor
> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Fix a leftover in the documentation from the previous versions
> >        of the patch and a typo in the changelog.
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
> > +             int i;
> > +
> >               /*
> >                * Update cpuidle counters
> >                * This can be moved to within driver enter routine,
> > @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >               dev->last_residency = (int)diff;
>
> Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?

No.

> Otherwise the 'last_residency' accumulates the effective sleep time and
> the time to wakeup. We are interested in the sleep time only for
> prediction and metrics no ?

Yes, but 'delay' is the worst-case latency and not the actual one
experienced, most of the time, and (on average) we would underestimate
the sleep time if it was always subtracted.

The idea here is to only count the wakeup as 'above' if the total
'last_residency' is below the target residency of the idle state that
was asked for (as in that case we know for certain that the CPU has
been woken up too early) and to only count it as 'below' if the
difference between 'last_residency' and 'delay' is greater than or
equal to the target residency of a deeper idle state (as in that case
we know for certain that the CPU has been woken up too late).

Of course, this means that there is a "gray area" in which we are not
really sure if the sleep time has matched the idle state that was
asked for, but there's not much we can do about that IMO.
