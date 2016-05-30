From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 2/3] cpufreq: acpi-cpufreq: add resolve_freq callback
Date: Mon, 30 May 2016 09:20:27 -0700
Message-ID: <20160530162027.GF9864@graphite.smuckle.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-3-git-send-email-smuckle@linaro.org>
 <20160526064341.GV17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33514 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161220AbcE3QUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 12:20:31 -0400
Received: by mail-pf0-f182.google.com with SMTP id b124so65831554pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 09:20:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160526064341.GV17585@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Thu, May 26, 2016 at 12:13:41PM +0530, Viresh Kumar wrote:
> On 25-05-16, 19:53, Steve Muckle wrote:
> > Support the new resolve_freq cpufreq callback which resolves a target
> > frequency to a driver-supported frequency without actually setting it.
> 
> And here is the first abuser of this API as I was talking about in the
> earlier patch :)
> 
> But, I know why you are doing it and I think we can do it differently.
> 
> So, lets assume that the ->resolve_freq() callback will ONLY be
> provided by the drivers which also provide a ->target() callback.
> 
> i.e. not by acpi-cpufreq at least.
> 
> > The target frequency and resolved frequency table entry are cached so
> > that a subsequent fast_switch operation may avoid the frequency table
> > walk assuming the requested target frequency is the same.
> > 
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 56 ++++++++++++++++++++++++++++++++----------
> >  1 file changed, 43 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 7f38fb55f223..d87962eda1ed 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -66,6 +66,8 @@ enum {
> >  
> >  struct acpi_cpufreq_data {
> >  	struct cpufreq_frequency_table *freq_table;
> > +	unsigned int cached_lookup_freq;
> > +	struct cpufreq_frequency_table *cached_lookup_entry;
> 
> This could have been an integer value 'Index', which could have been
> used together with the freq-table to get the freq we wanted.
> 
> And, then we can move these two fields into the cpufreq_policy
> structure and make them part of the first patch itself.
> 
> >  	unsigned int resume;
> >  	unsigned int cpu_feature;
> >  	unsigned int acpi_perf_cpu;
> > @@ -458,26 +460,53 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
> >  	return result;
> >  }
> >  
> > -unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > -				      unsigned int target_freq)
> > +/*
> > + * Find the closest frequency above target_freq.
> > + *
> > + * The table is sorted in the reverse order with respect to the
> > + * frequency and all of the entries are valid (see the initialization).
> > + */
> > +static inline struct cpufreq_frequency_table
> > +*lookup_freq(struct cpufreq_frequency_table *table, unsigned int target_freq)
> >  {
> > -	struct acpi_cpufreq_data *data = policy->driver_data;
> > -	struct acpi_processor_performance *perf;
> > -	struct cpufreq_frequency_table *entry;
> > -	unsigned int next_perf_state, next_freq, freq;
> > +	struct cpufreq_frequency_table *entry = table;
> > +	unsigned int freq;
> >  
> > -	/*
> > -	 * Find the closest frequency above target_freq.
> > -	 *
> > -	 * The table is sorted in the reverse order with respect to the
> > -	 * frequency and all of the entries are valid (see the initialization).
> > -	 */
> > -	entry = data->freq_table;
> >  	do {
> >  		entry++;
> >  		freq = entry->frequency;
> >  	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> >  	entry--;
> > +
> > +	return entry;
> > +}
> > +
> > +unsigned int acpi_cpufreq_resolve_freq(struct cpufreq_policy *policy,
> > +				       unsigned int target_freq)
> > +{
> > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > +	struct cpufreq_frequency_table *entry;
> > +
> > +	data->cached_lookup_freq = target_freq;
> > +	entry = lookup_freq(data->freq_table, target_freq);
> > +	data->cached_lookup_entry = entry;
> > +
> > +	return entry->frequency;
> > +}
> > +
> 
> And then we could remove this callback from acpi-cpufreq.
> 
> > +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > +				      unsigned int target_freq)
> > +{
> > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > +	struct acpi_processor_performance *perf;
> > +	struct cpufreq_frequency_table *entry;
> > +	unsigned int next_perf_state, next_freq;
> > +
> > +	if (data->cached_lookup_entry &&
> > +	    data->cached_lookup_freq == target_freq)
> > +		entry = data->cached_lookup_entry;
> > +	else
> > +		entry = lookup_freq(data->freq_table, target_freq);
> 
> And a static inline callback in cpufreq.h to get this entry.
> 
> >  	next_freq = entry->frequency;
> >  	next_perf_state = entry->driver_data;
> >  
> > @@ -918,6 +947,7 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
> >  	.verify		= cpufreq_generic_frequency_table_verify,
> >  	.target_index	= acpi_cpufreq_target,
> >  	.fast_switch	= acpi_cpufreq_fast_switch,
> > +	.resolve_freq	= acpi_cpufreq_resolve_freq,
> >  	.bios_limit	= acpi_processor_get_bios_limit,
> >  	.init		= acpi_cpufreq_cpu_init,
> >  	.exit		= acpi_cpufreq_cpu_exit,
> 
> Sounds reasonable ?

A couple concerns... One is that if we do the lookup in
cpufreq_driver_resolve_freq() for drivers which implement target_index()
then it means using cpufreq_frequency_table_target() there.  This is a
heavier weight function that can't take advantage of driver-specific
knowledge that the freq table is sorted a particular way. So for
acpi-cpufreq we'd now be having to walk the whole table for every
fast_switch.

Another is that it'll be a a bit odd that the logic used to lookup the
driver frequency will be different in the cached and uncached
fast_switch cases. In the cached case it will have been determined by
code in cpufreq_driver_resolve_freq() whereas in the uncached case it
will be logic in the driver, in its fast_switch routine.

I think at least the first issue would need to be solved to use this
approach as it would impact performance for every fast_switch call.

(Thanks for the review btw!)

thanks,
Steve
