From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Date: Fri, 3 Jun 2016 16:48:54 -0700
Message-ID: <20160603234854.GF14579@graphite.smuckle.net>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <e155257e7f76c3dc71f9347e0433fb1e4d9a3358.1464960877.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32906 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcFCXtF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 19:49:05 -0400
Received: by mail-pa0-f45.google.com with SMTP id ec8so12512289pac.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2016 16:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e155257e7f76c3dc71f9347e0433fb1e4d9a3358.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, linuxppc-dev@lists.ozlabs.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

On Fri, Jun 03, 2016 at 07:05:14PM +0530, Viresh Kumar wrote:
...
> @@ -468,20 +469,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  	struct acpi_cpufreq_data *data = policy->driver_data;
>  	struct acpi_processor_performance *perf;
>  	struct cpufreq_frequency_table *entry;
> -	unsigned int next_perf_state, next_freq, freq;
> +	unsigned int next_perf_state, next_freq, index;
>  
>  	/*
>  	 * Find the closest frequency above target_freq.
> -	 *
> -	 * The table is sorted in the reverse order with respect to the
> -	 * frequency and all of the entries are valid (see the initialization).
>  	 */
> -	entry = policy->freq_table;
> -	do {
> -		entry++;
> -		freq = entry->frequency;
> -	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> -	entry--;
> +	index = cpufreq_frequency_table_target(policy, target_freq,
> +					       CPUFREQ_RELATION_L);

Can we call cpufreq_find_index_l directly here? Seems like we could
phase out cpufreq_frequency_table_target() for the most part and call
the helpers directly. It would avoid some code bloat, an unnecessary
switch statement and an error check for an invalid frequency table which
seems unnecessary for every frequency table lookup.

thanks,
Steve
