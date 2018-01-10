From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] thermal: cpu_cooling: use power models from the OPP
 library
Date: Wed, 10 Jan 2018 10:07:26 +0530
Message-ID: <20180110043726.GE3335@vireshk-i7>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180109110252.13557-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34602 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965409AbeAJEh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 23:37:29 -0500
Received: by mail-pg0-f67.google.com with SMTP id j4so9918167pgp.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 20:37:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180109110252.13557-3-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On 09-01-18, 11:02, Quentin Perret wrote:
> Now that the OPP library features a power estimator, the existing code
> in IPA can be modified to rely only on dev_pm_opp_get_power() without
> having to care about the dynamic-power-coefficient DT binding.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c   |  2 ++
>  drivers/cpufreq/cpufreq-dt.c       |  2 ++
>  drivers/cpufreq/mediatek-cpufreq.c |  2 ++
>  drivers/thermal/cpu_cooling.c      | 33 +++++++++------------------------
>  4 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index c56b57dcfda5..3ae67c3510b6 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -497,6 +497,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  	if (is_bL_switching_enabled())
>  		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
>  
> +	dev_pm_opp_of_estimate_power(cpu_dev);
> +
>  	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index de3d104c25d7..b05b0d8eb3f2 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -284,6 +284,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	dev_pm_opp_of_estimate_power(cpu_dev);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 8c04dddd3c28..c1b2fb67a73e 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -470,6 +470,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = info;
>  	policy->clk = info->cpu_clk;
>  
> +	dev_pm_opp_of_estimate_power(info->cpu_dev);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:

The above changes wouldn't be required with suggestions from 1/2.

> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dfd23245f778..b961bd6a198b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -187,7 +187,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  /**
>   * update_freq_table() - Update the freq table with power numbers
>   * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
> - * @capacitance: dynamic power coefficient for these cpus
>   *
>   * Update the freq table with power numbers.  This table will be used in
>   * cpu_power_to_freq() and cpu_freq_to_power() to convert between power and
> @@ -197,8 +196,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>   * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
>   * or -ENOMEM if we run out of memory.
>   */
> -static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
> -			     u32 capacitance)
> +static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev)
>  {
>  	struct freq_table *freq_table = cpufreq_cdev->freq_table;
>  	struct dev_pm_opp *opp;
> @@ -227,9 +225,6 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
>  
>  	for (i = 0; i <= cpufreq_cdev->max_level; i++) {
>  		unsigned long freq = freq_table[i].frequency * 1000;
> -		u32 freq_mhz = freq_table[i].frequency / 1000;
> -		u64 power;
> -		u32 voltage_mv;
>  
>  		/*
>  		 * Find ceil frequency as 'freq' may be slightly lower than OPP
> @@ -242,18 +237,9 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
>  			return -EINVAL;
>  		}
>  
> -		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
> -		dev_pm_opp_put(opp);
> -
> -		/*
> -		 * Do the multiplication with MHz and millivolt so as
> -		 * to not overflow.
> -		 */
> -		power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> -		do_div(power, 1000000000);
> -
>  		/* power is stored in mW */
> -		freq_table[i].power = power;
> +		freq_table[i].power = dev_pm_opp_get_power(opp) / 1000;
> +		dev_pm_opp_put(opp);
>  	}
>  
>  	return 0;
> @@ -606,7 +592,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>   */
>  static struct thermal_cooling_device *
>  __cpufreq_cooling_register(struct device_node *np,
> -			struct cpufreq_policy *policy, u32 capacitance)
> +			struct cpufreq_policy *policy, bool power_model)
>  {
>  	struct thermal_cooling_device *cdev;
>  	struct cpufreq_cooling_device *cpufreq_cdev;
> @@ -675,8 +661,8 @@ __cpufreq_cooling_register(struct device_node *np,
>  			pr_debug("%s: freq:%u KHz\n", __func__, freq);
>  	}
>  
> -	if (capacitance) {
> -		ret = update_freq_table(cpufreq_cdev, capacitance);
> +	if (power_model) {
> +		ret = update_freq_table(cpufreq_cdev);
>  		if (ret) {
>  			cdev = ERR_PTR(ret);
>  			goto remove_ida;
> @@ -760,7 +746,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
> -	u32 capacitance = 0;
> +	bool has_power;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -769,10 +755,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  	}
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		has_power = dev_pm_opp_has_power(get_cpu_device(policy->cpu));
>  
> -		cdev = __cpufreq_cooling_register(np, policy, capacitance);
> +		cdev = __cpufreq_cooling_register(np, policy, has_power);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
>  			       policy->cpu, PTR_ERR(cdev));

And this looks more or less fine to me.

-- 
viresh
