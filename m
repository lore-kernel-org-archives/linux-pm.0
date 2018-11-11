From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor
 for tickless systems
Date: Sun, 11 Nov 2018 16:40:17 +0100
Message-ID: <20181111154017.GD3021@worktop>
References: <102783770.7hZjAahU8c@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <102783770.7hZjAahU8c@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> +			       struct teo_cpu *cpu_data,
> +			       unsigned int sleep_length_us)
> +{
> +	u64 range, max_spread, sum, max, min;
> +	unsigned int i, count;
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
> +	/*
> +	 * First pass: compute the sum of interesting samples, the minimum and
> +	 * maximum of them and count them.
> +	 */
> +	count = 0;
> +	sum = 0;
> +	max = 0;
> +	min = UINT_MAX;
> +
> +	for (i = 0; i < INTERVALS; i++) {
> +		u64 val = cpu_data->intervals[i];
> +
> +		if (val >= range)
> +			continue;
> +
> +		count++;
> +		sum += val;
> +		if (max < val)
> +			max = val;
> +
> +		if (min > val)
> +			min = val;
> +	}
> +
> +	/* Give up if the number of interesting samples is too small. */
> +	if (count <= INTERVALS / 2)
> +		return sleep_length_us;
> +
> +	/*
> +	 * If the distance between the max or min and the average is too large,
> +	 * try to refine by discarding the max, as long as the count is above 3.
> +	 */
> +	while (count > 3 && max > max_spread &&
> +	       ((max - max_spread) * count > sum ||
> +	        (min + max_spread) * count < sum)) {
> +
> +		range = max;
> +
> +		/*
> +		 * Compute the sum of samples in the interesting range.  Count
> +		 * them and find the maximum of them.
> +		 */
> +		count = 0;
> +		sum = 0;
> +		max = 0;
> +
> +		for (i = 0; i < INTERVALS; i++) {
> +			u64 val = cpu_data->intervals[i];
> +
> +			if (val >= range)
> +				continue;
> +
> +			count++;
> +			sum += val;
> +			if (max < val)
> +				max = val;
> +		}
> +	}
> +
> +	return div64_u64(sum, count);
> +}

By always discarding the larger value; you're searching for the first or
shortest peak, right?

While that is always a safe value; it might not be the best value.

Also; I think you can write the whole thing shorter; maybe like:


	do {
		count = sum = max = 0;
		min = UINT_MAX;

		for (i = 0; i < INTERVALS; i++) {
			u64 val = cpu_data->intervals[i];

			if (val >= range)
				continue;

			count++;
			sum += val;
			max = max(max, val);
			min = min(min, val);
		}

		range = max;

	} while (count > 3 && max > max_spread &&
	         ((max - max_spread) * count > sum ||
		  (min + max_spread) * count < sum));

per the fact that <= INTERVALS/2 := > 3, without assuming that you need
one more condition in there for the first pass or something.


Anyway; a fair while ago I proposed a different estimator. I've not had
time to dig through the 4 prior versions so I cannot tell if you've
already tried this, but the idea was simple:

  - track the last @n wakeup distances in the @idle-states buckets;
  - sum the buckets in increasing idle state and pick the state before
    you reach 50% of @n.

That is computationally cheaper than what you have; and should allow you
to increase @n without making the computation more expensive.
