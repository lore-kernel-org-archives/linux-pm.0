From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Drop unnecessary arguments from two functions
Date: Wed, 22 Jul 2015 12:16:48 +0530
Message-ID: <20150722064648.GA30970@linux>
References: <1710735.NHMxY7dJsV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1710735.NHMxY7dJsV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22-07-15, 04:09, Rafael J. Wysocki wrote:
>  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  {
>  	unsigned int cpu = dev->id;
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  	int ret;
>  
>  	/*
> @@ -1530,7 +1525,6 @@ static int cpufreq_remove_dev(struct dev
>  	 * link or free policy here.
>  	 */
>  	if (cpu_is_offline(cpu)) {
> -		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  		struct cpumask mask;
>  
>  		if (!policy)
> @@ -1547,17 +1541,18 @@ static int cpufreq_remove_dev(struct dev
>  			remove_cpu_dev_symlink(policy, cpu);
>  			return 0;
>  		}
> +	} else {
> +		ret = __cpufreq_remove_dev_prepare(dev);
> +		if (!ret)
> +			ret = __cpufreq_remove_dev_finish(dev);
>  
> -		cpufreq_policy_free(policy, true);
> -		return 0;
> +		/* The CPU is online, so the policy cannot be inactive here. */
> +		if (ret)
> +			return ret;
>  	}
>  
> -	ret = __cpufreq_remove_dev_prepare(dev, sif);
> -
> -	if (!ret)
> -		ret = __cpufreq_remove_dev_finish(dev, sif);
> -
> -	return ret;
> +	cpufreq_policy_free(policy, true);

You need to check for policy_is_inactive(policy) before freeing
policy. cpufreq_remove_dev() will be called one by one for all CPUs of
a policy ..

-- 
viresh
