From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/6] arm: wire cpu-invariant accounting support up to the
 task scheduler
Date: Mon, 12 Jun 2017 16:31:52 +0200
Message-ID: <CAKfTPtDminixSd+KKt4tRWUBF3ere8oQdzP-XOKpmmmkCAhX6g@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-5-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33281 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbdFLOcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 10:32:14 -0400
Received: by mail-lf0-f48.google.com with SMTP id m77so27223878lfe.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 07:32:14 -0700 (PDT)
In-Reply-To: <20170608075513.12475-5-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Commit 8cd5601c5060 ("sched/fair: Convert arch_scale_cpu_capacity() from
> weak function to #define") changed the wiring which now has to be done
> by associating arch_scale_cpu_capacity with the actual implementation
> provided by the architecture.
>
> Define arch_scale_cpu_capacity to use the arch_topology "driver"
> function topology_get_cpu_scale() for the task scheduler's cpu-invariant
> accounting instead of the default arch_scale_cpu_capacity() in
> kernel/sched/sched.h.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  arch/arm/include/asm/topology.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index a56a9e24f4c0..b713e7223bc4 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -29,6 +29,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
>  /* Replace task scheduler's default frequency-invariant accounting */
>  #define arch_scale_freq_capacity topology_get_freq_scale
>
> +/* Replace task scheduler's default cpu-invariant accounting */
> +#define arch_scale_cpu_capacity topology_get_cpu_scale
> +
>  #else
>
>  static inline void init_cpu_topology(void) { }
> --
> 2.11.0
>
