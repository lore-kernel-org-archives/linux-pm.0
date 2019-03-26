From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] cpufreq: stats: Use lock by stat to replace global spin
 lock
Date: Tue, 26 Mar 2019 11:43:46 -0700
Message-ID: <20190326184346.GY112750@google.com>
References: <20190325072933.215946-1-linkyle0915@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325072933.215946-1-linkyle0915@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Lin <linkyle0915@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 25, 2019 at 03:29:33PM +0800, Kyle Lin wrote:
> Stats is updated by each policy, using the lock by stat can
> reduce the contention.
> 
> Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index e2db5581489a..17beb1bc7e16 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> -static DEFINE_SPINLOCK(cpufreq_stats_lock);
>  
>  struct cpufreq_stats {
>  	unsigned int total_trans;
> @@ -23,6 +22,7 @@ struct cpufreq_stats {
>  	unsigned int state_num;
>  	unsigned int last_index;
>  	u64 *time_in_state;
> +	spinlock_t lock;        /*spinlock for stats update*/

nit: not sure if the comment adds much value. If it stay there it
needs a blank after '/*' and another before '*/'

>  	unsigned int *freq_table;
>  	unsigned int *trans_table;
>  };
> @@ -39,12 +39,12 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>  {
>  	unsigned int count = stats->max_state;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	memset(stats->time_in_state, 0, count * sizeof(u64));
>  	memset(stats->trans_table, 0, count * count * sizeof(int));
>  	stats->last_time = get_jiffies_64();
>  	stats->total_trans = 0;
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  }
>  
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> @@ -62,9 +62,9 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	if (policy->fast_switch_enabled)
>  		return 0;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	cpufreq_stats_update(stats);
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  
>  	for (i = 0; i < stats->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> @@ -211,6 +211,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	stats->state_num = i;
>  	stats->last_time = get_jiffies_64();
>  	stats->last_index = freq_table_get_index(stats, policy->cur);
> +	spin_lock_init(&stats->lock);
>  
>  	policy->stats = stats;
>  	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
> @@ -242,11 +243,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>  	if (old_index == -1 || new_index == -1 || old_index == new_index)
>  		return;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	cpufreq_stats_update(stats);
>  
>  	stats->last_index = new_index;
>  	stats->trans_table[old_index * stats->max_state + new_index]++;
>  	stats->total_trans++;
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
