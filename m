From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor
 for tickless systems
Date: Sun, 11 Nov 2018 16:20:34 +0100
Message-ID: <20181111152034.GC3021@worktop>
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
> +/*
> + * The SPIKE value is added to metrics when they grow and the DECAY_SHIFT value
> + * is used for decreasing metrics on a regular basis.
> + */
> +#define SPIKE		1024
> +#define DECAY_SHIFT	3

> +	if (idx_timer >= 0) {
> +		unsigned int hits = cpu_data->states[idx_timer].hits;
> +		unsigned int misses = cpu_data->states[idx_timer].misses;
> +
> +		hits -= hits >> DECAY_SHIFT;
> +		misses -= misses >> DECAY_SHIFT;
> +
> +		if (idx_timer > idx_hit) {
> +			misses += SPIKE;
> +			if (idx_hit >= 0)
> +				cpu_data->states[idx_hit].early_hits += SPIKE;
> +		} else {
> +			hits += SPIKE;
> +		}
> +
> +		cpu_data->states[idx_timer].misses = misses;
> +		cpu_data->states[idx_timer].hits = hits;
> +	}

That's a pulse-density-modulator, with a signal bound of:

  1024 == x/8 -> x := 8192

Anyway; I would suggest s/SPIKE/PULSE/ because of that.
