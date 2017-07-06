From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 07/10] arm64: wire cpufreq input data for
 frequency-invariant accounting up to the arch
Date: Thu, 6 Jul 2017 16:18:30 +0530
Message-ID: <20170706104830.GG13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-8-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-8-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06-07-17, 10:49, Dietmar Eggemann wrote:
> Define arch_set_freq_scale to be the arch_topology "driver" function
> topology_set_freq_scale() to let FIE work correctly.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm64/include/asm/topology.h | 5 +++++
>  arch/arm64/kernel/topology.c      | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 8b57339823e9..d9cbb289e295 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -32,6 +32,11 @@ int pcibus_to_node(struct pci_bus *bus);
>  
>  #endif /* CONFIG_NUMA */
>  
> +#include <linux/arch_topology.h>
> +
> +/* Subscribe for input data for frequency-invariant load-tracking */
> +#define arch_set_freq_scale topology_set_freq_scale
> +
>  #include <asm-generic/topology.h>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

>  
>  #endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 79244c75eaec..6cbb6315e493 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -11,7 +11,6 @@
>   * for more details.
>   */
>  
> -#include <linux/arch_topology.h>

??

-- 
viresh
