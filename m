From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 16 Mar 2016 23:40:54 +0100
Message-ID: <20160316224054.GL6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <11678919.CQLTrQTYxG@vostro.rjw.lan>
 <20160316181420.GH6344@twins.programming.kicks-ass.net>
 <3456066.ocPAtCXNWC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52413 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbcCPWk7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 18:40:59 -0400
Content-Disposition: inline
In-Reply-To: <3456066.ocPAtCXNWC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 16, 2016 at 10:38:55PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 16, 2016 07:14:20 PM Peter Zijlstra wrote:
> > On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> > > +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> > > +				unsigned int next_freq)
> > > +{
> > > +	struct cpufreq_policy *policy = sg_policy->policy;
> > > +
> > > +	if (next_freq > policy->max)
> > > +		next_freq = policy->max;
> > > +	else if (next_freq < policy->min)
> > > +		next_freq = policy->min;
> > > +
> > > +	sg_policy->last_freq_update_time = time;
> > > +	if (sg_policy->next_freq == next_freq) {
> > > +		if (policy->fast_switch_enabled)
> > > +			trace_cpu_frequency(policy->cur, smp_processor_id());
> > > +
> > > +		return;
> > > +	}
> > > +
> > > +	sg_policy->next_freq = next_freq;
> > > +	if (policy->fast_switch_enabled) {
> > > +		unsigned int freq;
> > > +
> > > +		freq = cpufreq_driver_fast_switch(policy, next_freq);
> > 
> > So you're assuming a RELATION_L for ->fast_switch() ?
> 
> Yes, I am.

Should we document that fact somewhere? Or alternatively, if you already
did, I simply missed it.
