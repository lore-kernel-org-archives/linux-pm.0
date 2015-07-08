From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] cpufreq: Add ->get_rate() driver callback
Date: Thu, 09 Jul 2015 01:41:10 +0200
Message-ID: <1879392.TC0RceaKlH@vostro.rjw.lan>
References: <fb44111fa7a762924661ad48a70985d597229bc4.1436351759.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58367 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751676AbbGHXOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 19:14:42 -0400
In-Reply-To: <fb44111fa7a762924661ad48a70985d597229bc4.1436351759.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Wednesday, July 08, 2015 04:07:32 PM Viresh Kumar wrote:
> CPUFreq drivers today support a ->get(cpu) callback, which returns
> current rate of a CPU. The problem with ->get() is that it takes a cpu
> number as parameter and this unnecessarily makes things complex.
> 
> Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> the policy and then many drivers need to get the policy back and so do
> cpufreq_cpu_get(cpu) on the passed cpu.
> 
> As cpufreq core works on policies, it would be better if we pass them
> 'policy' directly and drivers can use policy->cpu if that's all they
> need.
> 
> Hence, this patch adds in another callback, ->get_rate() which does
> exactly the same work as ->get(), just that we pass 'policy' as
> parameter instead of 'cpu'.
> 
> The plan is to migrate all drivers to this new callback and remove
> ->get() after that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> I hope you are fine with this stuff :), once you approve I will get
> other patches to migrate existing drivers to this interface.

I'm generally fine with it, but please target it at 4.4 at the earliest.


>  drivers/cpufreq/cpufreq.c | 50 ++++++++++++++++++++++++++++++++---------------
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..b66e169601e8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -154,6 +154,20 @@ void disable_cpufreq(void)
>  }
>  static DEFINE_MUTEX(cpufreq_governor_mutex);
>  
> +/* Operations for ->get() and ->get_rate() operations */
> +static inline bool driver_supports_get_rate(void)
> +{
> +	return cpufreq_driver->get || cpufreq_driver->get_rate;
> +}
> +
> +static inline unsigned int policy_get_rate(struct cpufreq_policy *policy)
> +{
> +	if (cpufreq_driver->get)
> +		return cpufreq_driver->get(policy->cpu);
> +	else
> +		return cpufreq_driver->get_rate(policy);
> +}
> +
>  bool have_governor_per_policy(void)
>  {
>  	return !!(cpufreq_driver->flags & CPUFREQ_HAVE_GOVERNOR_PER_POLICY);
> @@ -596,8 +610,9 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  {
>  	ssize_t ret;
>  
> -	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
> -		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> +	if (cpufreq_driver && cpufreq_driver->setpolicy &&
> +	    driver_supports_get_rate())
> +		ret = sprintf(buf, "%u\n", policy_get_rate(policy));
>  	else
>  		ret = sprintf(buf, "%u\n", policy->cur);
>  	return ret;
> @@ -1032,7 +1047,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>  			return ret;
>  		drv_attr++;
>  	}
> -	if (cpufreq_driver->get) {
> +	if (driver_supports_get_rate()) {
>  		ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
>  		if (ret)
>  			return ret;
> @@ -1313,10 +1328,10 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  	}
>  
> -	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> -		policy->cur = cpufreq_driver->get(policy->cpu);
> +	if (driver_supports_get_rate() && !cpufreq_driver->setpolicy) {
> +		policy->cur = policy_get_rate(policy);
>  		if (!policy->cur) {
> -			pr_err("%s: ->get() failed\n", __func__);
> +			pr_err("%s: ->get_rate() failed\n", __func__);
>  			goto err_get_freq;
>  		}
>  	}
> @@ -1594,14 +1609,17 @@ unsigned int cpufreq_quick_get(unsigned int cpu)
>  	struct cpufreq_policy *policy;
>  	unsigned int ret_freq = 0;
>  
> -	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
> -		return cpufreq_driver->get(cpu);
> -
>  	policy = cpufreq_cpu_get(cpu);
> -	if (policy) {
> +	if (!policy)
> +		return 0;
> +
> +	if (cpufreq_driver && cpufreq_driver->setpolicy &&
> +	    driver_supports_get_rate())
> +		ret_freq = policy_get_rate(policy);
> +	else
>  		ret_freq = policy->cur;
> -		cpufreq_cpu_put(policy);
> -	}
> +
> +	cpufreq_cpu_put(policy);
>  
>  	return ret_freq;
>  }
> @@ -1631,10 +1649,10 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  {
>  	unsigned int ret_freq = 0;
>  
> -	if (!cpufreq_driver->get)
> +	if (!driver_supports_get_rate())
>  		return ret_freq;
>  
> -	ret_freq = cpufreq_driver->get(policy->cpu);
> +	ret_freq = policy_get_rate(policy);
>  
>  	/* Updating inactive policies is invalid, so avoid doing that. */
>  	if (unlikely(policy_is_inactive(policy)))
> @@ -2345,8 +2363,8 @@ int cpufreq_update_policy(unsigned int cpu)
>  	 * BIOS might change freq behind our back
>  	 * -> ask driver for current freq and notify governors about a change
>  	 */
> -	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> -		new_policy.cur = cpufreq_driver->get(cpu);
> +	if (driver_supports_get_rate() && !cpufreq_driver->setpolicy) {
> +		new_policy.cur = policy_get_rate(policy);
>  		if (WARN_ON(!new_policy.cur)) {
>  			ret = -EIO;
>  			goto unlock;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 29ad97c34fd5..a82049683016 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -263,6 +263,7 @@ struct cpufreq_driver {
>  
>  	/* should be defined, if possible */
>  	unsigned int	(*get)(unsigned int cpu);
> +	unsigned int	(*get_rate)(struct cpufreq_policy *policy);
>  
>  	/* optional */
>  	int		(*bios_limit)(int cpu, unsigned int *limit);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
