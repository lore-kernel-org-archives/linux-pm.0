From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 13/14] cpufreq: stats: Fix locking
Date: Sat, 03 Jan 2015 23:43:25 +0100
Message-ID: <2107105.bVfAua7dNn@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <0447fedc2d07cd35eed66d7de97ad4e0940b6110.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56664 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750735AbbACWVM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 17:21:12 -0500
In-Reply-To: <0447fedc2d07cd35eed66d7de97ad4e0940b6110.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:50 AM Viresh Kumar wrote:
> Locking wasn't handled properly at places and this patch is an attempt to fix
> it. Specially while creating/removing stat tables.

This is pants, sorry.

Whenever you change locking, you need to know exactly (a) what is wrong with
the way it is currently done and (b) how you are going to improve it.  All of
that needs to be described here.

For example, you seem to be thinking that locking is missing from
__cpufreq_stats_free_table(), so you are adding it in there.  Thus you need to
describe (a) why it is missing (eg. what races are possible because of that)
and (b) why adding it the way you do is going to improve the situation.

> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index de55ca86b6f1..95867985ea02 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -150,10 +150,12 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s: Free stat table\n", __func__);
>  
> +	mutex_lock(&cpufreq_stats_lock);
>  	sysfs_remove_group(&policy->kobj, &stats_attr_group);
>  	kfree(stat->time_in_state);
>  	kfree(stat);
>  	policy->stats_data = NULL;
> +	mutex_unlock(&cpufreq_stats_lock);
>  }
>  
>  static void cpufreq_stats_free_table(unsigned int cpu)
> @@ -182,13 +184,17 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	if (unlikely(!table))
>  		return 0;
>  
> +	mutex_lock(&cpufreq_stats_lock);
> +
>  	/* stats already initialized */
> -	if (policy->stats_data)
> -		return -EEXIST;
> +	if (policy->stats_data) {
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
>  
>  	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
>  	if (!stat)
> -		return -ENOMEM;
> +		goto unlock;
>  
>  	/* Find total allocation size */
>  	cpufreq_for_each_valid_entry(pos, table)
> @@ -219,21 +225,21 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  			stat->freq_table[i++] = pos->frequency;
>  	stat->state_num = i;
>  
> -	mutex_lock(&cpufreq_stats_lock);
>  	stat->last_time = get_jiffies_64();
>  	stat->last_index = freq_table_get_index(stat, policy->cur);
> -	mutex_unlock(&cpufreq_stats_lock);
>  
>  	policy->stats_data = stat;
>  	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
>  	if (!ret)
> -		return 0;
> +		goto unlock;
>  
>  	/* We failed, release resources */
>  	policy->stats_data = NULL;
>  	kfree(stat->time_in_state);
>  free_stat:
>  	kfree(stat);
> +unlock:
> +	mutex_unlock(&cpufreq_stats_lock);
>  
>  	return ret;
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
