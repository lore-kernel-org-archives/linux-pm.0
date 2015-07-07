From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Iterate over all CPUs in clip_cpu
 mask to get frequency table
Date: Tue, 7 Jul 2015 08:52:20 +0100
Message-ID: <20150707075220.GA2817@e104805>
References: <1435723647-3354-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:46521 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751036AbbGGHxt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 03:53:49 -0400
Content-Disposition: inline
In-Reply-To: <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jul 01, 2015 at 05:13:14AM +0100, Pi-Cheng Chen wrote:
> Sorry for the mistake I made when cherry-picking the patch. Fix and resend
> again.
> 
> __cpufreq_cooling_register() might fail if some CPU other than first one in
> clip_cpu mask is present earlier e.g. CPU hotplug. Iterate all CPUs in the mask
> to handle this case.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>

Looks good to me.  FWIW,

Acked-by: Javi Merino <javi.merino@arm.com>

> ---
>  drivers/thermal/cpu_cooling.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6509c61..5e90eb6 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -776,9 +776,14 @@ __cpufreq_cooling_register(struct device_node *np,
>  	char dev_name[THERMAL_NAME_LENGTH];
>  	struct cpufreq_frequency_table *pos, *table;
>  	unsigned int freq, i, num_cpus;
> -	int ret;
> +	int ret, cpu;
> +
> +	for_each_cpu(cpu, clip_cpus) {
> +		table = cpufreq_frequency_get_table(cpu);
> +		if (table)
> +			break;
> +	}
>  
> -	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
>  	if (!table) {
>  		pr_debug("%s: CPUFreq table not found\n", __func__);
>  		return ERR_PTR(-EPROBE_DEFER);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
