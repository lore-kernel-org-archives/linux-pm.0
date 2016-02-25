From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v3 2/2] cpufreq: schedutil: Switching
 frequencies from interrupt context
Date: Thu, 25 Feb 2016 10:08:40 +0100
Message-ID: <20160225090840.GB6357@twins.programming.kicks-ass.net>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <1810564.h98CMnhalE@vostro.rjw.lan>
 <1597360.X9ARIiUr5r@vostro.rjw.lan>
 <1522086.TRnWVDkbTk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522086.TRnWVDkbTk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 25, 2016 at 12:30:43AM +0100, Rafael J. Wysocki wrote:
> +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +				      unsigned int target_freq)
> +{
> +	struct acpi_cpufreq_data *data = policy->driver_data;
> +	struct cpufreq_frequency_table *entry;
> +	struct acpi_processor_performance *perf;
> +	unsigned int uninitialized_var(next_perf_state);
> +	unsigned int uninitialized_var(next_freq);
> +	unsigned int best_diff;
> +
> +	for (entry = data->freq_table, best_diff = UINT_MAX;
> +	     entry->frequency != CPUFREQ_TABLE_END; entry++) {
> +		unsigned int diff, freq = entry->frequency;
> +
> +		if (freq == CPUFREQ_ENTRY_INVALID)
> +			continue;
> +
> +		diff = abs(freq - target_freq);

Why would you consider frequencies that are below where you want to be?

> +		if (diff >= best_diff)
> +			continue;
> +
> +		best_diff = diff;
> +		next_perf_state = entry->driver_data;
> +		next_freq = freq;
> +		if (best_diff == 0)
> +			goto found;
> +	}
> +	if (best_diff == UINT_MAX)
> +		return CPUFREQ_ENTRY_INVALID;
> +
> + found:
> +	perf = to_perf_data(data);
> +	if (perf->state == next_perf_state) {
> +		if (unlikely(data->resume))
> +			data->resume = 0;
> +		else
> +			return next_freq;
> +	}
> +
> +	data->cpu_freq_fast_write(perf->states[next_perf_state].control);
> +	perf->state = next_perf_state;
> +	return next_freq;
> +}
