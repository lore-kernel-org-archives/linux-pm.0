From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 22/46] sched: Calculate energy consumption of
 sched_group
Date: Fri, 14 Aug 2015 11:28:28 +0100
Message-ID: <20150814102828.GC29326@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
 <20150813153417.GY19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37834 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbbHNKZI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 06:25:08 -0400
Content-Disposition: inline
In-Reply-To: <20150813153417.GY19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Aug 13, 2015 at 05:34:17PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:05PM +0100, Morten Rasmussen wrote:
> > +static unsigned int sched_group_energy(struct sched_group *sg_top)
> > +{
> > +	struct sched_domain *sd;
> > +	int cpu, total_energy = 0;
> > +	struct cpumask visit_cpus;
> > +	struct sched_group *sg;
> > +
> > +	WARN_ON(!sg_top->sge);
> > +
> > +	cpumask_copy(&visit_cpus, sched_group_cpus(sg_top));
> > +
> > +	while (!cpumask_empty(&visit_cpus)) {
> > +		struct sched_group *sg_shared_cap = NULL;
> > +
> > +		cpu = cpumask_first(&visit_cpus);
> > +
> > +		/*
> > +		 * Is the group utilization affected by cpus outside this
> > +		 * sched_group?
> > +		 */
> > +		sd = highest_flag_domain(cpu, SD_SHARE_CAP_STATES);
> > +		if (sd && sd->parent)
> > +			sg_shared_cap = sd->parent->groups;
> > +
> > +		for_each_domain(cpu, sd) {
> > +			sg = sd->groups;
> > +
> > +			/* Has this sched_domain already been visited? */
> > +			if (sd->child && group_first_cpu(sg) != cpu)
> > +				break;
> > +
> > +			do {
> > +				struct sched_group *sg_cap_util;
> > +				unsigned long group_util;
> > +				int sg_busy_energy, sg_idle_energy, cap_idx;
> > +
> > +				if (sg_shared_cap && sg_shared_cap->group_weight >= sg->group_weight)
> > +					sg_cap_util = sg_shared_cap;
> > +				else
> > +					sg_cap_util = sg;
> > +
> > +				cap_idx = find_new_capacity(sg_cap_util, sg->sge);
> 
> So here its not really 'new' capacity is it, most like the current
> capacity?

Yes, sort of. It is what the current capacity (P-state) should be to
accommodate the current utilization. Using a sane cpufreq governor it is
most likely not far off.

I could rename it to find_capacity() instead. It is extended in a
subsequent patch to figure out the 'new' capacity in cases were we
consider putting more utilization into the group.

> So in the case of coupled P states, you look for the CPU with highest
> utilization, as that is the on that determines the required P state.

Yes. That is why we need the SD_SHARE_CAP_STATES flag and we use
group_max_usage() in find_new_capacity().
