From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 14/14] cpufreq: stats: call cpufreq_stats_update() with locks held
Date: Sat, 03 Jan 2015 23:48:50 +0100
Message-ID: <1700931.l12V7stM3U@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <98184387b402a80ba58e9b727c4dacd95abdd8d4.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49731 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750735AbbACW0i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 17:26:38 -0500
In-Reply-To: <98184387b402a80ba58e9b727c4dacd95abdd8d4.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:51 AM Viresh Kumar wrote:
> cpufreq_stats_update() has only two callers, one of them is already taking locks
> and other one don't.

"and the other one doesn't."

> To make locking efficient for cpufreq_stat_notifier_trans(), lets call
> cpufreq_stats_update() from within locks. Also update show_time_in_state() to
> call cpufreq_stats_update() after taking locks.

"It doesn't make much sense to drop the lock in cpufreq_stats_update() and
 re-acquire it immediately after that in cpufreq_stat_notifier_trans(), so
 make callers of cpufreq_stats_update() responsible for acquiring the lock
 around it as appropriate and modify cpufreq_stat_notifier_trans() to call
 it under the lock it already uses."

> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 95867985ea02..f1b234a09f66 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -40,12 +40,10 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
>  {
>  	unsigned long long cur_time = get_jiffies_64();
>  
> -	mutex_lock(&cpufreq_stats_lock);
>  	if (stat->time_in_state)
>  		stat->time_in_state[stat->last_index] +=
>  			cur_time - stat->last_time;
>  	stat->last_time = cur_time;
> -	mutex_unlock(&cpufreq_stats_lock);
>  	return 0;
>  }
>  
> @@ -62,7 +60,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	ssize_t len = 0;
>  	int i;
>  
> +	mutex_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stat);
> +	mutex_unlock(&cpufreq_stats_lock);
> +
>  	for (i = 0; i < stat->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
>  			(unsigned long long)
> @@ -303,9 +304,9 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
>  	if (old_index == new_index)
>  		return 0;
>  
> +	mutex_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stat);
>  
> -	mutex_lock(&cpufreq_stats_lock);
>  	stat->last_index = new_index;
>  #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	stat->trans_table[old_index * stat->max_state + new_index]++;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
