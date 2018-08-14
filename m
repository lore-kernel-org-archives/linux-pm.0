From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Date: Tue, 14 Aug 2018 19:26:50 +0200
Message-ID: <CAJZ5v0gUCLUe-Hz02upZTti3RUDd7fZNpzEOAJEdLW95OgzL1Q@mail.gmail.com>
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan> <1572343.jWaXB8XNF1@aspire.rjw.lan> <20180814154441.GA13920@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814154441.GA13920@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 14, 2018 at 5:44 PM <leo.yan@linaro.org> wrote:
>
> On Tue, Aug 14, 2018 at 12:34:40PM +0200, Rafael J . Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> > with stopped tick) missed the case when the target residencies of
> > deep idle states of CPUs are above the tick boundary which may cause
> > the CPU to get stuck in a shallow idle state for a long time.
> >
> > Say there are two CPU idle states available: one shallow, with the
> > target residency much below the tick boundary and one deep, with
> > the target residency significantly above the tick boundary.  In
> > that case, if the tick has been stopped already and the expected
> > next timer event is relatively far in the future, the governor will
> > assume the idle duration to be equal to TICK_USEC and it will select
> > the idle state for the CPU accordingly.  However, that will cause the
> > shallow state to be selected even though it would have been more
> > energy-efficient to select the deep one.
> >
> > To address this issue, modify the governor to always use the time
> > till the closest timer event instead of the predicted idle duration
> > if the latter is less than the tick period length and the tick has
> > been stopped already.  Also make it extend the search for a matching
> > idle state if the tick is stopped to avoid settling on a shallow
> > state if deep states with target residencies above the tick period
> > length are available.
> >
> > In addition, make it always indicate that the tick should be stopped
> > if it has been stopped already for consistency.
> >
> > Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> > Reported-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > -> v2: Initialize first_idx properly in the stopped tick case.
> >
> > v2 -> v3: Compute data->bucket before checking whether or not the tick has been
> >           stopped already to prevent it from becoming stale.
> >
> > v3 -> v4: Allow the usual state selection to be carried out if the tick has been
> >           stopped in case the predicted idle duration is greater than the tick
> >           period length and a matching state can be found without overriding
> >           the prediction result.
> >
> > v4 -> v5: Rework code to be more straightforward.  Functionally, it should
> >           behave like the v4.
> > ---
> >  drivers/cpuidle/governors/menu.c |   36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
> >                * If the tick is already stopped, the cost of possible short
> >                * idle duration misprediction is much higher, because the CPU
> >                * may be stuck in a shallow idle state for a long time as a
> > -              * result of it.  In that case say we might mispredict and try
> > -              * to force the CPU into a state for which we would have stopped
> > -              * the tick, unless a timer is going to expire really soon
> > -              * anyway.
> > +              * result of it.  In that case say we might mispredict and use
> > +              * the known time till the closest timer event for the idle
> > +              * state selection.
> >                */
> >               if (data->predicted_us < TICK_USEC)
> > -                     data->predicted_us = min_t(unsigned int, TICK_USEC,
> > -                                                ktime_to_us(delta_next));
> > +                     data->predicted_us = ktime_to_us(delta_next);
> >       } else {
> >               /*
> >                * Use the performance multiplier and the user-configurable
> > @@ -381,8 +379,22 @@ static int menu_select(struct cpuidle_dr
> >                       continue;
> >               if (idx == -1)
> >                       idx = i; /* first enabled state */
> > -             if (s->target_residency > data->predicted_us)
> > -                     break;
> > +             if (s->target_residency > data->predicted_us) {
> > +                     if (!tick_nohz_tick_stopped())
> > +                             break;
> > +
> > +                     /*
> > +                      * If the state selected so far is shallow and this
> > +                      * state's target residency matches the time till the
> > +                      * closest timer event, select this one to avoid getting
> > +                      * stuck in the shallow one for too long.
> > +                      */
> > +                     if (drv->states[idx].target_residency < TICK_USEC &&
> > +                         s->target_residency <= ktime_to_us(delta_next))
> > +                             idx = i;
>
> I took some time to understand v4 and v5; now I understand you want to
> prompt to deeper idle state if the prediction falls in the range
> between [TICK_USEC..max_target_residency).  This seems to me is a
> huristics method but not general enough and IMHO this is more difficult
> for code readable.
>
> I agree this patch can resolve the issue you mentioned in the commit
> log, but this patch will be fragile for below case, so it will select
> state1 but not state2, how about you think for this case?

It is OK to select state1 in this case IMO, because if the tick had
not been stopped already, it would have been stopped after selecting
state1 anyway (it is not a "polling" state and expected_interval is
not below TICK_USEC).

> Idle_state0::
> target_residency   TICK_USEC   Prediction
>     |                 |       /
>     V                 V      /
> -----------------------------------------------------> Time length
>                                 ^                 ^
>                                 |                 |
>                             Idle_state1:       Idle_state2:
>                             target_residency   target_residency
>

Basically, the idea is to avoid getting stuck in the idle states for
which the tick would not have been stopped, had it been still running.
