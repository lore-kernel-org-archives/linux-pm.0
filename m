From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 04/10] arm: wire cpufreq input data for
 frequency-invariant accounting up to the arch
Date: Thu, 6 Jul 2017 16:12:58 +0530
Message-ID: <20170706104258.GC13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-5-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-5-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06-07-17, 10:49, Dietmar Eggemann wrote:
> Define arch_set_freq_scale to be the arch_topology "driver" function
> topology_set_freq_scale() to let FIE work correctly.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm/include/asm/topology.h | 5 +++++
>  arch/arm/kernel/topology.c      | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 370f7a732900..ca05d1b90411 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,11 @@ void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  
> +#include <linux/arch_topology.h>
> +
> +/* Subscribe for input data for frequency-invariant load-tracking */
> +#define arch_set_freq_scale topology_set_freq_scale
> +
>  #else
>  
>  static inline void init_cpu_topology(void) { }
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index bf949a763dbe..2c47a76c67b0 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -11,7 +11,6 @@
>   * for more details.
>   */
>  
> -#include <linux/arch_topology.h>

Why is this diff part of this patch ?

-- 
viresh
