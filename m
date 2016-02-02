From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Mon, 1 Feb 2016 18:34:18 -0800
Message-ID: <20160202023418.GK4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <d59a1d27c9e2f4cc023dfc9a2b72cb920cbac43a.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d59a1d27c9e2f4cc023dfc9a2b72cb920cbac43a.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/28, Viresh Kumar wrote:
> @@ -119,6 +120,49 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return ret;
>  }
>  
> +/*
> + * An earlier version of opp-v1 bindings used to name the regulator
> + * "cpu0-supply", we still need to handle that for backwards compatibility.
> + */
> +static const char *find_supply_name(struct device *dev)
> +{
> +	struct regulator *cpu_reg;
> +	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
> +	int cpu = dev->id, ret;
> +
> +	/* Try "cpu0" for older DTs */
> +	if (!cpu)
> +		reg = reg_cpu0;
> +	else
> +		reg = reg_cpu;
> +
> +try_again:
> +	cpu_reg = regulator_get_optional(dev, reg);
> +	ret = PTR_ERR_OR_ZERO(cpu_reg);
> +	if (!ret) {
> +		regulator_put(cpu_reg);

What's the point of creating a regulator just to find the name?
It seems like we should just look in the DT node of the CPU for
cpu-supply vs cpu0-supply. Then we don't need to involve the
regulator framework at all.

> +		return reg;
> +	}
> +
> +	/*
> +	 * If cpu's regulator supply node is present, but regulator is not yet
> +	 * registered, we should try defering probe.
> +	 */
> +	if (ret == -EPROBE_DEFER) {
> +		dev_dbg(dev, "cpu%d regulator not ready, retry\n", cpu);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Try with "cpu-supply" */
> +	if (reg == reg_cpu0) {
> +		reg = reg_cpu;
> +		goto try_again;
> +	}
> +
> +	dev_dbg(dev, "no regulator for cpu%d: %d\n", cpu, ret);
> +	return NULL;
> +}
> +
>  static int allocate_resources(int cpu, struct device **cdev,
>  			      struct regulator **creg, struct clk **cclk)
>  {
> @@ -383,6 +450,9 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> +	if (priv->reg_name)
> +		dev_pm_opp_put_regulator(priv->cpu_dev);

Let's hope this goes away because it's always right next to
dev_pm_opp_of_cpumask_remove_table() anyway. Same for reg_name.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
