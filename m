From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 08/10] arm64: wire frequency-invariant accounting
 support up to the task scheduler
Date: Thu, 6 Jul 2017 16:18:46 +0530
Message-ID: <20170706104846.GH13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-9-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32960 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdGFKst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 06:48:49 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so9622313pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 03:48:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-9-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Reviewed-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm64/include/asm/topology.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index d9cbb289e295..4fd598b432e6 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -37,6 +37,9 @@ int pcibus_to_node(struct pci_bus *bus);
>  /* Subscribe for input data for frequency-invariant load-tracking */
>  #define arch_set_freq_scale topology_set_freq_scale
>  
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_capacity topology_get_freq_scale
> +
>  #include <asm-generic/topology.h>
>  
>  #endif /* _ASM_ARM_TOPOLOGY_H */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
