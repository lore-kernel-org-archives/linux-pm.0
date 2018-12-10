From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Mon, 10 Dec 2018 22:36:40 +0100
Message-ID: <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210122104.GL5289@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 10, 2018 at 12:30:23PM +0100, Rafael J. Wysocki wrote:
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
>
> > @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >               dev->last_residency = (int)diff;
> >               dev->states_usage[entered_state].time += dev->last_residency;
> >               dev->states_usage[entered_state].usage++;
> > +
> > +             if (diff < drv->states[entered_state].target_residency) {
> > +                     for (i = entered_state - 1; i >= 0; i--) {
> > +                             if (drv->states[i].disabled ||
> > +                                 dev->states_usage[i].disable)
> > +                                     continue;
> > +
> > +                             /* Shallower states are enabled, so update. */
> > +                             dev->states_usage[entered_state].above++;
> > +                             break;
> > +                     }
> > +             } else if (diff > delay) {
> > +                     for (i = entered_state + 1; i < drv->state_count; i++) {
> > +                             if (drv->states[i].disabled ||
> > +                                 dev->states_usage[i].disable)
> > +                                     continue;
> > +
> > +                             /*
> > +                              * Update if a deeper state would have been a
> > +                              * better match for the observed idle duration.
> > +                              */
> > +                             if (diff - delay >= drv->states[i].target_residency)
> > +                                     dev->states_usage[entered_state].below++;
> > +
> > +                             break;
> > +                     }
> > +             }
>
> One question on this; why is this tracked unconditionally?

Because I didn't quite see how to make that conditional in a sensible way.

These things are counters and counting with the help of tracepoints
isn't particularly convenient (and one needs debugfs to be there to
use tracepoints and they require root access etc).

> Would not a tracepoint be better?; then there is no overhead in the
> normal case where nobody gives a crap about these here numbers.

There is an existing tracepoint that in principle could be used to
produce this information, but it is such a major PITA in practice that
nobody does that.  Guess why. :-)

Also, the "usage" and "time" counters are there in sysfs, so why not these two?

And is the overhead really that horrible?
