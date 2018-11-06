From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Date: Tue, 6 Nov 2018 18:04:42 +0100
Message-ID: <20181106170442.GC9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556808.yKVbhZSazi@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 04, 2018 at 05:31:20PM +0100, Rafael J. Wysocki wrote:
> + * - If there is a pattern of 5 or more recent non-timer wakeups earlier than
> + *   the closest timer event, expect one more of them to occur and use the
> + *   average of the idle duration values corresponding to them to select an
> + *   idle state for the CPU.


> +/**
> + * teo_idle_duration - Estimate the duration of the upcoming CPU idle time.
> + * @drv: cpuidle driver containing state data.
> + * @cpu_data: Governor data for the target CPU.
> + * @sleep_length_us: Time till the closest timer event in microseconds.
> + */
> +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> +			       struct teo_cpu *cpu_data,
> +			       unsigned int sleep_length_us)
> +{
> +	u64 range, max_spread, max, sum;
> +	unsigned int count;
> +
> +	/*
> +	 * If the sleep length is below the target residency of idle state 1,
> +	 * the only viable choice is to select the first available (enabled)
> +	 * idle state, so return immediately in that case.
> +	 */
> +	if (sleep_length_us < drv->states[1].target_residency)
> +		return sleep_length_us;
> +
> +	/*
> +	 * The purpose of this function is to check if there is a pattern of
> +	 * wakeups indicating that it would be better to select a state
> +	 * shallower than the deepest one matching the sleep length or the
> +	 * deepest one at all if the sleep lenght is long.  Larger idle duration
> +	 * values are beyond the interesting range.
> +	 *
> +	 * Narrowing the range of interesting values down upfront also helps to
> +	 * avoid overflows during the computation below.
> +	 */
> +	range = drv->states[drv->state_count-1].target_residency;
> +	range = min_t(u64, sleep_length_us, range + (range >> 2));
> +
> +	/*
> +	 * This is the value to compare with the distance between the average
> +	 * and the greatest sample to decide whether or not it is small enough.
> +	 * Take 10 us as the total cap of it.
> +	 */
> +	max_spread = max_t(u64, range >> MAX_SPREAD_SHIFT, 10);
> +
> +	max = range;
> +
> +	do {
> +		u64 cap = max;
> +		int i;
> +
> +		/*
> +		 * Compute the sum of the saved intervals below the cap and the
> +		 * sum of of their squares.  Count them and find the maximum
> +		 * interval below the cap.
> +		 */
> +		count = 0;
> +		sum = 0;
> +		max = 0;
> +
> +		for (i = 0; i < INTERVALS; i++) {
> +			u64 val = cpu_data->intervals[i];
> +
> +			if (val >= cap)
> +				continue;
> +
> +			count++;
> +			sum += val;
> +			if (max < val)
> +				max = val;
> +		}
> +
> +		/*
> +		 * Give up if the total number of interesting samples is too
> +		 * small.
> +		 */
> +		if (cap == range && count <= INTERVALS / 2)
> +			return sleep_length_us;
> +
> +		/*
> +		 * If the distance between the max and the average is too large,
> +		 * discard the max an repeat.
> +		 */
> +	} while (count > 3 && max > max_spread && (max - max_spread) * count > sum);
> +
> +	return div64_u64(sum, count);
> +}

Instead of this detector; why haven't you used the code from
kernel/irq/timings.c ?
