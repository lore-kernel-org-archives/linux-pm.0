From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH RFC v2 4/4] sched: cpufreq_cfs: pelt-based cpu frequency scaling
Date: Mon, 29 Jun 2015 09:51:41 -0700
Message-ID: <20150629165141.9112.30682@quantum>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
 <1431396795-32439-5-git-send-email-mturquette@linaro.org>
 <555A1666.30306@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36441 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbF2Qv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 12:51:58 -0400
Received: by pdcu2 with SMTP id u2so119748047pdc.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2015 09:51:58 -0700 (PDT)
In-Reply-To: <555A1666.30306@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "riel@redhat.com" <riel@redhat.com>, "efault@gmx.de" <efault@gmx.de>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "alex.shi@linaro.org" <alex.shi@linaro.org>, "abelvesa@gmail.com" <abelvesa@gmail.com>

Hi Juri,

Quoting Juri Lelli (2015-05-18 09:42:14)
> On 12/05/15 03:13, Michael Turquette wrote:
> > +#define MARGIN_PCT             125 /* taken from imbalance_pct = 125 */
> 
> You don't use this anymore, right? But see also my comment below
> on this.

Right. And in the new version I'll move this out to fair.c. I want to
move that sort of policy into cfs and make this governor even more
"dumb".

> > + * Returns the newly chosen capacity. Note that this may not reflect reality if
> > + * the hardware fails to transition to this new capacity state.
> > + */
> > +unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util)
> 
> Is anybody consuming the return value? Did you have in mind some
> possible usage of it?

I did have in mind that the scheduling class could do something useful
with this value. But this somewhat duplicates the
arch_scale_freq_capacity stuff so I can remove it.

> 
> > +{
> > +       unsigned long util_new, util_old, util_max, capacity_new;
> > +       unsigned int freq_new, freq_tmp, cpu_tmp;
> > +       struct cpufreq_policy *policy;
> > +       struct gov_data *gd;
> > +       struct cpufreq_frequency_table *pos;
> > +
> > +       /* handle rounding errors */
> > +       util_new = util > SCHED_LOAD_SCALE ? SCHED_LOAD_SCALE : util;
> > +
> > +       /* update per-cpu utilization */
> > +       util_old = __this_cpu_read(pcpu_util);
> > +       __this_cpu_write(pcpu_util, util_new);
> > +
> > +       /* avoid locking policy for now; accessing .cpus only */
> > +       policy = per_cpu(pcpu_policy, cpu);
> > +
> > +       /* find max utilization of cpus in this policy */
> > +       util_max = 0;
> > +       for_each_cpu(cpu_tmp, policy->cpus)
> > +               util_max = max(util_max, per_cpu(pcpu_util, cpu_tmp));
> > +
> > +       /*
> > +        * We only change frequency if this cpu's utilization represents a new
> > +        * max. If another cpu has increased its utilization beyond the
> > +        * previous max then we rely on that cpu to hit this code path and make
> > +        * the change. IOW, the cpu with the new max utilization is responsible
> > +        * for setting the new capacity/frequency.
> > +        *
> > +        * If this cpu is not the new maximum then bail, returning the current
> > +        * capacity.
> > +        */
> > +       if (util_max > util_new)
> > +               return capacity_of(cpu);
> 
> Here and below you probably want to return arch_scale_freq_capacity(NULL, cpu),
> as capacity_of() returns the remaining capacity (w.r.t. capacity_orig) for CFS
> tasks after RT tasks contribution is removed.

In fact I wanted to return the capacity that reflects only cfs, but
since I'm going to remove the return value it is moot.

> 
> > +
> > +       /*
> > +        * We are going to request a new capacity, which might result in a new
> > +        * cpu frequency. From here on we need to serialize access to the
> > +        * policy and the governor private data.
> > +        */
> > +       policy = cpufreq_cpu_get(cpu);
> > +       if (IS_ERR_OR_NULL(policy)) {
> > +               return capacity_of(cpu);
> > +       }
> 
> Shouldn't this be removed now that we have pcpu_policy?
> Also the cpufreq_put_cpu() below.

We must still 'get' the policy in order to call the cpufreq apis below.
This involves holding locks that are managed for us in
cpufreq_cpu_{get,put}. In fact the pcu_policy thing is a gross hack to
avoid holding the locks and it is probably unsafe. I've removed it in
the new version.

> 
> > +
> > +       capacity_new = capacity_of(cpu);
> > +       if (!policy->governor_data) {
> > +               goto out;
> > +       }
> > +
> > +       gd = policy->governor_data;
> > +
> > +       /* bail early if we are throttled */
> > +       if (ktime_before(ktime_get(), gd->throttle)) {
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Convert the new maximum capacity utilization into a cpu frequency
> > +        *
> > +        * It is possible to convert capacity utilization directly into a
> > +        * frequency, but that implies that we would be 100% utilized. Instead,
> > +        * first add a margin (default 25% capacity increase) to the new
> > +        * capacity request. This provides some head room if load increases.
> > +        */
> > +       capacity_new = util_new + (SCHED_CAPACITY_SCALE >> 2);
> 
> Here you introduce this 25% margin w.r.t. SCHED_CAPACITY_SCALE.
> Shouldn't the margin be related to util_new instead (using MARGIN_PCT
> maybe)?

Maybe?!?! I'm moving this type of policy into fair.c in the new version.
Figuring out this policy is going to be a long road, with lots of
testing and competing requirements. Getting infrastructure merged
upstream is a different task compared to finding the best cpu frequency
scaling policy. Some testing already shows that for certain workloads
using the PELT curve in the way that I use it results in very slow
frequency transition times.

Thus I would prefer that this simple governor not be gated on figuring
out all of that stuff first. There are some good reasons for this:

1) it makes it easier for you to use this work with your EAS series if
the governor does not implement any policy of its own

2) it can hopefully get merged by removing the controversial policy
stuff

TL;DR, I'm no longer trying to solve the policy problem in this series.

> 
> > +       freq_new = capacity_new * policy->max >> SCHED_CAPACITY_SHIFT;
> > +
> > +       /*
> > +        * If a frequency table is available then find the frequency
> > +        * corresponding to freq_new.
> > +        *
> > +        * For cpufreq drivers without a frequency table, use the frequency
> > +        * directly computed from capacity_new + 25% margin.
> > +        */
> > +       if (policy->freq_table) {
> > +               freq_tmp = policy->max;
> > +               cpufreq_for_each_entry(pos, policy->freq_table) {
> > +                       if (pos->frequency >= freq_new &&
> > +                                       pos->frequency < freq_tmp)
> > +                               freq_tmp = pos->frequency;
> > +               }
> > +               freq_new = freq_tmp;
> > +               capacity_new = (freq_new << SCHED_CAPACITY_SHIFT) / policy->max;
> > +       }
> 
> Do we really need to do this here? Doesn't __cpufreq_driver_target()
> do the same for us?

Yes it does, but I was trying to get an accurate capacity target to
return to cfs. Since I'm removing that in the next version then I can
remove this as well.

Thanks as always for your review!

Best regards,
Mike
