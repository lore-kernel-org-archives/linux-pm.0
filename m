From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Wed, 10 Feb 2016 14:46:07 +0000
Message-ID: <20160210144607.GG11415@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <20160210123342.GA11415@e106622-lin>
 <CAJZ5v0gWV+Qc2CM6YN90=s+TE2HCDOZVCRH7nOrKFW+kGiOpDA@mail.gmail.com>
 <20160210140315.GD11415@e106622-lin>
 <CAJZ5v0jRSxZyKixTvOc3BDVxBLzx1HVeJhNEzX4UZA7txvEM9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47929 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbcBJOpV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Feb 2016 09:45:21 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jRSxZyKixTvOc3BDVxBLzx1HVeJhNEzX4UZA7txvEM9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 10/02/16 15:26, Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2016 at 3:03 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> > On 10/02/16 14:23, Rafael J. Wysocki wrote:
> >> On Wed, Feb 10, 2016 at 1:33 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> >> > Hi Rafael,
> >> >
> >> > On 09/02/16 21:05, Rafael J. Wysocki wrote:
> >> >
> >> > [...]
> >> >
> >> >> +/**
> >> >> + * cpufreq_update_util - Take a note about CPU utilization changes.
> >> >> + * @util: Current utilization.
> >> >> + * @max: Utilization ceiling.
> >> >> + *
> >> >> + * This function is called by the scheduler on every invocation of
> >> >> + * update_load_avg() on the CPU whose utilization is being updated.
> >> >> + */
> >> >> +void cpufreq_update_util(unsigned long util, unsigned long max)
> >> >> +{
> >> >> +     struct update_util_data *data;
> >> >> +
> >> >> +     rcu_read_lock();
> >> >> +
> >> >> +     data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
> >> >> +     if (data && data->func)
> >> >> +             data->func(data, cpu_clock(smp_processor_id()), util, max);
> >> >
> >> > Are util and max used anywhere?
> >>
> >> They aren't yet, but they will be.
> >>
> >> Maybe not in this cycle (it it takes too much time to integrate the
> >> preliminary changes), but we definitely are going to use those
> >> numbers.
> >>
> >
> > Oh OK. However, I was under the impression that this set was only
> > proposing a way to get rid of timers and use the scheduler as heartbeat
> > for cpufreq governors. The governors' sample based approach wouldn't
> > change, though. Am I wrong in assuming this?
> 
> Your assumption is correct.
> 

In this case. Wouldn't be possible to simply put the kicks in
sched/core.c? scheduler_tick() seems a good candidate for that, and you
could complement that with enqueue/dequeue/etc., if needed.

I'm actually wondering if a slow CONFIG_HZ might affect governors'
sampling rate. We might have scheduler tick firing every 40ms and
sampling rate set to 10 or 20ms, don't we?

> The sample-based approach doesn't change at this time, simply to avoid
> making too many changes in one go.
> 
> The next step, as I'm seeing it, would be to use the
> scheduler-provided utilization in the governor computations instead of
> the load estimation made by governors themselves.
> 

OK. But, I'm not sure what does this buy us. If the end goal is still to
do sampling, aren't we better off using the (1 - idle) estimation as
today?

> > Also, is linux-pm/bleeding-edge the one I want to fetch to try this set out?
> 
> You can get it from there, but possibly with some changes unrelated to cpufreq.
> 
> You can also pull from the pm-cpufreq-test branch to get the cpufreq
> changes only.
> 
> Apart from that, I'm going resend the $subject set with updated patch
> [1/3] for completeness.
> 

Great, thanks! Let's see if I can finally find time to run some tests
this time :).

Best,

- Juri
