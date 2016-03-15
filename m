From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Tue, 15 Mar 2016 13:46:30 -0700
Message-ID: <20160315204630.30639.60702@quark.deferred.io>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EF6.5040005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E85EF6.5040005@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Quoting Dietmar Eggemann (2016-03-15 12:13:58)
> On 14/03/16 05:22, Michael Turquette wrote:
> > arch_scale_freq_capacity is weird. It specifies an arch hook for an
> > implementation that could easily vary within an architecture or even a
> > chip family.
> > 
> > This patch helps to mitigate this weirdness by defaulting to the
> > cpufreq-provided implementation, which should work for all cases where
> > CONFIG_CPU_FREQ is set.
> > 
> > If CONFIG_CPU_FREQ is not set, then try to use an implementation
> > provided by the architecture. Failing that, fall back to
> > SCHED_CAPACITY_SCALE.
> > 
> > It may be desirable for cpufreq drivers to specify their own
> > implementation of arch_scale_freq_capacity in the future. The same is
> > true for platform code within an architecture. In both cases an
> > efficient implementation selector will need to be created and this patch
> > adds a comment to that effect.
> 
> For me this independence of the scheduler code towards the actual
> implementation of the Frequency Invariant Engine (FEI) was actually a
> feature.

I do not agree that it is a strength; I think it is confusing. My
opinion is that cpufreq drivers should implement
arch_scale_freq_capacity. Having a sane fallback
(cpufreq_scale_freq_capacity) simply means that you can remove the
boilerplate from the arm32 and arm64 code, which is a win.

Furthermore, if we have multiple competing implementations of
arch_scale_freq_invariance, wouldn't it be better for all of them to
live in cpufreq drivers? This means we would only need to implement a
single run-time "selector".

On the other hand, if the implementation lives in arch code and we have
various implementations of arch_scale_freq_capacity within an
architecture, then each arch would need to implement this selector
function. Even worse then if we have a split where some implementations
live in drivers/cpufreq (e.g. intel_pstate) and others in arch/arm and
others in arch/arm64 ... now we have three selectors.

Note that this has nothing to do with cpu microarch invariance. I'm
happy for that to stay in arch code because we can have heterogeneous
cpus that do not scale frequency, and thus would not enable cpufreq.
But if your platform scales cpu frequency, then really cpufreq should be
in the loop.

> 
> In EAS RFC5.2 (linux-arm.org/linux-power.git energy_model_rfc_v5.2 ,
> which hasn't been posted to LKML) we establish the link in the ARCH code
> (arch/arm64/include/asm/topology.h).

Right, sorry again about preemptively posting the patch. Total brainfart
on my part.

> 
> #ifdef CONFIG_CPU_FREQ
> #define arch_scale_freq_capacity cpufreq_scale_freq_capacity
> ...
> +#endif

The above is no longer necessary with this patch. Same question as
above: why insist on the arch boilerplate?

Regards,
Mike

> 
> > 
> > Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
> > ---
> >  kernel/sched/sched.h | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 469d11d..37502ea 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1368,7 +1368,21 @@ static inline int hrtick_enabled(struct rq *rq)
> >  #ifdef CONFIG_SMP
> >  extern void sched_avg_update(struct rq *rq);
> >  
> > -#ifndef arch_scale_freq_capacity
> > +/*
> > + * arch_scale_freq_capacity can be implemented by cpufreq, platform code or
> > + * arch code. We select the cpufreq-provided implementation first. If it
> > + * doesn't exist then we default to any other implementation provided from
> > + * platform/arch code. If those do not exist then we use the default
> > + * SCHED_CAPACITY_SCALE value below.
> > + *
> > + * Note that if cpufreq drivers or platform/arch code have competing
> > + * implementations it is up to those subsystems to select one at runtime with
> > + * an efficient solution, as we cannot tolerate the overhead of indirect
> > + * functions (e.g. function pointers) in the scheduler fast path
> > + */
> > +#ifdef CONFIG_CPU_FREQ
> > +#define arch_scale_freq_capacity cpufreq_scale_freq_capacity
> > +#elif !defined(arch_scale_freq_capacity)
> >  static __always_inline
> >  unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
> >  {
> > 
