From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency switching
Date: Tue, 29 Mar 2016 14:10:17 +0200
Message-ID: <2467412.EHWtmERkoP@vostro.rjw.lan>
References: <7262976.zPkLj56ATU@vostro.rjw.lan> <25154681.B5BGJ94JlQ@vostro.rjw.lan> <20160328070341.GJ32495@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55200 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751558AbcC2MH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 08:07:58 -0400
In-Reply-To: <20160328070341.GJ32495@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Monday, March 28, 2016 12:33:41 PM Viresh Kumar wrote:
> forgot to review acpi update earlier ..
> 
> On 22-03-16, 02:53, Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> > +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > @@ -458,6 +458,43 @@ static int acpi_cpufreq_target(struct cp
> >  	return result;
> >  }
> >  
> > +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > +				      unsigned int target_freq)
> > +{
> > +	struct acpi_cpufreq_data *data = policy->driver_data;
> > +	struct acpi_processor_performance *perf;
> > +	struct cpufreq_frequency_table *entry;
> > +	unsigned int next_perf_state, next_freq, freq;
> > +
> > +	/*
> > +	 * Find the closest frequency above target_freq.
> > +	 *
> > +	 * The table is sorted in the reverse order with respect to the
> > +	 * frequency and all of the entries are valid (see the initialization).
> > +	 */
> > +	entry = data->freq_table;
> > +	do {
> > +		entry++;
> > +		freq = entry->frequency;
> > +	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> 
> Consider this table:
> 
> 11000
> 10000
> 9000
> 
> And a target-freq of 10000.
> 
> Wouldn't you end up selecting 11000 ? Or did I misread it ?

In that case the loop will break for freq = 9000 (as per the above
freq >= freq_target check), so it looks like you've misread it.

Thanks,
Rafael

