From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3 2/2] cpufreq: schedutil: Switching frequencies from interrupt context
Date: Thu, 25 Feb 2016 12:11:32 +0100
Message-ID: <11571200.UfH7ljt8PZ@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <20160225090840.GB6357@twins.programming.kicks-ass.net> <20160225091249.GV6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53148 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760367AbcBYLJ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 06:09:58 -0500
In-Reply-To: <20160225091249.GV6375@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Thursday, February 25, 2016 10:12:49 AM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 10:08:40AM +0100, Peter Zijlstra wrote:
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
> Also, if you look for the first largest freq (which would make most
> sense I think) and this table is sorted, you can do a binary search.
> 
> Then again, not sure the table is big enough to make that worth it.

Yeah, that was my thought too.

