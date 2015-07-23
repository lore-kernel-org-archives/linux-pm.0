From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5, 01/46] arm: Frequency invariant scheduler load-tracking
 support
Date: Thu, 23 Jul 2015 22:22:16 +0800
Message-ID: <20150723142216.GA21773@leoy-linaro>
References: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
 <20150721154145.GA23852@leoy-linaro>
 <20150722133103.GA21785@e105550-lin.cambridge.arm.com>
 <20150722145904.GA18354@leoy-linaro>
 <20150723110626.GC21785@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150723110626.GC21785@e105550-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 23, 2015 at 12:06:26PM +0100, Morten Rasmussen wrote:
> On Wed, Jul 22, 2015 at 10:59:04PM +0800, Leo Yan wrote:
> > On Wed, Jul 22, 2015 at 02:31:04PM +0100, Morten Rasmussen wrote:
> > > On Tue, Jul 21, 2015 at 11:41:45PM +0800, Leo Yan wrote:
> > > > Hi Morten,
> > > > 
> > > > On Tue, Jul 07, 2015 at 07:23:44PM +0100, Morten Rasmussen wrote:
> > > > > From: Morten Rasmussen <Morten.Rasmussen@arm.com>
> > > > > 
> > > > > Implements arch-specific function to provide the scheduler with a
> > > > > frequency scaling correction factor for more accurate load-tracking.
> > > > > The factor is:
> > > > > 
> > > > > 	current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)
> > > > > 
> > > > > This implementation only provides frequency invariance. No cpu
> > > > > invariance yet.
> > > > > 
> > > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > > 
> > > > > Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> > > > > 
> > > > > ---
> > > > > arch/arm/include/asm/topology.h |  7 +++++
> > > > >  arch/arm/kernel/smp.c           | 57 +++++++++++++++++++++++++++++++++++++++--
> > > > >  arch/arm/kernel/topology.c      | 17 ++++++++++++
> > > > >  3 files changed, 79 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> > > > > index 370f7a7..c31096f 100644
> > > > > --- a/arch/arm/include/asm/topology.h
> > > > > +++ b/arch/arm/include/asm/topology.h
> > > > > @@ -24,6 +24,13 @@ void init_cpu_topology(void);
> > > > >  void store_cpu_topology(unsigned int cpuid);
> > > > >  const struct cpumask *cpu_coregroup_mask(int cpu);
> > > > >  
> > > > > +#define arch_scale_freq_capacity arm_arch_scale_freq_capacity
> > > > > +struct sched_domain;
> > > > > +extern
> > > > > +unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu);
> > > > > +
> > > > > +DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity);
> > > > > +
> > > > >  #else
> > > > >  
> > > > >  static inline void init_cpu_topology(void) { }
> > > > > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > > > > index cca5b87..a32539c 100644
> > > > > --- a/arch/arm/kernel/smp.c
> > > > > +++ b/arch/arm/kernel/smp.c
> > > > > @@ -677,12 +677,34 @@ static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
> > > > >  static DEFINE_PER_CPU(unsigned long, l_p_j_ref_freq);
> > > > >  static unsigned long global_l_p_j_ref;
> > > > >  static unsigned long global_l_p_j_ref_freq;
> > > > > +static DEFINE_PER_CPU(atomic_long_t, cpu_max_freq);
> > > > > +DEFINE_PER_CPU(atomic_long_t, cpu_freq_capacity);
> > > > > +
> > > > > +/*
> > > > > + * Scheduler load-tracking scale-invariance
> > > > > + *
> > > > > + * Provides the scheduler with a scale-invariance correction factor that
> > > > > + * compensates for frequency scaling through arch_scale_freq_capacity()
> > > > > + * (implemented in topology.c).
> > > > > + */
> > > > > +static inline
> > > > > +void scale_freq_capacity(int cpu, unsigned long curr, unsigned long max)
> > > > > +{
> > > > > +	unsigned long capacity;
> > > > > +
> > > > > +	if (!max)
> > > > > +		return;
> > > > > +
> > > > > +	capacity = (curr << SCHED_CAPACITY_SHIFT) / max;
> > > > > +	atomic_long_set(&per_cpu(cpu_freq_capacity, cpu), capacity);
> > > > > +}
> > > > >  
> > > > >  static int cpufreq_callback(struct notifier_block *nb,
> > > > >  					unsigned long val, void *data)
> > > > >  {
> > > > >  	struct cpufreq_freqs *freq = data;
> > > > >  	int cpu = freq->cpu;
> > > > > +	unsigned long max = atomic_long_read(&per_cpu(cpu_max_freq, cpu));
> > > > >  
> > > > >  	if (freq->flags & CPUFREQ_CONST_LOOPS)
> > > > >  		return NOTIFY_OK;
> > > > > @@ -707,6 +729,10 @@ static int cpufreq_callback(struct notifier_block *nb,
> > > > >  					per_cpu(l_p_j_ref_freq, cpu),
> > > > >  					freq->new);
> > > > >  	}
> > > > > +
> > > > > +	if (val == CPUFREQ_PRECHANGE)
> > > > > +		scale_freq_capacity(cpu, freq->new, max);
> > > > > +
> > > > >  	return NOTIFY_OK;
> > > > >  }
> > > > >  
> > > > > @@ -714,11 +740,38 @@ static struct notifier_block cpufreq_notifier = {
> > > > >  	.notifier_call  = cpufreq_callback,
> > > > >  };
> > > > >  
> > > > > +static int cpufreq_policy_callback(struct notifier_block *nb,
> > > > > +						unsigned long val, void *data)
> > > > > +{
> > > > > +	struct cpufreq_policy *policy = data;
> > > > > +	int i;
> > > > > +
> > > > > +	if (val != CPUFREQ_NOTIFY)
> > > > > +		return NOTIFY_OK;
> > > > > +
> > > > > +	for_each_cpu(i, policy->cpus) {
> > > > > +		scale_freq_capacity(i, policy->cur, policy->max);
> > > > > +		atomic_long_set(&per_cpu(cpu_max_freq, i), policy->max);
> > > > > +	}
> > > > > +
> > > > > +	return NOTIFY_OK;
> > > > > +}
> > > > > +
> > > > > +static struct notifier_block cpufreq_policy_notifier = {
> > > > > +	.notifier_call	= cpufreq_policy_callback,
> > > > > +};
> > > > > +
> > > > >  static int __init register_cpufreq_notifier(void)
> > > > >  {
> > > > > -	return cpufreq_register_notifier(&cpufreq_notifier,
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = cpufreq_register_notifier(&cpufreq_notifier,
> > > > >  						CPUFREQ_TRANSITION_NOTIFIER);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return cpufreq_register_notifier(&cpufreq_policy_notifier,
> > > > > +						CPUFREQ_POLICY_NOTIFIER);
> > > > >  }
> > > > >  core_initcall(register_cpufreq_notifier);
> > > > 
> > > > For "cpu_freq_capacity" structure, could move it into driver/cpufreq
> > > > so that it can be shared by all architectures? Otherwise, every
> > > > architecture's smp.c need register notifier for themselves.
> > > 
> > > We could, but I put it in arch/arm/* as not all architectures might want
> > > this notifier. The frequency scaling factor could be provided based on
> > > architecture specific performance counters instead. AFAIK, the Intel
> > > p-state driver does not even fire the notifiers so the notifier
> > > solution would be redundant code for those platforms.
> > 
> > When i tried to enable EAS on Hikey, i found it's absent related code
> > for arm64; actually this code section can also be reused by arm64,
> > so just brought up this question.
> 
> Yes. We have patches for arm64 if you are interested. We are using them
> for the Juno platforms.

If convenience, please share with me related patches, so i can
directly apply them and do some profiling works.

> > Just now roughly went through the driver
> > "drivers/cpufreq/intel_pstate.c"; that's true it has different
> > implementation comparing to usual ARM SoCs. So i'd like to ask this
> > question with another way: should cpufreq framework provides helper
> > functions for getting related cpu frequency scaling info? If the
> > architecture has specific performance counters then it can ignore
> > these helper functions.
> 
> That is the idea with the notifiers. If the architecture code a specific
> architecture wants to be poked by cpufreq when the frequency is changed
> it should have a way to subscribe to those. Another way of implementing
> it is to let the architecture code call a helper function in cpufreq
> every time the scheduler calls into the architecture code to get the
> scaling factor (arch_scale_freq_capacity()). We actually did it that way
> a couple of versions back using weak functions. It wasn't as clean as
> using the notifiers, but if we make the necessary changes to cpufreq to
> let the architecture code call into cpufreq that could be even better.
> 
> > 
> > > That said, the above solution is not handling changes to policy->max
> > > very well. Basically, we don't inform the scheduler if it has changed
> > > which means that the OPP represented by "100%" might change. We need
> > > cpufreq to keep track of the true max frequency when policy->max is
> > > changed to work out the correct scaling factor instead of having it
> > > relative to policy->max.
> > 
> > i'm not sure understand correctly here. For example, when thermal
> > framework limits the cpu frequency, it will update the value for
> > policy->max, so scheduler will get the correct scaling factor, right?
> > So i don't know what's the issue at here.
> > 
> > Further more, i noticed in the later patches for
> > arch_scale_cpu_capacity(); the cpu capacity is calculated by the
> > property passed by DT, so it's a static value. In some cases, system
> > may constraint the maximum frequency for CPUs, so in this case, will
> > scheduler get misknowledge from arch_scale_cpu_capacity after system
> > has imposed constraint for maximum frequency?
> 
> The issue is first of all to define what 100% means. Is it
> policy->cur/policy->max or policy->cur/uncapped_max? Where uncapped max
> is the max frequency supported by the hardware when not capped in any
> way by governors or thermal framework.
> 
> If we choose the first definition then we have to recalculate the cpu
> capacity scaling factor (arch_scale_cpu_capacity()) too whenever
> policy->max changes such that capacity_orig is updated appropriately.
> 
> The scale-invariance code in the scheduler assumes:
> 
> arch_scale_cpu_capacity()*arch_scale_freq_capacity() = current capacity

This is an important concept, thanks for the explaining.

> ...and that capacity_orig = arch_scale_cpu_capacity() is the max
> available capacity. If we cap the frequency to say, 50%, by setting
> policy->max then we have to reduce arch_scale_cpu_capacity() to 50% to
> still get the right current capacity using the expression above.
> 
> Using the second definition arch_scale_cpu_capacity() can be a static
> value and arch_scale_freq_capacity() is always relative to uncapped_max.
> It seems simpler, but capacity_orig could then be an unavailable
> capacity and hence we would need to introduce a third capacity to track
> the current max capacity and use that for scheduling decisions.
> As you have already discovered the current code is a combination of both
> which is broken when policy->max is reduced.
> 
> Thinking more about it, I would suggest to go with the first definition.
> The scheduler doesn't need to know about currently unavailable compute
> capacity it should balance based on the current situation, so it seems
> to make sense to let capacity_orig reflect the current max capacity.

Agree.

> I would suggest that we fix arch_scale_cpu_capacity() to take
> policy->max changes into account. We need to know the uncapped max
> frequency somehow to do that. I haven't looked into if we can get that
> from cpufreq. Also, we need to make sure that no load-balance code
> assumes that cpus have a capacity of 1024.

Cpufreq framework provides API *cpufreq_quick_get_max()* and
*cpufreq_quick_get()* for inquiry current frequency and max frequency,
but i'm curious if these two functions can be directly called by
scheduler, due they acquire and release locks internally.

Thanks,
Leo Yan
