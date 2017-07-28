From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/9] cpufreq: Use transition_delay_us for legacy
 governors as well
Date: Fri, 28 Jul 2017 10:18:15 +0530
Message-ID: <20170728044815.GS352@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <46734e7c365a024632e8b1d52990d4400899727b.1500373914.git.viresh.kumar@linaro.org>
 <20170724161719.g7d5puvyk2lpinyw@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:38682 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdG1EsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 00:48:19 -0400
Received: by mail-pg0-f49.google.com with SMTP id k190so40836773pgk.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 21:48:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170724161719.g7d5puvyk2lpinyw@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On 24-07-17, 18:17, Peter Zijlstra wrote:
> On Wed, Jul 19, 2017 at 03:42:42PM +0530, Viresh Kumar wrote:
> > The policy->transition_delay_us field is used only by the schedutil
> > governor currently, and this field describes how fast the driver wants
> > the cpufreq governor to change CPUs frequency. It should rather be a
> > common thing across all governors, as it doesn't have any schedutil
> > dependency here.
> > 
> > Create a new helper cpufreq_policy_transition_delay_us() to get the
> > transition delay across all governors.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c          | 15 +++++++++++++++
> >  drivers/cpufreq/cpufreq_governor.c |  9 +--------
> >  include/linux/cpufreq.h            |  1 +
> >  kernel/sched/cpufreq_schedutil.c   | 11 +----------
> >  4 files changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 9bf97a366029..c426d21822f7 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -524,6 +524,21 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> >  
> > +unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> > +{
> > +	unsigned int latency;
> > +
> > +	if (policy->transition_delay_us)
> > +		return policy->transition_delay_us;
> > +
> > +	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> > +	if (latency)
> > +		return latency * LATENCY_MULTIPLIER;
> > +
> > +	return LATENCY_MULTIPLIER;
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
> 
> I realize you're just moving code about, but _why_ are we doing that
> division?

We are doing division by NSEC_PER_USEC because the values of
sampling_rate and rate_limit_us are in us, while transition_latency is
in ns.

We shouldn't be breaking the userspace ABI and so if we want, we can
actually make transition_latency be stored in us instead.

Though I am not sure why are we multiplying with LATENCY_MULTIPLIER
(1000) as that seems to be a huge value.

-- 
viresh
