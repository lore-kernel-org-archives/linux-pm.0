From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH V5 1/2] cpufreq: Handle sorted frequency tables more
 efficiently
Date: Mon, 27 Jun 2016 12:10:52 +0200
Message-ID: <5770FBAC.3040901@gmail.com>
References: <cover.1467001203.git.viresh.kumar@linaro.org>
 <594b312d352b55f44d5ebea954fdf784e966867e.1467001203.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33832 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcF0KLC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 06:11:02 -0400
In-Reply-To: <594b312d352b55f44d5ebea954fdf784e966867e.1467001203.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

On 06/27/2016 06:29 AM, Viresh Kumar wrote:
> cpufreq drivers aren't required to provide a sorted frequency table
> today, and even the ones which provide a sorted table aren't handled
> efficiently by cpufreq core.
>
> This patch adds infrastructure to verify if the freq-table provided by
> the drivers is sorted or not, and use efficient helpers if they are
> sorted.
<snip>
> @@ -610,6 +617,227 @@ int cpufreq_boost_trigger_state(int state);
>   int cpufreq_boost_enabled(void);
>   int cpufreq_enable_boost_support(void);
>   bool policy_has_boost_freq(struct cpufreq_policy *policy);
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
> +		if (freq >= target_freq)
> +			return i;
> +
> +		best = i;
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
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq > target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */

"below" should be "above"

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
> +		if (freq == target_freq)
> +			return i;
> +
> +		if (freq > target_freq) {
> +			best = i;
> +			continue;
> +		}
> +
> +		/* No freq found below target_freq */

"below" should be "above"

> +		if (best == -1)
> +			return i;
> +
> +		/* Choose the closest freq */
> +		if (target_freq - table[best].frequency > freq - target_freq)

Here, table[best].frequency > target_freq, and freq < and target_freq, 
so you should reverse the sign of both sides of the inequation:

	if (table[best].frequency - target_freq > target_freq - freq)

> +			return i;
> +
> +		return best;
> +	}
> +
> +	return best;
> +}

Regards,
Francesco
