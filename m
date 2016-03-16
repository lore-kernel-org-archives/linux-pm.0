From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Wed, 16 Mar 2016 22:38:55 +0100
Message-ID: <3456066.ocPAtCXNWC@vostro.rjw.lan>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan> <11678919.CQLTrQTYxG@vostro.rjw.lan> <20160316181420.GH6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160316181420.GH6344@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 16, 2016 07:14:20 PM Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> > +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> > +				unsigned int next_freq)
> > +{
> > +	struct cpufreq_policy *policy = sg_policy->policy;
> > +
> > +	if (next_freq > policy->max)
> > +		next_freq = policy->max;
> > +	else if (next_freq < policy->min)
> > +		next_freq = policy->min;
> > +
> > +	sg_policy->last_freq_update_time = time;
> > +	if (sg_policy->next_freq == next_freq) {
> > +		if (policy->fast_switch_enabled)
> > +			trace_cpu_frequency(policy->cur, smp_processor_id());
> > +
> > +		return;
> > +	}
> > +
> > +	sg_policy->next_freq = next_freq;
> > +	if (policy->fast_switch_enabled) {
> > +		unsigned int freq;
> > +
> > +		freq = cpufreq_driver_fast_switch(policy, next_freq);
> 
> So you're assuming a RELATION_L for ->fast_switch() ?

Yes, I am.

> > +		if (freq == CPUFREQ_ENTRY_INVALID)
> > +			return;
> > +
> > +		policy->cur = freq;
> > +		trace_cpu_frequency(freq, smp_processor_id());
> > +	} else {
> > +		sg_policy->work_in_progress = true;
> > +		irq_work_queue(&sg_policy->irq_work);
> > +	}
> > +}
> 
> 
> > +static void sugov_work(struct work_struct *work)
> > +{
> > +	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > +
> > +	mutex_lock(&sg_policy->work_lock);
> > +	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> > +				CPUFREQ_RELATION_L);
> 
> As per here, which I assume matches semantics on that point.

Correct.

