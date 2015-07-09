From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Allow accessing freq_table for offline CPUs
Date: Thu, 09 Jul 2015 02:40:51 +0200
Message-ID: <2953689.ETebrTym45@vostro.rjw.lan>
References: <c07ccbe7f415d20e055c9d1ba025a71b902e6b0f.1436340899.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51541 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750814AbbGIAOX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 20:14:23 -0400
In-Reply-To: <c07ccbe7f415d20e055c9d1ba025a71b902e6b0f.1436340899.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Wednesday, July 08, 2015 01:08:15 PM Viresh Kumar wrote:
> Users of freq table may want to access it for any CPU from
> policy->related_cpus mask. One such user is cpu-cooling layer. It gets a
> list of 'clip_cpus' (equivalent to policy->related_cpus) during
> registration and tries to get freq_table for the first CPU of this mask.
> 
> If the CPU, for which it tries to fetch freq_table, is offline,
> cpufreq_frequency_get_table() fails. This happens because it relies on
> cpufreq_cpu_get_raw() for its functioning which returns policy only for
> online CPUs.
> 
> Fix this by considering offline CPUs, but with a restriction that the
> policy is active at that time.

The above sentence is completely unclear to anyone unfamiliar with the
code in question.

The fix is to access the policy data structure for the given CPU directly
(which also returns a valid policy for offline CPUs), but the policy
itself has to be active (meaning that at least one CPU using it is online)
for the frequency table to be returned.

Right?

> Because we will be using 'cpufreq_cpu_data' now, which is internal to
> cpufreq-core, lets also move cpufreq_frequency_get_table() to cpufreq.c
> file.
> 
> Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This was recently tried by Pi cheng but in a completely different way:
> http://marc.info/?l=linux-pm&m=143572367402758&w=2
> 
> Its not broken by any stuff in 4.2, but would be good if we can push
> this for 4.2 as well.
> 
>  drivers/cpufreq/cpufreq.c    | 9 +++++++++
>  drivers/cpufreq/freq_table.c | 7 -------
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2c22e3902e72..26063afb3eba 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -169,6 +169,15 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
>  
> +struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +
> +	return policy && !policy_is_inactive(policy) ?
> +		policy->freq_table : NULL;
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
> +
>  static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
>  {
>  	u64 idle_time;
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index df14766a8e06..7551f01e8536 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -299,13 +299,6 @@ EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
>  
>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
>  
> -struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
> -{
> -	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> -	return policy ? policy->freq_table : NULL;
> -}
> -EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
> -
>  MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
>  MODULE_DESCRIPTION("CPUfreq frequency table helpers");
>  MODULE_LICENSE("GPL");
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
