From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Iterate over all CPUs in clip_cpu
 mask to get frequency table
Date: Tue, 7 Jul 2015 15:57:44 +0530
Message-ID: <20150707102744.GK14598@linux>
References: <1435723647-3354-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35462 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbbGGK1t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 06:27:49 -0400
Received: by pdbci14 with SMTP id ci14so123549302pdb.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 03:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 01-07-15, 12:13, Pi-Cheng Chen wrote:
> Sorry for the mistake I made when cherry-picking the patch. Fix and resend
> again.

You really want above to show up in git logs ?

Any comments like this should be present:
- in cover-letter
- OR after the three dashes below ---
- OR must be followed with a scissors line, like this:
  --------------8<--------

> __cpufreq_cooling_register() might fail if some CPU other than first one in
> clip_cpu mask is present earlier e.g. CPU hotplug. Iterate all CPUs in the mask
> to handle this case.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
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

Nah, that's wrong. I hope that's a hypothetical problem and not a real
one. Would have been better if cpufreq maintainers were cc'd as they
can provide more insight into this :)

cpufreq_frequency_get_table() does: policy->freq_table and so it
doesn't matter if the cpu is online or not.

cpufreq_cpu_data was getting unset earlier on hotplug, but that's not
the case anymore. So nothing to worry about :)

-- 
viresh
