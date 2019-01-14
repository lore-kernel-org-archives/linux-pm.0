From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Tue, 15 Jan 2019 00:33:13 +0100
Message-ID: <CAJZ5v0jB+_arUAL-rscJvH1Ej2SJA0TmbKS3Uh-2My2L=HDswg@mail.gmail.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
 <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com> <8e1593ee-5a68-c0a1-50e4-6fedb6f3ec5a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e1593ee-5a68-c0a1-50e4-6fedb6f3ec5a@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 14, 2019 at 11:39 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> sorry for the delay.
>
> On 10/01/2019 11:20, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >>>       if (entered_state >= 0) {
> >>> +             s64 diff, delay = drv->states[entered_state].exit_latency;
> >>> +             int i;
> >>> +
> >>>               /*
> >>>                * Update cpuidle counters
> >>>                * This can be moved to within driver enter routine,
> >>> @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >>>               dev->last_residency = (int)diff;
> >>
> >> Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?
> >
> > No.
> >
> >> Otherwise the 'last_residency' accumulates the effective sleep time and
> >> the time to wakeup. We are interested in the sleep time only for
> >> prediction and metrics no ?
> >
> > Yes, but 'delay' is the worst-case latency and not the actual one
> > experienced, most of the time, and (on average) we would underestimate
> > the sleep time if it was always subtracted.
>
> IMO, the exit latency is more or less constant for the cpu power down
> state. When it is the cluster power down state, the first cpu waking up
> has the worst latency, then the others have the same has the cpu power
> down state.
>
> If we can model that, the gray area you mention below can be reduced.
> There are platform where the exit latency is very high [1] and not
> taking it into account will give very wrong metrics.

That is kind of a special case, though, and there is no way for the
cpuidle core do distinguish it from all of the other cases.

> > The idea here is to only count the wakeup as 'above' if the total
> > 'last_residency' is below the target residency of the idle state that
> > was asked for (as in that case we know for certain that the CPU has
> > been woken up too early) and to only count it as 'below' if the
> > difference between 'last_residency' and 'delay' is greater than or
> > equal to the target residency of a deeper idle state (as in that case
> > we know for certain that the CPU has been woken up too late).
> >
> > Of course, this means that there is a "gray area" in which we are not
> > really sure if the sleep time has matched the idle state that was
> > asked for, but there's not much we can do about that IMO.
>
> There is another aspect of the metric which can be improved, the 'above'
> and the 'below' give an rough indication about the correctness of the
> prediction but they don't tell us which idle state we should have
> selected (we can be constantly choosing state3 instead of state1 for
> example).
>
> It would be nice to add a 'missed' field for each idle states, so when
> we check if there is a 'above' or a 'below' condition, we increment the
> idle state 'missed' field for the idle state we should have selected.

That's a governor's job however.  That's why there is the ->reflect
governor callback after all, among other things.
