From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 22/46] sched: Calculate energy consumption of
 sched_group
Date: Thu, 17 Sep 2015 17:41:52 +0100
Message-ID: <20150917164152.GA6839@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
 <20150902171923.GB12510@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42433 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbIQQh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 12:37:56 -0400
Content-Disposition: inline
In-Reply-To: <20150902171923.GB12510@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Sep 03, 2015 at 01:19:23AM +0800, Leo Yan wrote:
> On Tue, Jul 07, 2015 at 07:24:05PM +0100, Morten Rasmussen wrote:
> > +/*
> > + * sched_group_energy(): Returns absolute energy consumption of cpus belonging
> > + * to the sched_group including shared resources shared only by members of the
> > + * group. Iterates over all cpus in the hierarchy below the sched_group starting
> > + * from the bottom working it's way up before going to the next cpu until all
> > + * cpus are covered at all levels. The current implementation is likely to
> > + * gather the same usage statistics multiple times. This can probably be done in
> > + * a faster but more complex way.
> > + */
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
> 
> If the sched domain is already the highest level, should directly use
> its group to calculate shared capacity? so the code like below:
> 
>                 if (sd && sd->parent)
>                         sg_shared_cap = sd->parent->groups;
>                 else if (sd && !sd->parent)
>                         sg_shared_cap = sd->groups;

This isn't really the right thing to do. The fundamental problem is that
we need to know somehow which cpus that share the same clock source
(frequency). We have chosen to use sched_groups to represent groups for
all the energy model calculations, so we use sg_shared_cap to indicate
which cpus that share the same clock source. In the loop above we find
the sched_domain that spans all cpus sharing the same clock source, and
sd->parent->groups trick gives us a sched_group spanning the same cpus,
if such sched_domain/group exists. The problem is when it doesn't, i.e.
all cpus share the same clock source. Using a sched_group at the current
level would be wrong as it is only spanning a subset of the cpus that
really share clock source.

It is clearly a missing piece in the current patch set. If you are
after a quick and ugly fix you can either: 1) create a temporary
sched_group spanning the same cpus as sd, or 2) change struct energy_env
and find_new_capacity() to use a cpumask instead of a sched_group and
pass the cpumask from the sd instead of sched_group pointer.

IMHO, the right solution is to introduce a system-wide sched_group
(there has been previous discussions on this) that spans all the cpus. I
think it should work even without attaching any energy data to that
sched_group. Otherwise, I think you can get away with just adding a zero
cost capacity and idle state.

Dietmar has already got patches that implements a system-wide
sched_group which I'm sure he is willing to share ;-)
