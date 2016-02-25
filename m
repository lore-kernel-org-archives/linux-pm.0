From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v3 2/2] cpufreq: schedutil: Switching
 frequencies from interrupt context
Date: Thu, 25 Feb 2016 12:52:34 +0100
Message-ID: <20160225115234.GF6357@twins.programming.kicks-ass.net>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <1522086.TRnWVDkbTk@vostro.rjw.lan>
 <20160225090840.GB6357@twins.programming.kicks-ass.net>
 <5251325.s7kEicchZh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50980 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759467AbcBYLwm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 06:52:42 -0500
Content-Disposition: inline
In-Reply-To: <5251325.s7kEicchZh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Feb 25, 2016 at 12:10:48PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 25, 2016 10:08:40 AM Peter Zijlstra wrote:
> > On Thu, Feb 25, 2016 at 12:30:43AM +0100, Rafael J. Wysocki wrote:
> > > +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > > +				      unsigned int target_freq)
> > > +{
> > > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > > +	struct cpufreq_frequency_table *entry;
> > > +	struct acpi_processor_performance *perf;
> > > +	unsigned int uninitialized_var(next_perf_state);
> > > +	unsigned int uninitialized_var(next_freq);
> > > +	unsigned int best_diff;
> > > +
> > > +	for (entry = data->freq_table, best_diff = UINT_MAX;
> > > +	     entry->frequency != CPUFREQ_TABLE_END; entry++) {
> > > +		unsigned int diff, freq = entry->frequency;
> > > +
> > > +		if (freq == CPUFREQ_ENTRY_INVALID)
> > > +			continue;
> > > +
> > > +		diff = abs(freq - target_freq);
> > 
> > Why would you consider frequencies that are below where you want to be?
> 
> Say you have 800 MHz and 1600 MHz to choose from and the request if for
> 900 MHz.  The other may be way off (and different voltage for that matter).

Are there really chips with such crappy choices? That said, for some
scenarios you really do have to pick 1600 because otherwise the work
will not be able to complete in time and the whole purpose of the
machine is moot.

That argues for more than a target frequency argument.

Furthermore, depending on the idle capabilities of the platform, 1600
might still be the better choice, it gives idle time in which it could
power gate the complete thing, still yielding better perf/watt than 100%
pegged at 800.

So I'm not at all sure the nearest freq is a sane general policy.
