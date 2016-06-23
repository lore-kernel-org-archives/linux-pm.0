From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 1/2] cpufreq: Handle sorted frequency tables more efficiently
Date: Thu, 23 Jun 2016 02:28:58 +0200
Message-ID: <15131722.y1kqigY9Ad@vostro.rjw.lan>
References: <cover.1465295033.git.viresh.kumar@linaro.org> <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55588 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751040AbcFWAYk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 20:24:40 -0400
In-Reply-To: <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org

On Tuesday, June 07, 2016 03:55:14 PM Viresh Kumar wrote:
> cpufreq drivers aren't required to provide a sorted frequency table
> today, and even the ones which provide a sorted table aren't handled
> efficiently by cpufreq core.
> 
> This patch adds infrastructure to verify if the freq-table provided by
> the drivers is sorted or not, and use efficient helpers if they are
> sorted.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/freq_table.c |  67 +++++++++-
>  include/linux/cpufreq.h      | 284 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 343 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index eac8bcbdaad1..0c1139a5f33a 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -113,9 +113,9 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
>  
> -int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
> -				    unsigned int target_freq,
> -				    unsigned int relation)
> +int cpufreq_table_find_index_unsorted(struct cpufreq_policy *policy,

Is the "find" part really necessary in this name?

> +				      unsigned int target_freq,
> +				      unsigned int relation)
>  {
>  	struct cpufreq_frequency_table optimal = {
>  		.driver_data = ~0,
> @@ -205,7 +205,7 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>  		 table[index].frequency);
>  	return index;
>  }
> -EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
> +EXPORT_SYMBOL_GPL(cpufreq_table_find_index_unsorted);
>  
>  int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>  		unsigned int freq)
> @@ -297,13 +297,70 @@ struct freq_attr *cpufreq_generic_attr[] = {
>  };
>  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
>  
> +static void set_freq_table_sorted(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
> +	struct cpufreq_frequency_table *prev = NULL;
> +	int ascending = 0;
> +
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		if (!prev) {
> +			prev = pos;
> +			continue;
> +		}
> +
> +		if (pos->frequency == prev->frequency) {
> +			pr_warn("Duplicate freq-table entries: %u\n",
> +				pos->frequency);

Shouldn't cpufreq_table_validate_and_show() simply return an error in this case?

Or do we know about any drivers having this problem potentially?

> +			continue;
> +		}
> +
> +		/* Frequency increased from prev to pos */
> +		if (pos->frequency > prev->frequency) {
> +			/* But frequency was decreasing earlier */
> +			if (ascending < 0) {
> +				policy->freq_table_sorted = false;
> +				pr_debug("Freq table is unsorted\n");
> +				return;
> +			}
> +
> +			ascending++;
> +		} else {
> +			/* Frequency decreased from prev to pos */
> +
> +			/* But frequency was increasing earlier */
> +			if (ascending > 0) {
> +				policy->freq_table_sorted = false;
> +				pr_debug("Freq table is unsorted\n");
> +				return;
> +			}
> +
> +			ascending--;
> +		}
> +
> +		prev = pos;
> +	}
> +
> +	policy->freq_table_sorted = true;
> +
> +	if (ascending > 0)
> +		policy->freq_table_sorted_ascending = true;

So what about making policy->freq_table_sorted an enum instead of using two
fields?

> +	else
> +		policy->freq_table_sorted_ascending = false;
> +
> +	pr_debug("Freq table is sorted in %s order\n",
> +		 ascending > 0 ? "ascending" : "descending");
> +}
> +
>  int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
>  				      struct cpufreq_frequency_table *table)
>  {
>  	int ret = cpufreq_frequency_table_cpuinfo(policy, table);
>  
> -	if (!ret)
> +	if (!ret) {
>  		policy->freq_table = table;
> +		set_freq_table_sorted(policy);
> +	}
>  
>  	return ret;
>  }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c378776628b4..5133570e86f2 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -86,7 +86,11 @@ struct cpufreq_policy {
>  					 * called, but you're in IRQ context */
>  
>  	struct cpufreq_user_policy user_policy;
> +
> +	/* Freq-table and its flags */
>  	struct cpufreq_frequency_table	*freq_table;
> +	bool			freq_table_sorted;
> +	bool			freq_table_sorted_ascending;
>  
>  	struct list_head        policy_list;
>  	struct kobject		kobj;
> @@ -597,9 +601,9 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
>  				   struct cpufreq_frequency_table *table);
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
>  
> -int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
> -				   unsigned int target_freq,
> -				   unsigned int relation);
> +int cpufreq_table_find_index_unsorted(struct cpufreq_policy *policy,
> +				      unsigned int target_freq,
> +				      unsigned int relation);
>  int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>  		unsigned int freq);
>  
> @@ -610,6 +614,280 @@ int cpufreq_boost_trigger_state(int state);
>  int cpufreq_boost_enabled(void);
>  int cpufreq_enable_boost_support(void);
>  bool policy_has_boost_freq(struct cpufreq_policy *policy);
> +
> +static inline bool freq_is_invalid(struct cpufreq_policy *policy, unsigned int frequency)
> +{
> +	if (unlikely(frequency == CPUFREQ_ENTRY_INVALID))
> +		return true;
> +
> +	if (unlikely((frequency < policy->min) || (frequency > policy->max)))
> +		return true;

This is confusing.  A frequency beyond min..max is not invalid, it is out of
bounds.

> +
> +	return false;
> +}
> +
> +/* Find lowest freq at or above target in a table in ascending order */
> +static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq >= target_freq)
> +			return i;
> +
> +		best = i;
> +	}
> +
> +	if (best == -1) {
> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);

After a successful cpufreq_table_validate_and_show() that should be impossible,
shouldn't it?

> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}
> +
> +/* Find lowest freq at or above target in a table in descending order */
> +static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq > target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */
> +		if (best == -1)
> +			return i;
> +
> +		return best;
> +	}
> +
> +	if (best == -1) {
> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}
> +
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
> +					     unsigned int target_freq)
> +{
> +	if (policy->freq_table_sorted_ascending)
> +		return cpufreq_table_find_index_al(policy, target_freq);
> +	else
> +		return cpufreq_table_find_index_dl(policy, target_freq);
> +}
> +
> +/* Find highest freq at or below target in a table in ascending order */
> +static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq < target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */
> +		if (best == -1)
> +			return i;
> +
> +		return best;
> +	}
> +
> +	if (best == -1) {
> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}
> +
> +/* Find highest freq at or below target in a table in descending order */
> +static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq <= target_freq)
> +			return i;
> +
> +		best = i;
> +	}
> +
> +	if (best == -1) {
> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}

I still don't see a reason for min/max checking in these routines.

So what is the reason?

> +
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
> +					     unsigned int target_freq)
> +{
> +	if (policy->freq_table_sorted_ascending)
> +		return cpufreq_table_find_index_ah(policy, target_freq);
> +	else
> +		return cpufreq_table_find_index_dh(policy, target_freq);
> +}
> +
> +/* Find closest freq to target in a table in ascending order */
> +static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq < target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */
> +		if (best == -1)
> +			return i;
> +
> +		/* Choose the closest freq */
> +		if (target_freq - table[best].frequency > freq - target_freq)
> +			return i;
> +
> +		return best;
> +	}
> +
> +	if (best == -1) {

Can we actually get here?

> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}
> +
> +/* Find closest freq to target in a table in descending order */
> +static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
> +					      unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int freq;
> +	int i, best = -1;
> +
> +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		freq = table[i].frequency;
> +
> +		if (freq_is_invalid(policy, freq))
> +			continue;
> +
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq > target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */
> +		if (best == -1)
> +			return i;
> +
> +		/* Choose the closest freq */
> +		if (target_freq - table[best].frequency > freq - target_freq)
> +			return i;
> +
> +		return best;
> +	}
> +
> +	if (best == -1) {
> +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +		return -EINVAL;
> +	}
> +
> +	return best;
> +}
> +
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
> +					     unsigned int target_freq)
> +{
> +	if (policy->freq_table_sorted_ascending)
> +		return cpufreq_table_find_index_ac(policy, target_freq);
> +	else
> +		return cpufreq_table_find_index_dc(policy, target_freq);
> +}
> +
> +static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
> +						 unsigned int target_freq,
> +						 unsigned int relation)
> +{
> +	if (unlikely(!policy->freq_table_sorted))
> +		return cpufreq_table_find_index_unsorted(policy, target_freq,
> +							 relation);
> +
> +	switch (relation) {
> +	case CPUFREQ_RELATION_L:
> +		return cpufreq_table_find_index_l(policy, target_freq);
> +	case CPUFREQ_RELATION_H:
> +		return cpufreq_table_find_index_h(policy, target_freq);
> +	case CPUFREQ_RELATION_C:
> +		return cpufreq_table_find_index_c(policy, target_freq);
> +	default:
> +		pr_err("%s: Invalid relation: %d\n", __func__, relation);
> +		return -EINVAL;
> +	}
> +}
>  #else
>  static inline int cpufreq_boost_trigger_state(int state)
>  {

Thanks,
Rafael

