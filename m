From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Tue, 23 Apr 2019 09:07:35 +0100
Message-ID: <20190423080732.rmwxjh67re57sayk@queper01-lin>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
 <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
 <20190418080429.pn4r6lnftlfsf4c4@queper01-lin>
 <20190422082518.jenl4x7rkmv3j67x@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190422082518.jenl4x7rkmv3j67x@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Monday 22 Apr 2019 at 13:55:18 (+0530), Viresh Kumar wrote:
> On 18-04-19, 09:04, Quentin Perret wrote:
> > On Thursday 18 Apr 2019 at 09:23:23 (+0530), Viresh Kumar wrote:
> > > On 17-04-19, 10:43, Quentin Perret wrote:
> > > >  static struct thermal_cooling_device *
> > > >  __cpufreq_cooling_register(struct device_node *np,
> > > > -			struct cpufreq_policy *policy, u32 capacitance)
> > > > +			struct cpufreq_policy *policy,
> > > > +			struct em_perf_domain *em)
> > > >  {
> > > 
> > > > +	if (em_is_sane(cpufreq_cdev, em)) {
> > > > +		cpufreq_cdev->em = em;
> > > >  		cooling_ops = &cpufreq_power_cooling_ops;
> > > > -	} else {
> > > > +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
> > > >  		cooling_ops = &cpufreq_cooling_ops;
> > > > +	} else {
> > > > +		WARN(1, "cpu_cooling: no valid frequency table found\n");
> > > 
> > > Well the frequency table is valid, isn't it ?
> > 
> > True ...
> > 
> > > Maybe something like: "cpu_cooling doesn't support unsorted frequency tables" ?
> > 
> > Right, otherwise I guess that could be confused with the check on
> > cpu_table_count_valid_entries() above. And while I'm thinking about it
> > perhaps WARN is a bit too much here ? We can handle the error safely so
> > pr_err() should be enough ?
> 
> Hmm, I would keep the WARN as it is hard to miss it compared to a
> simple pr_err.

Right, I don't really mind either way TBH. But is this worse than having
a NULL policy for example ? We have a standard pr_err() in this case.
And same thing if the cooling device registration failed actually. Do
you see a good reason to deal with EM stuff differently ?

Thanks,
Quentin
