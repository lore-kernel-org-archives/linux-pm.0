From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: stats: Fix concurrency issues while
 resetting stats
Date: Mon, 4 Feb 2019 14:31:31 -0800
Message-ID: <20190204223131.GF117604@google.com>
References: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
 <927dcc1de6acad3dd2cfae4e300e6fee4f665101.1549001732.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <927dcc1de6acad3dd2cfae4e300e6fee4f665101.1549001732.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 11:45:45AM +0530, Viresh Kumar wrote:
> It is possible for cpufreq_stats_clear_table() and
> cpufreq_stats_record_transition() to get called concurrently and they
> will try to update same variables simultaneously and may lead to
> corruption of data.
> 
> Prevent that with the help of existing spinlock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 941e63e3e652..e2db5581489a 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -31,20 +31,20 @@ static void cpufreq_stats_update(struct cpufreq_stats *stats)
>  {
>  	unsigned long long cur_time = get_jiffies_64();
>  
> -	spin_lock(&cpufreq_stats_lock);
>  	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
>  	stats->last_time = cur_time;
> -	spin_unlock(&cpufreq_stats_lock);
>  }
>  
>  static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>  {
>  	unsigned int count = stats->max_state;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	memset(stats->time_in_state, 0, count * sizeof(u64));
>  	memset(stats->trans_table, 0, count * count * sizeof(int));
>  	stats->last_time = get_jiffies_64();
>  	stats->total_trans = 0;
> +	spin_unlock(&cpufreq_stats_lock);
>  }
>  
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> @@ -62,7 +62,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	if (policy->fast_switch_enabled)
>  		return 0;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stats);
> +	spin_unlock(&cpufreq_stats_lock);
> +
>  	for (i = 0; i < stats->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
>  			(unsigned long long)
> @@ -239,9 +242,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>  	if (old_index == -1 || new_index == -1 || old_index == new_index)
>  		return;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stats);
>  
>  	stats->last_index = new_index;
>  	stats->trans_table[old_index * stats->max_state + new_index]++;
>  	stats->total_trans++;
> +	spin_unlock(&cpufreq_stats_lock);
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
