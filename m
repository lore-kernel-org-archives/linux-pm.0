From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Thu, 9 Oct 2014 23:38:26 +0530
Message-ID: <20141009180826.GA32265@intel-desktop>
References: <20141007140734.GB24200@intel-desktop>
 <CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
 <20141008191454.GA6504@intel-desktop>
 <CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43230 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbaJIKIr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Oct 2014 06:08:47 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

On Thu, Oct 09, 2014 at 09:33:24AM +0530, Viresh Kumar wrote:
> On 9 October 2014 00:44, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > On Tue, Oct 07, 2014 at 03:52:42PM +0530, Viresh Kumar wrote:
> >> > +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> >> > +                               unsigned int index)
> >> > +{
> >> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> >> > +       struct sfi_processor_performance *perf;
> >> > +       unsigned int next_perf_state = 0; /* Index into perf table */
> >> > +       u32 lo, hi;
> >>
> >> You meant unsigned int only?
> >
> > Yes.
> 
> Then use that only to be aligned with other data types.

Sorry, I meant it should be u32 as they are register reads.

> 
> >> > +       perf = data->sfi_data;
> >> > +       next_perf_state = data->freq_table[index].driver_data;
> >> > +       if (perf->state == next_perf_state) {
> >>
> >> Can this happen? Probably cpufreq core will never do it ?
> >
> > I think it did. Let me keep this.
> 
> Okay, but how? The cpufreq core doesn't propagate call to ->target_index()
> if the freq isn't changing.. Please check if this is getting hit at all or not.

I guess if you offline a cpu and then bring it online, then even though
there is no change in frequency, the core calls ->target_index().

am i missing something?

> 
> >> > +static int sfi_cpufreq_resume(struct cpufreq_policy *policy)
> >> > +{
> >> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> >>
> >> Your code is dependent on policy->cpu at multiple places and it can change on
> >> CPU hotplug. You should worry about it only if there can be more than one CPU
> >> in a single policy, which doesn't look like the case.
> >
> > Not sure what do you mean by not using policy->cpu. I need all of these
> > to support hotplug. Can you elaborate if you mean otherwise please?
> 
> So you are using policy->cpu to set/get a value out of a per-cpu variable.
> Now if a policy has 4 cpus then per-cpu variable will only be initialized for
> policy->cpu and not others.
> 
> But now if we do hotplug of that cpu, policy->cpu will move to next cpu.
> In this case accessing the per-cpu variable will not be a good idea :)

Not sure what I can do with this. Let me have a look.

Srinidhi
