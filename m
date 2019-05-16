From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
Date: Thu, 16 May 2019 13:42:00 +0100
Message-ID: <20190516124200.opxczohjelhvrzmo@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190508174301.4828-2-douglas.raillard@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: douglas.raillard@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 08-May 18:42, douglas.raillard@arm.com wrote:
> From: Douglas RAILLARD <douglas.raillard@arm.com>
> 
> em_pd_get_higher_freq() returns a frequency greater or equal to the
> provided one while taking into account a given cost margin. It also
> skips inefficient OPPs that have a higher cost than another one with a
> higher frequency.

It's worth to add a small description and definition of what we mean by
"OPP efficiency". Despite being just an RFC, it could help to better
understand what we are after.

[...]

> +/** + * em_pd_get_higher_freq() - Get the highest frequency that
> does not exceed the
> + * given cost margin compared to min_freq
> + * @pd		: performance domain for which this must be done
> + * @min_freq	: minimum frequency to return
> + * @cost_margin	: allowed margin compared to min_freq, as a per-1024 value.
                                                                    ^^^^^^^^
here...

> + *
> + * Return: the chosen frequency, guaranteed to be at least as high as min_freq.
> + */
> +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
> +	unsigned long min_freq, unsigned long cost_margin)
> +{
> +	unsigned long max_cost = 0;
> +	struct em_cap_state *cs;
> +	int i;
> +
> +	if (!pd)
> +		return min_freq;
> +
> +	/* Compute the maximum allowed cost */
> +	for (i = 0; i < pd->nr_cap_states; i++) {
> +		cs = &pd->table[i];
> +		if (cs->frequency >= min_freq) {
> +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
                                                                         ^^^^
... end here we should probably better use SCHED_CAPACITY_SCALE
instead of hard-coding in values, isn't it?

> +			break;
> +		}
> +	}
> +

[...]

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
