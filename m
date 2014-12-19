From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v8] cpufreq: Add SFI based cpufreq driver support
Date: Fri, 19 Dec 2014 20:38:32 +0530
Message-ID: <20141219150832.GA21139@intel-desktop>
References: <20141218085900.GA31027@intel-desktop>
 <CAJvTdKkpsVGoN=v8h_=4uW=MJ=THPL1C4SKAMM9MBrQM4k30FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaLSPHT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Dec 2014 10:07:19 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdKkpsVGoN=v8h_=4uW=MJ=THPL1C4SKAMM9MBrQM4k30FA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

On Fri, Dec 19, 2014 at 02:20:00AM -0500, Len Brown wrote:
> > v8:
> ...
> 
> > diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> > new file mode 100644
> > index 000000000000..f9a913242537
> > --- /dev/null
> > +++ b/drivers/cpufreq/sfi-cpufreq.c
> > @@ -0,0 +1,144 @@
> > +/*
> > + *  SFI Performance States Driver
> ...
> > +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       struct cpufreq_frequency_table *freq_table;
> > +       unsigned int i, result;
> > +
> > +       freq_table = kzalloc(sizeof(*freq_table) *
> > +                       (num_freq_table_entries + 1), GFP_KERNEL);
> > +       if (!freq_table)
> > +               return -ENOMEM;
> > +
> > +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> > +
> > +       policy->cpuinfo.transition_latency = 100000;    /* 100us */
> 
> It would be better to use CPUFREQ_ETERNAL here
> than to make up a number (100us)  asserting that it is valid for all possible
> cores that might run this driver.   If we put a real number here, then people
> will argue about how real it is when a different core runs this driver.
> The fact of the matter is that only ondemand *consumes* this number,
> and it compares it to 10,000,000 to see if can load.  Then it compares
> MIN_LATENCY_MULTIPLIER (20) * latency, as a floor for min_sampling_rate,
> which would otherwise default to MICRO_FREQUENCY_MIN_SAMPLE_RATE (10000).
> 
> ie. all number you give here that are less than
> MICRO_FREQUENCY_MIN_SAMPLE_RATE/MIN_LATENCY_MULTIPLIER = 500us
> are equivalent.
> 
> So just use -1 and avoid getting into a debate as to what this number really is.

I don't get your point.

* Why should we say the transition_latency as "unknown" or ETERNAL
knowing the fact that this system always has the latency of 100 us?
* If you set the transition_latency as -1/ETERNAL, then the
interactive and ondemand governors will not load because
the following condition will be true in __cpufreq_governor
and thus fallback to performance.

 if (policy->governor->max_transition_latency &&
            policy->cpuinfo.transition_latency >
            policy->governor->max_transition_latency) {


$cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency
4294967295

am i missing something?

> 
> > +       for (i = 0; i < num_freq_table_entries; i++) {
> > +               /* initialize the freq table */
> 
> above comment adds no value to the two lines below, so you can remove
> the comment.
> 
> > +               freq_table[i].driver_data = i;
> > +               freq_table[i].frequency = sfi_cpufreq_array[i].freq_mhz * 1000;
> > +       }
> > +       freq_table[i].frequency = CPUFREQ_TABLE_END;
> > +
> > +       result = cpufreq_table_validate_and_show(policy, freq_table);
> 
> policy is PER_CPU
> and sfi_cpufreq_cpu_init() will be called for every CPU in the system, yes?
> So here we are kzalloc-ing and initializing an identical freq_table
> for all the CPUs in the system.
> 
> But it does not appears that there is any per-cpu-specific data in that table.
> 
> As they are identical, can we allocate just one
> and point all cpus to it?  We would free that one
> after the last CPU has exited.

Yes, this can be done now as there is no per-cpu specific data.

Srinidhi
