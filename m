From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Thu, 25 Feb 2016 22:08:48 +0100
Message-ID: <1792311.cuUNhUde5n@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <8427745.Y8N2bqC3SO@vostro.rjw.lan> <20160225092837.GD6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160225092837.GD6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 25, 2016 10:28:37 AM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 04:55:57AM +0100, Rafael J. Wysocki wrote:
> > > +static void dummy(void *info) {}
> > > +
> > > +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> > > +{
> > > +	struct gov_data *gd = policy->governor_data;
> > > +	int cpu;
> > > +
> > > +	/*
> > > +	 * The schedfreq static key is managed here so the global schedfreq
> > > +	 * lock must be taken - a per-policy lock such as policy->rwsem is
> > > +	 * not sufficient.
> > > +	 */
> > > +	mutex_lock(&gov_enable_lock);
> > > +
> > > +	/*
> > > +	 * The governor stop path may or may not hold policy->rwsem. There
> > > +	 * must be synchronization with the slow path however.
> > > +	 */
> > > +	mutex_lock(&gd->slowpath_lock);
> > > +
> > > +	/*
> > > +	 * Stop new entries into the hot path for all CPUs. This will
> > > +	 * potentially affect other policies which are still running but
> > > +	 * this is an infrequent operation.
> > > +	 */
> > > +	static_key_slow_dec(&__sched_freq);
> > > +	enabled_policies--;
> > > +
> > > +	/*
> > > +	 * Ensure that all CPUs currently part of this policy are out
> > > +	 * of the hot path so that if this policy exits we can free gd.
> > > +	 */
> > > +	preempt_disable();
> > > +	smp_call_function_many(policy->cpus, dummy, NULL, true);
> > > +	preempt_enable();
> > 
> > I'm not sure how this works, can you please tell me?
> 
> I think it relies on the fact that rq->lock disables IRQs, so if we've
> managed to IPI all relevant CPUs, it means they cannot be inside a
> rq->lock section.
> 
> Its vile though; one should not spray IPIs if one can avoid it. Such
> things are much better done with RCU. Sure sync_sched() takes a little
> longer, but this isn't a fast path by any measure.

I see, thanks!

BTW, when cpufreq_update_util() callbacks are removed, I use synchronize_rcu()
to wait for the running ones, but would it be better to use synchronize_sched()
in there instead?

Thanks,
Rafael
