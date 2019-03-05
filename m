From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Tue, 5 Mar 2019 11:01:37 +0000
Message-ID: <20190305110135.jdgc6vtdivs5rdjv@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <3017597.CVkTxgYgAs@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2336151.IZk3Z8DVvP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 05 Mar 2019 at 11:50:56 (+0100), Rafael J. Wysocki wrote:
> On Tuesday, March 5, 2019 11:42:59 AM CET Quentin Perret wrote:
> > > +static void intel_pstate_update_max_freq(unsigned int cpu)
> > > +{
> > > +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > +	struct cpufreq_policy new_policy;
> > > +	struct cpudata *cpudata;
> > > +
> > > +	if (!policy)
> > > +		return;
> > > +
> > > +	down_write(&policy->rwsem);
> > > +
> > > +	if (policy_is_inactive(policy))
> > > +		goto unlock;
> > > +
> > > +	cpudata = all_cpu_data[cpu];
> > > +	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
> > > +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
> > > +
> > > +	memcpy(&new_policy, policy, sizeof(*policy));
> > > +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> > > +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> > > +
> > > +	cpufreq_set_policy(policy, &new_policy);
> > 
> > Do you want to force-restart the governor here ?
> 
> cpufreq_set_policy() is expected to take care of the governor.
> If it doesn't, there is a bug somewhere.

Yes, it does something when there is a governor change, but that's not
the case here IIUC.

> > Schedutil caches cpuinfo.max_freq for the iowait stuff in sugov_start() [1].
> 
> If it does so, it should update the cached value in sugov_limits().
> 
> I guess I can add a patch updating it to this series.

Right, I think we've been under the assumption that unlike policy->max,
cpuinfo.max_freq should be constant, so there was no need to update the
value at run time. But if that assumption doesn't hold any more, then
yeah we'll need something more dynamic I guess.

> 
> > I'm not sure about the other governors.
> 
> They don't do that AFAICS.

OK

> > And just removing sg_cpu->iowait_boost_max to use the cpuinfo struct
> > instead will conflict with [2], I think.
> 
> Thanks for pointing this out.

N/p :-)

Thanks,
Quentin
