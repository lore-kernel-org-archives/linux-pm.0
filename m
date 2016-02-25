From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3 2/2] cpufreq: schedutil: Switching frequencies from interrupt context
Date: Thu, 25 Feb 2016 21:54:43 +0100
Message-ID: <2814837.ei3iD68Os6@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <5251325.s7kEicchZh@vostro.rjw.lan> <20160225115234.GF6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41478 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750716AbcBYUxK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 15:53:10 -0500
In-Reply-To: <20160225115234.GF6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Thursday, February 25, 2016 12:52:34 PM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 12:10:48PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 25, 2016 10:08:40 AM Peter Zijlstra wrote:
> > > On Thu, Feb 25, 2016 at 12:30:43AM +0100, Rafael J. Wysocki wrote:
> > > > +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > > > +				      unsigned int target_freq)
> > > > +{
> > > > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > > > +	struct cpufreq_frequency_table *entry;
> > > > +	struct acpi_processor_performance *perf;
> > > > +	unsigned int uninitialized_var(next_perf_state);
> > > > +	unsigned int uninitialized_var(next_freq);
> > > > +	unsigned int best_diff;
> > > > +
> > > > +	for (entry = data->freq_table, best_diff = UINT_MAX;
> > > > +	     entry->frequency != CPUFREQ_TABLE_END; entry++) {
> > > > +		unsigned int diff, freq = entry->frequency;
> > > > +
> > > > +		if (freq == CPUFREQ_ENTRY_INVALID)
> > > > +			continue;
> > > > +
> > > > +		diff = abs(freq - target_freq);
> > > 
> > > Why would you consider frequencies that are below where you want to be?
> > 
> > Say you have 800 MHz and 1600 MHz to choose from and the request if for
> > 900 MHz.  The other may be way off (and different voltage for that matter).
> 
> Are there really chips with such crappy choices?

One of my test boxes has three: 1330, 1060 and 800 MHz.

> That said, for some scenarios you really do have to pick 1600 because
> otherwise the work will not be able to complete in time and the whole
> purpose of the machine is moot.
> 
> That argues for more than a target frequency argument.
> 
> Furthermore, depending on the idle capabilities of the platform, 1600
> might still be the better choice, it gives idle time in which it could
> power gate the complete thing, still yielding better perf/watt than 100%
> pegged at 800.
> 
> So I'm not at all sure the nearest freq is a sane general policy.

OK

I thought that changing it to selecting the closest frequency above the
target would make us practically avoid the min, because then we would only
get to it if we were asked for it explicitly.  Nevertheless, I thought I would
try it anyway, so I ran that algo on the test box mentioned above.  And pretty
much as expected I ended up with marginal residency in the 800 MHz state
(below 1%) even if the system was very lightly loaded and the vast majority
of time was spent in the 1060 MHz one. So that wasn't a desirable outcome.

Then, I changed the algorithm to look for the closest frequencies above (f_up)
and below (f_down) the target and then choose f_down if

	f_down + ((f_up - f_down) / 4) > target

and f_up otherwise.  That still skews the choice towards higher frequencies,
but not as much and the 800 MHz residency on the almost idle system has mostly
come back with that modification.

So I'll send an update of the $subject patch with that implemented in case
someone wants to see how it goes.

Thanks,
Rafael

