From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Wed, 10 Apr 2019 09:57:04 +0100
Message-ID: <20190410085702.nll6spd565oio3ds@queper01-lin>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <20190410054449.zwmemg7vza557gue@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410054449.zwmemg7vza557gue@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 Apr 2019 at 11:14:49 (+0530), Viresh Kumar wrote:
> On 28-03-19, 10:13, Quentin Perret wrote:
> > +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> > +			      unsigned long state)
> > +{
> > +	struct cpufreq_policy *policy;
> > +	unsigned long idx;
> > +
> > +	/* Use the Energy Model table if available */
> > +	if (cpufreq_cdev->em) {
> > +		idx = cpufreq_cdev->max_level - state;
> > +		return cpufreq_cdev->em->table[idx].frequency;
> > +	}
> > +
> > +	/* Otherwise, fallback on the CPUFreq table */
> > +	policy = cpufreq_cdev->policy;
> > +	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> 
> It is not guaranteed that the frequency table is sorted in any order, isn't it ?

Hmm, indeed... I thought cpufreq_table_validate_and_sort() was actively
sorting the table but it seems I was wrong.

But I _think_ in practice the freq table actually happens to be sorted
for the upstream cpufreq drivers with the CPUFREQ_IS_COOLING_DEV flag
set. Most of them use dev_pm_opp_init_cpufreq_table() which guarantees
the table is sorted and qoriq-cpufreq explicitly sorts the table. But
I'm not sure about qcom-cpufreq-hw ...

So, if the above is true, perhaps I could simply add a check to mandate
that policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_UNSORTED for
cpu_cooling ? That shouldn't harm the existing users.

Do you happen to know a board where the table is unsorted ? Is it a
common use-case ?

If yes, then I'll probably need to drop the dependency on cpufreq's
freq_table and use something else to convert indexes into frequencies
(PM_OPP ?). Unless we can force-sort the table in the cpufreq core, but
that might require lots of changes to lots of drivers too.

> 
> > +		idx = cpufreq_cdev->max_level - state;
> > +	else
> > +		idx = state;
> 
> -- 
> viresh

Thanks,
Quentin
