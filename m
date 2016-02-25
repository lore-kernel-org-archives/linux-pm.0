From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3 2/2] cpufreq: schedutil: Switching frequencies from interrupt context
Date: Thu, 25 Feb 2016 12:10:48 +0100
Message-ID: <5251325.s7kEicchZh@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <1522086.TRnWVDkbTk@vostro.rjw.lan> <20160225090840.GB6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61917 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752104AbcBYLJO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 06:09:14 -0500
In-Reply-To: <20160225090840.GB6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Thursday, February 25, 2016 10:08:40 AM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 12:30:43AM +0100, Rafael J. Wysocki wrote:
> > +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > +				      unsigned int target_freq)
> > +{
> > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > +	struct cpufreq_frequency_table *entry;
> > +	struct acpi_processor_performance *perf;
> > +	unsigned int uninitialized_var(next_perf_state);
> > +	unsigned int uninitialized_var(next_freq);
> > +	unsigned int best_diff;
> > +
> > +	for (entry = data->freq_table, best_diff = UINT_MAX;
> > +	     entry->frequency != CPUFREQ_TABLE_END; entry++) {
> > +		unsigned int diff, freq = entry->frequency;
> > +
> > +		if (freq == CPUFREQ_ENTRY_INVALID)
> > +			continue;
> > +
> > +		diff = abs(freq - target_freq);
> 
> Why would you consider frequencies that are below where you want to be?

Say you have 800 MHz and 1600 MHz to choose from and the request if for
900 MHz.  The other may be way off (and different voltage for that matter).

Thanks,
Rafael

