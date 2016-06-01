From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: Optimize cpufreq_frequency_table_target()
Date: Wed, 1 Jun 2016 12:46:15 -0700
Message-ID: <20160601194615.GQ9864@graphite.smuckle.net>
References: <cover.1464777376.git.viresh.kumar@linaro.org>
 <120ed8a873b6df2ccc9406eeec8f8f74e5f9b0d5.1464777376.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33129 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcFATqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 15:46:19 -0400
Received: by mail-pf0-f181.google.com with SMTP id b124so20992795pfb.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 12:46:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <120ed8a873b6df2ccc9406eeec8f8f74e5f9b0d5.1464777376.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>

On Wed, Jun 01, 2016 at 04:09:55PM +0530, Viresh Kumar wrote:
> cpufreq core keeps another table of sorted frequencies now and that can
> be used to find a match quickly, instead of traversing the unsorted list
> in an inefficient way.
> 
> Create helper routines for separate relation types to optimize it
> further.
> 
> Ideally the new routine cpufreq_find_target_index() is required to be
> exported, but s3c24xx was abusing the earlier API and have to be
> supported for now. Added a FIXME for it.
> 
> Tested on Exynos board with both ondemand and schedutil governor and
> confirmed with help of various print messages that we are eventually
> switching to the desired frequency based on a target frequency.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c    |  15 ++--
>  drivers/cpufreq/freq_table.c      | 180 ++++++++++++++++++++++----------------
>  drivers/cpufreq/s3c24xx-cpufreq.c |  13 ++-
>  include/linux/cpufreq.h           |  20 ++++-
>  4 files changed, 134 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 32a15052f363..4f9f7504a17c 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -468,20 +468,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
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

This adds a function call to the fast path...
