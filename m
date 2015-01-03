From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 05/14] cpufreq: stats: get rid of per-cpu cpufreq_stats_table
Date: Sat, 03 Jan 2015 23:20:07 +0100
Message-ID: <2035066.1nOVW1Pe1d@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <b7d24dcbe2aecf8627d5fbe0666ec88b8d8076d3.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63304 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751395AbbACV5y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 16:57:54 -0500
In-Reply-To: <b7d24dcbe2aecf8627d5fbe0666ec88b8d8076d3.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:42 AM Viresh Kumar wrote:
> Because all CPUs in a policy share clock line, they share stats as well.

"All CPUs sharing a cpufreq policy share stats too."

Sharing a clock line is irrelevant here.

> But cpufreq-stats maintains a per-cpu list of tables for managing this. Get rid of
> it by assigning a special field for stats in 'struct cpufreq_policy'.

"For this reason, add a stats pointer to struct cpufreq_policy and drop
 per-CPU variable cpufreq_stats_table used for accessing cpufreq stats
 so as to reduce code complexity."

> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 51 ++++++++++++++++++-----------------------
>  include/linux/cpufreq.h         |  3 +++
>  2 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index ebd9e4c5c124..106c89ccef30 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -31,8 +31,6 @@ struct cpufreq_stats {
>  #endif
>  };
>  
> -static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
> -
>  struct cpufreq_stats_attribute {
>  	struct attribute attr;
>  	ssize_t(*show) (struct cpufreq_stats *, char *);
> @@ -53,20 +51,17 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
>  
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>  {
> -	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
> -	if (!stat)
> -		return 0;
> -	return sprintf(buf, "%d\n",
> -			per_cpu(cpufreq_stats_table, stat->cpu)->total_trans);
> +	struct cpufreq_stats *stat = policy->stats_data;
> +
> +	return sprintf(buf, "%d\n", stat->total_trans);

First off, why do you call the new field stats_data instead of stats?
Moreover:

+	return sprintf(buf, "%d\n", policy->stats->total_trans);

and then you don't need the extra line above.

>  }
>  
>  static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  {
> +	struct cpufreq_stats *stat = policy->stats_data;
>  	ssize_t len = 0;
>  	int i;
> -	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
> -	if (!stat)
> -		return 0;
> +
>  	cpufreq_stats_update(stat);
>  	for (i = 0; i < stat->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
> @@ -79,12 +74,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
> +	struct cpufreq_stats *stat = policy->stats_data;
>  	ssize_t len = 0;
>  	int i, j;
>  
> -	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
> -	if (!stat)
> -		return 0;
>  	cpufreq_stats_update(stat);
>  	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
> @@ -150,8 +143,9 @@ static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
>  
>  static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
> +	struct cpufreq_stats *stat = policy->stats_data;
>  
> +	/* Already freed */
>  	if (!stat)
>  		return;
>  
> @@ -160,7 +154,7 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
>  	sysfs_remove_group(&policy->kobj, &stats_attr_group);
>  	kfree(stat->time_in_state);
>  	kfree(stat);
> -	per_cpu(cpufreq_stats_table, policy->cpu) = NULL;
> +	policy->stats_data = NULL;
>  }
>  
>  static void cpufreq_stats_free_table(unsigned int cpu)
> @@ -189,7 +183,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  		return 0;
>  
>  	/* stats already initialized */
> -	if (per_cpu(cpufreq_stats_table, cpu))
> +	if (policy->stats_data)
>  		return -EEXIST;
>  
>  	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
> @@ -201,7 +195,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  		goto error_out;
>  
>  	stat->cpu = cpu;
> -	per_cpu(cpufreq_stats_table, cpu) = stat;
> +	policy->stats_data = stat;
>  
>  	cpufreq_for_each_valid_entry(pos, table)
>  		count++;
> @@ -236,7 +230,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	sysfs_remove_group(&policy->kobj, &stats_attr_group);
>  error_out:
>  	kfree(stat);
> -	per_cpu(cpufreq_stats_table, cpu) = NULL;
> +	policy->stats_data = NULL;
>  	return ret;
>  }
>  
> @@ -259,14 +253,8 @@ static void cpufreq_stats_create_table(unsigned int cpu)
>  
>  static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table,
> -			policy->last_cpu);
> -
> -	pr_debug("Updating stats_table for new_cpu %u from last_cpu %u\n",
> -			policy->cpu, policy->last_cpu);
> -	per_cpu(cpufreq_stats_table, policy->cpu) = per_cpu(cpufreq_stats_table,
> -			policy->last_cpu);
> -	per_cpu(cpufreq_stats_table, policy->last_cpu) = NULL;
> +	struct cpufreq_stats *stat = policy->stats_data;
> +
>  	stat->cpu = policy->cpu;

Why don't you change this line to

	policy->stats->cpu = policy->cpu;

and then you don't need the extra variable any more?

>  }
>  
> @@ -293,15 +281,19 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
>  		unsigned long val, void *data)
>  {
>  	struct cpufreq_freqs *freq = data;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
>  	struct cpufreq_stats *stat;
>  	int old_index, new_index;
>  
>  	if (val != CPUFREQ_POSTCHANGE)
>  		return 0;
>  
> -	stat = per_cpu(cpufreq_stats_table, freq->cpu);
> -	if (!stat)
> -		return 0;
> +	if (!policy) {
> +		pr_err("%s: No policy found\n", __func__);

Do we need the extra message here?  If so, can it be pr_debug()?

> +		return -ENODEV;
> +	}

This changes the behavior in a subtle way.  Instead of returning 0 when stats
are not present, we'll now return an error code for a missing policy.  Are you
sure that this isn't going to break anything?

> +
> +	stat = policy->stats_data;

Is stat guaraneed to be a valid pointer at this point?

>  
>  	old_index = stat->last_index;
>  	new_index = freq_table_get_index(stat, freq->new);
> @@ -322,6 +314,7 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
>  #endif
>  	stat->total_trans++;
>  	spin_unlock(&cpufreq_stats_lock);
> +	cpufreq_cpu_put(policy);
>  	return 0;
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4d078cebafd2..3cb097b86d20 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -113,6 +113,9 @@ struct cpufreq_policy {
>  	wait_queue_head_t	transition_wait;
>  	struct task_struct	*transition_task; /* Task which is doing the transition */
>  
> +	/* cpufreq-stats data */
> +	void			*stats_data;

Why isn't that

	struct cpufreq_stats	*stats;

?

> +
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
>  };
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
