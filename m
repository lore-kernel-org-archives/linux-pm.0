From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state variable
Date: Fri, 24 Jul 2015 16:26:12 +0100
Message-ID: <9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:44796 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753256AbbGXPZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 11:25:03 -0400
In-Reply-To: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
	(Radivoje Jovanovic's message of "Tue, 21 Jul 2015 15:13:55 -0700")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> writes:

> From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
>
> there is no need to keep local state variable. if another driver
> changes the policy under our feet the cpu_cooling driver will
> have the wrong state. Get current state from the policy directly instead
>

Although the patch below looks good, it does add additional
processing. I was wondering in what situation do you observe the
problem $SUBJECT solves?

Presumably, the policy caps are tighter than those imposed by the cpu
cooling device (cpufreq_thermal_notifier should take care of this).

> Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> ---
>  drivers/thermal/cpu_cooling.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6509c61..94ba2da 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -66,8 +66,6 @@ struct power_table {
>   *	registered.
>   * @cool_dev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
> - * @cpufreq_state: integer value representing the current state of cpufreq
> - *	cooling	devices.
>   * @cpufreq_val: integer value representing the absolute value of the clipped
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
> @@ -90,7 +88,6 @@ struct power_table {
>  struct cpufreq_cooling_device {
>  	int id;
>  	struct thermal_cooling_device *cool_dev;
> -	unsigned int cpufreq_state;
>  	unsigned int cpufreq_val;
>  	unsigned int max_level;
>  	unsigned int *freq_table;	/* In descending order */
> @@ -486,10 +483,19 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>  				 unsigned long *state)
>  {
>  	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
> -
> -	*state = cpufreq_device->cpufreq_state;
> -
> -	return 0;
> +	struct cpufreq_policy policy;
> +	struct cpumask *mask = &cpufreq_device->allowed_cpus;
> +	unsigned int cpu = cpumask_any(mask);
> +	unsigned int cur_state;
> +
> +	if (!cpufreq_get_policy(&policy, cpu)) {
> +			cur_state = get_level(cpufreq_device, policy.max);
> +			if (cur_state != THERMAL_CSTATE_INVALID) {
> +				*state = cur_state;
> +				return 0;
> +			}
> +	}
> +	return -EINVAL;
>  }
>  
>  /**
> @@ -508,17 +514,20 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
>  	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
>  	unsigned int clip_freq;
> +	unsigned long cur_state;
>  
>  	/* Request state should be less than max_level */
>  	if (WARN_ON(state > cpufreq_device->max_level))
>  		return -EINVAL;
>  
> +	if (cpufreq_get_cur_state(cpufreq_device->cool_dev, &cur_state))
> +		return -EINVAL;
> +
>  	/* Check if the old cooling action is same as new cooling action */
> -	if (cpufreq_device->cpufreq_state == state)
> +	if (cur_state == state)
>  		return 0;
>  
>  	clip_freq = cpufreq_device->freq_table[state];
> -	cpufreq_device->cpufreq_state = state;
>  	cpufreq_device->cpufreq_val = clip_freq;
>  
>  	cpufreq_update_policy(cpu);
