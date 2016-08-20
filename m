From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Sat, 20 Aug 2016 03:06:06 +0200
Message-ID: <15494617.fGGDIpuQfN@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <000301d1f57b$9e1fed10$da5fc730$@net> <20160819144729.GL10121@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42396 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754781AbcHTBAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 21:00:32 -0400
In-Reply-To: <20160819144729.GL10121@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Doug Smythies <dsmythies@telus.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On Friday, August 19, 2016 04:47:29 PM Peter Zijlstra wrote:
> On Sat, Aug 13, 2016 at 08:59:01AM -0700, Doug Smythies wrote:
> > My previous replies (and see below) have suggested that some filtering
> > is needed on the target pstate, otherwise, and dependant on the type of
> > workload, it tends to oscillate.
> > 
> > I added the IIR (Infinite Impulse Response) filter that I have suggested in the past:
> 
> One question though; why is this filter intel_pstate specific? Should we
> not do this in generic code?

The intel_pstate algorithm is based on the feedback registers and I'm not sure
if the same effect appears if utilization is computed in a different way.

> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index c43ef55..262ec5f 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1313,7 +1318,74 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
> >         cpu->iowait_boost >>= 1;
> > 
> >         pstate = cpu->pstate.turbo_pstate;
> 
> > +       unfiltered_target = (pstate + (pstate >> 2)) * busy_frac;
> 
> > +       duration_ns = cpu->sample.time - cpu->last_sample_time;
> > +
> > +       scaled_gain = div_u64(int_tofp(duration_ns) *
> > +               int_tofp(pid_params.p_gain_pct), int_tofp(pid_params.sample_rate_ns));
> 
> Drop int_to_fp() on one of the dividend terms and in the divisor. Same
> end result since they divide away against one another but reduces the
> risk of overflow.
> 
> Also, sample_rate_ns, really!? A rate is in [1/s], should that thing be
> called period_ns ?

That's an old name that hasn't been changed for quite a while.  That said
"period" or "interval" would be better.

Thanks,
Rafael

