From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency
 switching
Date: Mon, 28 Mar 2016 12:33:41 +0530
Message-ID: <20160328070341.GJ32495@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

forgot to review acpi update earlier ..

On 22-03-16, 02:53, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -458,6 +458,43 @@ static int acpi_cpufreq_target(struct cp
>  	return result;
>  }
>  
> +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +				      unsigned int target_freq)
> +{
> +	struct acpi_cpufreq_data *data = policy->driver_data;
> +	struct acpi_processor_performance *perf;
> +	struct cpufreq_frequency_table *entry;
> +	unsigned int next_perf_state, next_freq, freq;
> +
> +	/*
> +	 * Find the closest frequency above target_freq.
> +	 *
> +	 * The table is sorted in the reverse order with respect to the
> +	 * frequency and all of the entries are valid (see the initialization).
> +	 */
> +	entry = data->freq_table;
> +	do {
> +		entry++;
> +		freq = entry->frequency;
> +	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);

Consider this table:

11000
10000
9000

And a target-freq of 10000.

Wouldn't you end up selecting 11000 ? Or did I misread it ?

> +	entry--;
> +	next_freq = entry->frequency;
> +	next_perf_state = entry->driver_data;
> +
> +	perf = to_perf_data(data);
> +	if (perf->state == next_perf_state) {
> +		if (unlikely(data->resume))
> +			data->resume = 0;
> +		else
> +			return next_freq;
> +	}
> +
> +	data->cpu_freq_write(&perf->control_register,
> +			     perf->states[next_perf_state].control);
> +	perf->state = next_perf_state;
> +	return next_freq;
> +}
> +
>  static unsigned long
>  acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
>  {
> @@ -740,6 +777,9 @@ static int acpi_cpufreq_cpu_init(struct
>  		goto err_unreg;
>  	}
>  
> +	policy->fast_switch_possible = !acpi_pstate_strict &&
> +		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
> +
>  	data->freq_table = kzalloc(sizeof(*data->freq_table) *
>  		    (perf->state_count+1), GFP_KERNEL);
>  	if (!data->freq_table) {
> @@ -874,6 +914,7 @@ static struct freq_attr *acpi_cpufreq_at
>  static struct cpufreq_driver acpi_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= acpi_cpufreq_target,
> +	.fast_switch	= acpi_cpufreq_fast_switch,
>  	.bios_limit	= acpi_processor_get_bios_limit,
>  	.init		= acpi_cpufreq_cpu_init,
>  	.exit		= acpi_cpufreq_cpu_exit,

-- 
viresh
