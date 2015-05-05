From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 6/6] cpufreq: powernv: Restore cpu frequency to policy->cur
 on unthrottling
Date: Tue, 05 May 2015 15:09:57 +0530
Message-ID: <55488FED.4080909@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1430729652-14813-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60226 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254AbbEEJkF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 05:40:05 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 5 May 2015 03:40:05 -0600
In-Reply-To: <1430729652-14813-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
> If frequency is throttled due to OCC reset then cpus will be in Psafe
> frequency, so restore the frequency on all cpus to policy->cur when
> OCCs are active again. And if frequency is throttled due to Pmax
> capping then restore the frequency of all the cpus  in the chip on
> unthrottling.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 0a59d5b..b2915bc 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -51,6 +51,7 @@ static struct chip {
>  	bool throttled;
>  	cpumask_t mask;
>  	struct work_struct throttle;
> +	bool restore;
>  } *chips;
> 
>  static int nr_chips;
> @@ -418,9 +419,29 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> +	unsigned int cpu;
> +	cpumask_var_t mask;
> 
>  	smp_call_function_any(&chip->mask,
>  			      powernv_cpufreq_throttle_check, NULL, 0);
> +
> +	if (!chip->restore)
> +		return;
> +
> +	chip->restore = false;
> +	cpumask_copy(mask, &chip->mask);
> +	for_each_cpu_and(cpu, mask, cpu_online_mask) {
> +		int index, tcpu;
> +		struct cpufreq_policy policy;
> +
> +		cpufreq_get_policy(&policy, cpu);
> +		cpufreq_frequency_table_target(&policy, policy.freq_table,
> +					       policy.cur,
> +					       CPUFREQ_RELATION_C, &index);
> +		powernv_cpufreq_target_index(&policy, index);
> +		for_each_cpu(tcpu, policy.cpus)
> +			cpumask_clear_cpu(tcpu, mask);
> +	}
>  }
> 
>  static char throttle_reason[][30] = {
> @@ -473,8 +494,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  			throttled = false;
>  			pr_info("OCC: Active\n");
> 
> -			for (i = 0; i < nr_chips; i++)
> +			for (i = 0; i < nr_chips; i++) {
> +				chips[i].restore = true;
>  				schedule_work(&chips[i].throttle);
> +			}
> 
>  			return 0;
>  		}
> @@ -490,8 +513,11 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  			return 0;
> 
>  		for (i = 0; i < nr_chips; i++)
> -			if (chips[i].id == chip_id)
> +			if (chips[i].id == chip_id) {
> +				if (!reason)
> +					chips[i].restore = true;
>  				schedule_work(&chips[i].throttle);
> +			}
>  	}
>  	return 0;
>  }
> @@ -545,6 +571,7 @@ static int init_chip_info(void)
>  		chips[i].throttled = false;
>  		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
>  		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
> +		chips[i].restore = false;
>  	}
> 
>  	return 0;
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

