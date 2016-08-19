From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection
 algorithm for Core
Date: Fri, 19 Aug 2016 16:47:29 +0200
Message-ID: <20160819144729.GL10121@twins.programming.kicks-ass.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <1572483.RZjvRFdxPx@vostro.rjw.lan>
 <001b01d1ee1c$e6a6a170$b3f3e450$@net>
 <10156236.RI1knH5Wfs@vostro.rjw.lan>
 <000301d1f57b$9e1fed10$da5fc730$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbcHSOrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 10:47:42 -0400
Content-Disposition: inline
In-Reply-To: <000301d1f57b$9e1fed10$da5fc730$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On Sat, Aug 13, 2016 at 08:59:01AM -0700, Doug Smythies wrote:
> My previous replies (and see below) have suggested that some filtering
> is needed on the target pstate, otherwise, and dependant on the type of
> workload, it tends to oscillate.
> 
> I added the IIR (Infinite Impulse Response) filter that I have suggested in the past:

One question though; why is this filter intel_pstate specific? Should we
not do this in generic code?

> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c43ef55..262ec5f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1313,7 +1318,74 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
>         cpu->iowait_boost >>= 1;
> 
>         pstate = cpu->pstate.turbo_pstate;

> +       unfiltered_target = (pstate + (pstate >> 2)) * busy_frac;

> +       duration_ns = cpu->sample.time - cpu->last_sample_time;
> +
> +       scaled_gain = div_u64(int_tofp(duration_ns) *
> +               int_tofp(pid_params.p_gain_pct), int_tofp(pid_params.sample_rate_ns));

Drop int_to_fp() on one of the dividend terms and in the divisor. Same
end result since they divide away against one another but reduces the
risk of overflow.

Also, sample_rate_ns, really!? A rate is in [1/s], should that thing be
called period_ns ?

> +       if (scaled_gain > int_tofp(100))
> +               scaled_gain = int_tofp(100);

> +       if (scaled_gain < int_tofp(pid_params.p_gain_pct))
> +               scaled_gain = int_tofp(pid_params.p_gain_pct);
> +
> +       /*
> +        * Bandwidth limit the output. For now, re-task p_gain_pct for this purpose.
> +        * Use a smple IIR (Infinite Impulse Response) filter.
> +        */
> +       cpu->sample.target = div_u64((int_tofp(100) - scaled_gain) *
> +                       cpu->sample.target + scaled_gain *
> +                       unfiltered_target, int_tofp(100));


Really hard to read that stuff, maybe cure with a comment:

	/*
	 *       g = dt*p / period
	 *
	 * target' = (1 - g)*target  +  g*input
	 */

> +
> +       return fp_toint(cpu->sample.target + (1 << (FRAC_BITS-1)));
>  }
