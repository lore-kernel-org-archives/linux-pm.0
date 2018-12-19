From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpuidle: New timer events oriented governor for tickless
 systems
Date: Wed, 19 Dec 2018 09:32:03 +0000
Message-ID: <20181219093200.3e5zr7ixxowboanv@queper01-lin>
References: <128769314.7imKxugEn6@aspire.rjw.lan>
 <20181218114949.c6npu357fj65l5iv@queper01-ThinkPad-T460s>
 <CAJZ5v0grJJi7572vdT7eudMTSW6h+9KT8WSNXa-z8rWqp-Fikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0grJJi7572vdT7eudMTSW6h+9KT8WSNXa-z8rWqp-Fikw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, hu1.chen@intel.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 18 Dec 2018 at 16:31:13 (+0100), Rafael J. Wysocki wrote:
> > > +             /*
> > > +              * Count and sum the most recent idle duration values less than
> > > +              * the target residency of the state selected so far, find the
> > > +              * max.
> > > +              */
> > > +             for (i = 0; i < INTERVALS; i++) {
> > > +                     unsigned int val = cpu_data->intervals[i];
> > > +
> > > +                     if (val >= drv->states[idx].target_residency)
> > > +                             continue;
> > > +
> > > +                     count++;
> > > +                     sum += val;
> > > +             }
> > > +
> > > +             /*
> > > +              * Give up unless the majority of the most recent idle duration
> > > +              * values are in the interesting range.
> > > +              */
> > > +             if (count > INTERVALS / 2) {
> >
> > I understand this probably works well enough in practice, but how 'robust'
> > is supposed to be this filtering here ? If you have, say, 2 tasks with
> > prime periods, then the hyper-period (which is when the pattern repeats)
> > can get high really quickly, and you'll never see the full extent of
> > that pattern with this mechanism.
> 
> That's correct, but this is just about whether or not there is a
> reason to select an idle state shallower than the one selected
> already.  How the pattern looks like exactly doesn't matter too much
> here AFAICS.

Right, I think what I was trying to say is that if you could actually
capture at least one full hyper-period, then the avg_us you're computing
here would be 'stable' as long as you're not changing workloads. So the
prediction should be accurate overall, in average.

But maybe we don't want that. At least it's not obvious we always want
that. Maybe the hyper-period is so large that you'd be better off
looking only at portion of it and locally optimize things ...

So yes, this is very much a theoretical question. And the results will,
as always, largely depend on the workload you're running, so nevermind.

> > Yes, it's hard to do much better without introducing tons of complexity
> > in here, but how did you define INTERVALS=8 and so ?
> 
> I blatantly stole this number from the menu governor. :-)

Fair enough ;-)

> > > +                     unsigned int avg_us = div64_u64(sum, count);
> > > +
> > > +                     /*
> > > +                      * Avoid spending too much time in an idle state that
> > > +                      * would be too shallow.
> > > +                      */
> > > +                     if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {
> >
> > IIUC, this is saying we shouldn't trust the predicted sleep time if it
> > is shorter than the tick and the tick is stopped. What is the use case
> > you have in mind for this ?
> >
> > In other words, in which scenario do you expect to see a lot of high
> > frequency non-timer-related wake-ups and have the tick disabled ?
> 
> It is mostly theoretical, but the rationale here is that the cost of
> using a shallow idle state with the tick stopped is potentially very
> high (the CPU may stay in that idle state for a very long time then),
> so it is better to assume misprediction in that case to avoid that
> cost.

I see, and since we should in fact have the tick enabled when loads of
tasks are running, then this check should usually be harmless in
practice. Makes sense.

Thanks,
Quentin
