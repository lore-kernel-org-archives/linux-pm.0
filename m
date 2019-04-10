From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Wed, 10 Apr 2019 15:44:23 +0530
Message-ID: <20190410101423.3pl6yfhv2wnxuwgw@vireshk-i7>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <20190410054449.zwmemg7vza557gue@vireshk-i7>
 <20190410085702.nll6spd565oio3ds@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410085702.nll6spd565oio3ds@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 10-04-19, 09:57, Quentin Perret wrote:
> Hmm, indeed... I thought cpufreq_table_validate_and_sort() was actively
> sorting the table but it seems I was wrong.
> 
> But I _think_ in practice the freq table actually happens to be sorted
> for the upstream cpufreq drivers with the CPUFREQ_IS_COOLING_DEV flag
> set. Most of them use dev_pm_opp_init_cpufreq_table() which guarantees
> the table is sorted and qoriq-cpufreq explicitly sorts the table. But
> I'm not sure about qcom-cpufreq-hw ...
> 
> So, if the above is true, perhaps I could simply add a check to mandate
> that policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_UNSORTED for
> cpu_cooling ? That shouldn't harm the existing users.

Right, I think most of the platforms will have it sorted anyway right now, but
you never know if one or two of them don't. Maybe just add the above conditional
and put out an error or WARN or something, so people know that something broke.


-- 
viresh
