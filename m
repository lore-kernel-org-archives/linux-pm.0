From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Wed, 03 Feb 2016 16:59:38 -0800
Message-ID: <56B2A27A.5030303@codeaurora.org>
References: <3705929.bslqXH980s@vostro.rjw.lan> <1529283.0IedZktI9q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36200 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbcBDA7k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 19:59:40 -0500
In-Reply-To: <1529283.0IedZktI9q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>

On 02/03/2016 03:16 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Every governor relying on the common code in cpufreq_governor.c
> has to provide its own mutex in struct common_dbs_data.  However,
> those mutexes are never used at the same time and doing it this
> way makes it rather difficult to follow the code.  Moreover,
> if two governor modules are loaded we end up with two mutexes
> used for the same purpose one at a time.
>
> Introduce a single common mutex for that instead and drop the
> mutex field from struct common_dbs_data.  That at least will
> ensure that the mutex is always present and initialized regardless
> of what the particular governors do.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c |    1 -
>   drivers/cpufreq/cpufreq_governor.c     |    7 +++++--
>   drivers/cpufreq/cpufreq_governor.h     |    6 +-----
>   drivers/cpufreq/cpufreq_ondemand.c     |    5 ++---
>   4 files changed, 8 insertions(+), 11 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,9 @@
>
>   #include "cpufreq_governor.h"
>
> +DEFINE_MUTEX(dbs_data_mutex);
> +EXPORT_SYMBOL_GPL(dbs_data_mutex);
> +
>   static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
>   {
>   	if (have_governor_per_policy())
> @@ -542,7 +545,7 @@ int cpufreq_governor_dbs(struct cpufreq_
>   	int ret;
>
>   	/* Lock governor to block concurrent initialization of governor */
> -	mutex_lock(&cdata->mutex);
> +	mutex_lock(&dbs_data_mutex);
>
>   	if (have_governor_per_policy())
>   		dbs_data = policy->governor_data;
> @@ -575,7 +578,7 @@ int cpufreq_governor_dbs(struct cpufreq_
>   	}
>
>   unlock:
> -	mutex_unlock(&cdata->mutex);
> +	mutex_unlock(&dbs_data_mutex);
>
>   	return ret;
>   }
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -223,11 +223,6 @@ struct common_dbs_data {
>
>   	/* Governor specific ops, see below */
>   	void *gov_ops;
> -
> -	/*
> -	 * Protects governor's data (struct dbs_data and struct common_dbs_data)
> -	 */
> -	struct mutex mutex;
>   };
>
>   /* Governor Per policy data */
> @@ -272,6 +267,7 @@ static ssize_t show_sampling_rate_min_go
>   	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
>   }
>
> +extern struct mutex dbs_data_mutex;
>   extern struct mutex cpufreq_governor_lock;
>   void gov_set_update_util(struct cpu_common_dbs_info *shared,
>   			 unsigned int delay_us);
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -251,7 +251,7 @@ static void update_sampling_rate(struct
>   	/*
>   	 * Lock governor so that governor start/stop can't execute in parallel.
>   	 */
> -	mutex_lock(&od_dbs_cdata.mutex);
> +	mutex_lock(&dbs_data_mutex);
>
>   	cpumask_copy(&cpumask, cpu_online_mask);
>
> @@ -304,7 +304,7 @@ static void update_sampling_rate(struct
>   		}
>   	}
>
> -	mutex_unlock(&od_dbs_cdata.mutex);
> +	mutex_unlock(&dbs_data_mutex);
>   }
>
>   static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
> @@ -550,7 +550,6 @@ static struct common_dbs_data od_dbs_cda
>   	.gov_ops = &od_ops,
>   	.init = od_init,
>   	.exit = od_exit,
> -	.mutex = __MUTEX_INITIALIZER(od_dbs_cdata.mutex),
>   };
>
>   static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> @@ -368,7 +368,6 @@ static struct common_dbs_data cs_dbs_cda
>   	.gov_check_cpu = cs_check_cpu,
>   	.init = cs_init,
>   	.exit = cs_exit,
> -	.mutex = __MUTEX_INITIALIZER(cs_dbs_cdata.mutex),
>   };
>
>   static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Acked-by: Saravana Kannan <skannan@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
