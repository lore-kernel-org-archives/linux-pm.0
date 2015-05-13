From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH RFC v2 4/4] sched: cpufreq_cfs: pelt-based cpu frequency
 scaling
Date: Wed, 13 May 2015 11:19:23 +0200
Message-ID: <1431508763.2398.169.camel@x220>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
	 <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:48392 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753145AbbEMJTk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 05:19:40 -0400
In-Reply-To: <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, abelvesa@gmail.com

One nit and one question follow.

>--- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig

> +config CPU_FREQ_DEFAULT_GOV_CFS
> +	bool "cfs"
> +	select CPU_FREQ_GOV_CFS
> +	select CPU_FREQ_GOV_PERFORMANCE
> +	help
> +	  Use the CPUfreq governor 'cfs' as default. This scales
> +	  cpu frequency from the scheduler as per-entity load tracking
> +	  statistics are updated.

> +config CPU_FREQ_GOV_CFS
> +	tristate "'cfs' cpufreq governor"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_GOV_COMMON
> +	help
> +	  'cfs' - this governor scales cpu frequency from the
> +	  scheduler as a function of cpu capacity utilization. It does
> +	  not evaluate utilization on a periodic basis (as ondemand
> +	  does) but instead is invoked from the completely fair
> +	  scheduler when updating per-entity load tracking statistics.
> +	  Latency to respond to changes in load is improved over polling
> +	  governors due to its event-driven design.
> +
> +	  If in doubt, say N.

> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -485,6 +485,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand;
>  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
>  extern struct cpufreq_governor cpufreq_gov_conservative;
>  #define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CAP_GOV)
> +extern struct cpufreq_governor cpufreq_gov_cap_gov;
> +#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_cap_gov)
>  #endif

Question: grepping for CPU_FREQ_DEFAULT_GOV_CAP_GOV and
cpufreq_gov_cap_gov didn't gave me hits in next-20150513. And this
series doesn't add them, does it? So where do they com from?

(Since you add CPU_FREQ_DEFAULT_GOV_CFS and cpufreq_cfs in this patch it
seems you intended to add those. I briefly looked into the way
CPUFREQ_DEFAULT_GOVERNOR is set in cpufreq.h when v1 came along, found
it to complicated for me, and promptly forgot the details, so please
double check.)
 
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile

> +obj-$(CONFIG_CPU_FREQ_GOV_CFS) += cpufreq_cfs.o

> --- /dev/null
> +++ b/kernel/sched/cpufreq_cfs.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think that either the comment at the top of this file
or the ident used in the MODULE_LICENSE() macro needs to be changed.

Thanks,


Paul Bolle

