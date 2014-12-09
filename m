From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v6] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 9 Dec 2014 16:46:53 +0530
Message-ID: <20141209111652.GA26691@intel-desktop>
References: <20141125054226.GA20738@intel-desktop>
 <CAJvTdKku-ioem5iP0xz=uFkom2XMsKMrRHQ7k8vD5FFKt33P9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5571 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490AbaLILPX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 06:15:23 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdKku-ioem5iP0xz=uFkom2XMsKMrRHQ7k8vD5FFKt33P9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

On Wed, Dec 03, 2014 at 10:21:57PM -0500, Len Brown wrote:
> I like this trend:

..and the trend will continue in the next version
as well :) Thank you and Viresh..

> 
> drivers/cpufreq/sfi-cpufreq.c |  529 +++++++++++++++++++++++++++++++++++++++++
> v1: drivers/cpufreq/sfi-cpufreq.c |  426
> +++++++++++++++++++++++++++++++++++++++++
> v2: drivers/cpufreq/sfi-cpufreq.c |  332
> +++++++++++++++++++++++++++++++++++++++++
> v3: drivers/cpufreq/sfi-cpufreq.c |  326
> +++++++++++++++++++++++++++++++++++++++++
> v4: drivers/cpufreq/sfi-cpufreq.c |  317
> +++++++++++++++++++++++++++++++++++++++++
> v5: drivers/cpufreq/sfi-cpufreq.c         |  238
> +++++++++++++++++++++++++++++++++
> v6: drivers/cpufreq/sfi-cpufreq.c         |  230
> +++++++++++++++++++++++++++++++++
> 
> 
> 
> On Tue, Nov 25, 2014 at 12:42 AM, Srinidhi Kasagar
> <srinidhi.kasagar@intel.com> wrote:
> 
> > +++ b/drivers/cpufreq/sfi-cpufreq.c
> 
> > +#define SFI_FREQ_MASK          0xff00
> > +
> > +static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
> > +static DEFINE_MUTEX(performance_mutex);
> 
> I'm not sure that cpufreq is able to call driver init's in parallel,
> so I'm not sure that the driver init needs to lock against other
> invocations of itself.
> But even if called in parallel, what data does performance_mutex
> actually protect?

hmm..I can drop this mutex stuff then..

[...]

> > +static int parse_freq(struct sfi_table_header *table)
> > +{
> > +       struct sfi_table_simple *sb;
> > +
> > +       sb = (struct sfi_table_simple *)table;
> > +
> > +       sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb, struct sfi_freq_table_entry);
> > +       f_entry = (struct sfi_freq_table_entry *)sb->pentry;
> 
> are we sure that this pointer will still be valid after
> sfi_table_parse() returns?
> sfi_table_parse() appears to do an sfi_table_put() at the end...

That's why there used to be a memcpy earlier. I checked the instances
of sfi_table_parse and they mostly keep memcpy if that's global
and in our case, it is. So, I will retain that memcpy..

[...]

> > +static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> > +{
> > +       u32 lo, hi, sfi_ctrl;
> > +       struct cpufreq_frequency_table *pos;
> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
> > +
> > +       rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> > +       lo &= SFI_FREQ_MASK;
> > +
> > +       cpufreq_for_each_entry(pos, data->freq_table) {
> > +               sfi_ctrl = data->sfi_data->states[pos->driver_data].ctrl_val
> > +                       & SFI_FREQ_MASK;
> > +               if (sfi_ctrl == lo)
> > +                       return pos->frequency;
> > +       }
> > +       return data->freq_table[0].frequency;
> > +}
> 
> Not obvious (to me) that this in-accurate return value is more useful
> to the caller than simply returning data->freq_table[state].frequency.
> 
> Unless the caller is taking into account for hardware coordination
> of multiple PERF_CTRL MSR's, then it is garbage-in/garbage-out,
> not to mention that by the time this value is used, it may have changed...
> 
> I'm curious what breaks in your Android setup if you don't supply
> a get_cur_freq() at all...

Hmm..I do not think there is any mandate that the driver
should provide ->get callbacks to the core. However i'm
not sure if any library tools like libcpupower needs this.

I don't mind dropping this ->get callback, the driver still
works and I'm happy with the scaling_setspeed.

Srinidhi
