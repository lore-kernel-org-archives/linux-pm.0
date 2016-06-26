From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] cpufreq: Handle sorted frequency tables more
 efficiently
Date: Sun, 26 Jun 2016 16:08:40 +0530
Message-ID: <20160626103840.GA32206@ubuntu>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
 <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
 <15131722.y1kqigY9Ad@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15131722.y1kqigY9Ad@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for having a look at this..

On 23-06-16, 02:28, Rafael J. Wysocki wrote:
> On Tuesday, June 07, 2016 03:55:14 PM Viresh Kumar wrote:
> > +/* Find lowest freq at or above target in a table in ascending order */
> > +static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
> > +					      unsigned int target_freq)
> > +{
> > +	struct cpufreq_frequency_table *table = policy->freq_table;
> > +	unsigned int freq;
> > +	int i, best = -1;
> > +
> > +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> > +		freq = table[i].frequency;
> > +
> > +		if (freq_is_invalid(policy, freq))
> > +			continue;
> > +
> > +		if (freq >= target_freq)
> > +			return i;
> > +
> > +		best = i;
> > +	}
> > +
> > +	if (best == -1) {
> > +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> 
> After a successful cpufreq_table_validate_and_show() that should be impossible,
> shouldn't it?

This shouldn't be possible unless cpufreq_table_validate_and_show() has a bug,
or somehow that routine isn't called.

Though, to catch such bugs, what about WARN_ON(best == -1); ? The WARN() will
have an unlikely() statement as well to optimize it and we can catch the bugs as
well.

Or if you think we should just remove them..

> > +/* Find highest freq at or below target in a table in descending order */
> > +static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
> > +					      unsigned int target_freq)
> > +{
> > +	struct cpufreq_frequency_table *table = policy->freq_table;
> > +	unsigned int freq;
> > +	int i, best = -1;
> > +
> > +	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> > +		freq = table[i].frequency;
> > +
> > +		if (freq_is_invalid(policy, freq))
> > +			continue;
> > +
> > +		if (freq <= target_freq)
> > +			return i;
> > +
> > +		best = i;
> > +	}
> > +
> > +	if (best == -1) {
> > +		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return best;
> > +}
> 
> I still don't see a reason for min/max checking in these routines.
> 
> So what is the reason?

These routines are all part of the existing API cpufreq_frequency_table_target()
and that always had these checks. Over that, not all of its callers are ensuring
that the target-freq is clamped before this routine is called. And so we need to
make sure that these routines return a frequency between min/max only.

What do you say ?

-- 
viresh
