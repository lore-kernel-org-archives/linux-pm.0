From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH V2] cpufreq: skip invalid entries when searching the
 frequency
Date: Wed, 12 Oct 2016 21:33:03 +0300
Message-ID: <20161012183303.GA31195@raspberrypi.musicnaut.iki.fi>
References: <10213813.22087-1-aaro.koskinen@iki.fi>
 <3b0a25515d3dc44d8fbdb91a35eaa13565a204f6.1476241978.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b0a25515d3dc44d8fbdb91a35eaa13565a204f6.1476241978.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Oct 12, 2016 at 08:45:05AM +0530, Viresh Kumar wrote:
> From: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Skip invalid entries when searching the frequency. This fixes cpufreq
> at least on loongson2 MIPS board.
> 
> Fixes: da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more efficiently")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Use cpufreq_frequency_table() instead.
> 
> Hi Aaro,
> 
> Can you please test this patch instead?

Seems to work as well.

Thanks,

A.

>  include/linux/cpufreq.h | 104 ++++++++++++++++++++++++------------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 631ba33bbe9f..5fa55fc56e18 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -639,19 +639,19 @@ static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq >= target_freq)
> -			return i;
> +			return pos - table;
>  
> -		best = i;
> +		best = pos;
>  	}
>  
> -	return best;
> +	return best - table;
>  }
>  
>  /* Find lowest freq at or above target in a table in descending order */
> @@ -659,28 +659,28 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq == target_freq)
> -			return i;
> +			return pos - table;
>  
>  		if (freq > target_freq) {
> -			best = i;
> +			best = pos;
>  			continue;
>  		}
>  
>  		/* No freq found above target_freq */
> -		if (best == -1)
> -			return i;
> +		if (best == table - 1)
> +			return pos - table;
>  
> -		return best;
> +		return best - pos;
>  	}
>  
> -	return best;
> +	return best - pos;
>  }
>  
>  /* Works only on sorted freq-tables */
> @@ -700,28 +700,28 @@ static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq == target_freq)
> -			return i;
> +			return pos - table;
>  
>  		if (freq < target_freq) {
> -			best = i;
> +			best = pos;
>  			continue;
>  		}
>  
>  		/* No freq found below target_freq */
> -		if (best == -1)
> -			return i;
> +		if (best == table - 1)
> +			return pos - table;
>  
> -		return best;
> +		return best - table;
>  	}
>  
> -	return best;
> +	return best - table;
>  }
>  
>  /* Find highest freq at or below target in a table in descending order */
> @@ -729,19 +729,19 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq <= target_freq)
> -			return i;
> +			return pos - table;
>  
> -		best = i;
> +		best = pos;
>  	}
>  
> -	return best;
> +	return best - table;
>  }
>  
>  /* Works only on sorted freq-tables */
> @@ -761,32 +761,32 @@ static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq == target_freq)
> -			return i;
> +			return pos - table;
>  
>  		if (freq < target_freq) {
> -			best = i;
> +			best = pos;
>  			continue;
>  		}
>  
>  		/* No freq found below target_freq */
> -		if (best == -1)
> -			return i;
> +		if (best == table - 1)
> +			return pos - table;
>  
>  		/* Choose the closest freq */
> -		if (target_freq - table[best].frequency > freq - target_freq)
> -			return i;
> +		if (target_freq - best->frequency > freq - target_freq)
> +			return pos - table;
>  
> -		return best;
> +		return best - table;
>  	}
>  
> -	return best;
> +	return best - table;
>  }
>  
>  /* Find closest freq to target in a table in descending order */
> @@ -794,32 +794,32 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
>  					      unsigned int target_freq)
>  {
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> +	struct cpufreq_frequency_table *pos, *best = table - 1;
>  	unsigned int freq;
> -	int i, best = -1;
>  
> -	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		freq = table[i].frequency;
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		freq = pos->frequency;
>  
>  		if (freq == target_freq)
> -			return i;
> +			return pos - table;
>  
>  		if (freq > target_freq) {
> -			best = i;
> +			best = pos;
>  			continue;
>  		}
>  
>  		/* No freq found above target_freq */
> -		if (best == -1)
> -			return i;
> +		if (best == table - 1)
> +			return pos - table;
>  
>  		/* Choose the closest freq */
> -		if (table[best].frequency - target_freq > target_freq - freq)
> -			return i;
> +		if (best->frequency - target_freq > target_freq - freq)
> +			return pos - table;
>  
> -		return best;
> +		return best - table;
>  	}
>  
> -	return best;
> +	return best - table;
>  }
>  
>  /* Works only on sorted freq-tables */
> -- 
> 2.7.1.410.g6faf27b
> 
