From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Thu, 18 Apr 2019 09:23:23 +0530
Message-ID: <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417094301.17622-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On 17-04-19, 10:43, Quentin Perret wrote:
>  static struct thermal_cooling_device *
>  __cpufreq_cooling_register(struct device_node *np,
> -			struct cpufreq_policy *policy, u32 capacitance)
> +			struct cpufreq_policy *policy,
> +			struct em_perf_domain *em)
>  {

> +	if (em_is_sane(cpufreq_cdev, em)) {
> +		cpufreq_cdev->em = em;
>  		cooling_ops = &cpufreq_power_cooling_ops;
> -	} else {
> +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
>  		cooling_ops = &cpufreq_cooling_ops;
> +	} else {
> +		WARN(1, "cpu_cooling: no valid frequency table found\n");

Well the frequency table is valid, isn't it ? Maybe something like: "cpu_cooling
doesn't support unsorted frequency tables" ?

> +		cdev = ERR_PTR(-EINVAL);
> +		goto remove_ida;
>  	}
>  
>  	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
> @@ -691,7 +619,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	if (IS_ERR(cdev))
>  		goto remove_ida;
>  
> -	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
> +	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
>  	cpufreq_cdev->cdev = cdev;
>  
>  	mutex_lock(&cooling_list_lock);
> @@ -708,8 +636,6 @@ __cpufreq_cooling_register(struct device_node *np,
>  
>  remove_ida:
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> -free_table:
> -	kfree(cpufreq_cdev->freq_table);
>  free_idle_time:
>  	kfree(cpufreq_cdev->idle_time);
>  free_cdev:
> @@ -731,7 +657,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> -	return __cpufreq_cooling_register(NULL, policy, 0);
> +	return __cpufreq_cooling_register(NULL, policy, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
>  
> @@ -759,7 +685,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
> -	u32 capacitance = 0;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -768,10 +693,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  	}
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		struct em_perf_domain *em = em_cpu_get(policy->cpu);
>  
> -		cdev = __cpufreq_cooling_register(np, policy, capacitance);
> +		cdev = __cpufreq_cooling_register(np, policy, em);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
>  			       policy->cpu, PTR_ERR(cdev));
> @@ -813,7 +737,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  	kfree(cpufreq_cdev->idle_time);
> -	kfree(cpufreq_cdev->freq_table);
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> -- 
> 2.21.0

-- 
viresh
