From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 06/10] cpufreq / sched: Add interface to get
 utilization values
Date: Wed, 16 May 2018 15:25:57 -0700
Message-ID: <1526509557.61700.95.camel@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
         <20180516064055.gbmemcxsv2qvx67g@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516064055.gbmemcxsv2qvx67g@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-05-16 at 12:10 +0530, Viresh Kumar wrote:
> On 15-05-18, 21:49, Srinivas Pandruvada wrote:
> > Added cpufreq_get_sched_util() to get the CFS, DL and max
> > utilization
> > values for a CPU. This is required for getting utilization values
> > for cpufreq drivers outside of kernel/sched folder.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> >  include/linux/sched/cpufreq.h |  2 ++
> >  kernel/sched/cpufreq.c        | 23 +++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/sched/cpufreq.h
> > b/include/linux/sched/cpufreq.h
> > index 5966744..a366600 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -20,6 +20,8 @@ void cpufreq_add_update_util_hook(int cpu, struct
> > update_util_data *data,
> >                         void (*func)(struct update_util_data *data,
> > u64 time,
> >  				    unsigned int flags));
> >  void cpufreq_remove_update_util_hook(int cpu);
> > +void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
> > +			    unsigned long *util_dl, unsigned long
> > *max);
> >  #endif /* CONFIG_CPU_FREQ */
> >  
> >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> > index 5e54cbc..36e2839 100644
> > --- a/kernel/sched/cpufreq.c
> > +++ b/kernel/sched/cpufreq.c
> > @@ -60,3 +60,26 @@ void cpufreq_remove_update_util_hook(int cpu)
> >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu),
> > NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> > +
> > +/**
> > + * cpufreq_get_sched_util - Get utilization values.
> > + * @cpu: The targeted CPU.
> > + *
> > + * Get the CFS, DL and max utilization.
> > + * This function allows cpufreq driver outside the kernel/sched to
> > access
> > + * utilization value for a CPUs run queue.
> > + */
> > +void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
> > +			    unsigned long *util_dl, unsigned long
> > *max)
> > +{
> > +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> 
> What will happen when schedutil is compiled in the kernel but
> ondemand
> is the one getting used currently ?
It should still work. The only reason I have to use ifdef because of
compile issues when CONFIG_CPU_FREQ_SCHEDUTIL is not defined.
The reason for that is that cpu_util_cfs() and cpu_util_dl() is defined
under #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL.
The actual code inside the cpu_util_cfs() and cpu_util_dl() uses
rq->cfs.avg.util_avg and rq->cfs.avg.util_avg, which are updated
irrespective of cpufreq governor. May be better to remove ifdefs for
cpu_util_dl() and cpu_util_cfs().

Thanks,
Srinivas
> 
> > +	struct rq *rq = cpu_rq(cpu);
> > +
> > +	*max = arch_scale_cpu_capacity(NULL, cpu);
> > +	*util_cfs = cpu_util_cfs(rq);
> > +	*util_dl  = cpu_util_dl(rq);
> > +#else
> > +	*util_cfs = *util_dl = 1;
> > +#endif
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_get_sched_util);
> > -- 
> > 2.9.5
> 
> 
