From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/6] arm: wire frequency-invariant accounting support up
 to the task scheduler
Date: Mon, 12 Jun 2017 16:30:50 +0200
Message-ID: <CAKfTPtCHOsEDMDTiBvu-vdLgNJjD_j=hancL8RTJHOe9a6gJag@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-4-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36395 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbdFLObN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 10:31:13 -0400
Received: by mail-lf0-f42.google.com with SMTP id o83so51849233lff.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 07:31:12 -0700 (PDT)
In-Reply-To: <20170608075513.12475-4-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
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

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  arch/arm/include/asm/topology.h | 5 +++++
>  arch/arm/kernel/topology.c      | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 370f7a732900..a56a9e24f4c0 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,11 @@ void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>
> +#include <linux/arch_topology.h>
> +
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_capacity topology_get_freq_scale
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
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> --
> 2.11.0
>
