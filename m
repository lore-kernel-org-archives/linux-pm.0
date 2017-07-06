From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 05/10] arm: wire frequency-invariant accounting
 support up to the task scheduler
Date: Thu, 6 Jul 2017 16:16:58 +0530
Message-ID: <20170706104658.GE13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-6-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-6-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06-07-17, 10:49, Dietmar Eggemann wrote:
> Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
> changed the wiring which now has to be done by associating
> arch_scale_freq_capacity with the actual implementation provided
> by the architecture.
> 
> Define arch_scale_freq_capacity to use the arch_topology "driver"
> function topology_get_freq_scale() for the task scheduler's
> frequency-invariant accounting instead of the default
> arch_scale_freq_capacity() in kernel/sched/sched.h.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Reviewed-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/include/asm/topology.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index ca05d1b90411..57aebfa03e24 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -29,6 +29,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
>  /* Subscribe for input data for frequency-invariant load-tracking */
>  #define arch_set_freq_scale topology_set_freq_scale
>  
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_capacity topology_get_freq_scale
> +
>  #else
>  
>  static inline void init_cpu_topology(void) { }

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
