From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 04/14] cpufreq: stats: pass 'stat' to cpufreq_stats_update()
Date: Sat, 03 Jan 2015 23:04:52 +0100
Message-ID: <3547984.Vd8ZHeRe7a@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <aec0c2c88ed01f32e2b5ea60c21f194b8049ef0f.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58984 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752495AbbACVmk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 16:42:40 -0500
In-Reply-To: <aec0c2c88ed01f32e2b5ea60c21f194b8049ef0f.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:41 AM Viresh Kumar wrote:
> cpufreq_stats_update() needs only 'stat' pointer for its use and nothing else.
> Currently it works fine as we have a per-cpu variable for storing stats. But
> later commits would remove it and hence we better pass 'stat' to
> cpufreq_stats_update().

What about:

"It is better to pass a struct cpufreq_stats pointer to cpufreq_stats_update()
 instead of a CPU number, because ..."

?

> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 62b6133f06aa..ebd9e4c5c124 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -38,14 +38,11 @@ struct cpufreq_stats_attribute {
>  	ssize_t(*show) (struct cpufreq_stats *, char *);
>  };
>  
> -static int cpufreq_stats_update(unsigned int cpu)
> +static int cpufreq_stats_update(struct cpufreq_stats *stat)
>  {
> -	struct cpufreq_stats *stat;
> -	unsigned long long cur_time;
> +	unsigned long long cur_time = get_jiffies_64();
>  
> -	cur_time = get_jiffies_64();

Unrelated change.

>  	spin_lock(&cpufreq_stats_lock);
> -	stat = per_cpu(cpufreq_stats_table, cpu);
>  	if (stat->time_in_state)
>  		stat->time_in_state[stat->last_index] +=
>  			cur_time - stat->last_time;
> @@ -70,7 +67,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
>  	if (!stat)
>  		return 0;
> -	cpufreq_stats_update(stat->cpu);
> +	cpufreq_stats_update(stat);
>  	for (i = 0; i < stat->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
>  			(unsigned long long)
> @@ -88,7 +85,7 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
>  	if (!stat)
>  		return 0;
> -	cpufreq_stats_update(stat->cpu);
> +	cpufreq_stats_update(stat);
>  	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
>  	for (i = 0; i < stat->state_num; i++) {
> @@ -313,7 +310,7 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
>  	if (old_index == -1 || new_index == -1)
>  		return 0;
>  
> -	cpufreq_stats_update(freq->cpu);
> +	cpufreq_stats_update(stat);
>  
>  	if (old_index == new_index)
>  		return 0;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
