From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 18 Nov 2014 22:51:30 +0530
Message-ID: <20141118172130.GA29590@intel-desktop>
References: <20141118054537.GA28516@intel-desktop>
 <CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbaKRRVC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Nov 2014 12:21:02 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>, srinidhi.kasagar@intel.com

On Tue, Nov 18, 2014 at 04:33:47PM +0530, Viresh Kumar wrote:
> On 18 November 2014 11:15, Srinidhi Kasagar <srinidhi.kasagar@intel.com> wrote:
> > diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> > +static int parse_freq(struct sfi_table_header *table)
> 

[..]

> > +
> > +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       unsigned int i, result = 0, valid_states = 0;
> > +       unsigned int cpu = policy->cpu;
> > +       struct sfi_cpufreq_data *data;
> > +       struct sfi_cpufreq_performance *perf;
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
> 
> I told you this before and this is still broken:
> 
> > Your code is dependent on policy->cpu at multiple places and it can change on
> > CPU hotplug.
> 
> To explain again, in your case a single policy will have two CPUs.
> Groups are: 0-1 and 2-3.
> policy->cpu for both policies are 0 and 2.
Not anymore now..I have fixed it in my earlier version.

$ cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus 
0
1
2
3

$  cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus   
0
1
2
3

> 
> If we hotplug out cpu 0 or cpu 2, policy->cpu will be updated to 1 and 3.
> 
> And then the above per-cpu variable access will return NULL, as you
> have initialized
> them just for 0 and 2, not 1 and 3.

Srinidhi
