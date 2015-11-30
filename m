From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 1/8] ARM: initialize cpu_scale to its default
Date: Mon, 30 Nov 2015 12:13:02 +0100
Message-ID: <CAKfTPtCVv_dwAu-PVfkmpCPjNMo_nnLQzr2Yc1p2oFYOORH=GA@mail.gmail.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com> <1448288921-30307-2-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32874 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbbK3LNX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 06:13:23 -0500
Received: by lfaz4 with SMTP id z4so191794597lfa.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 03:13:22 -0800 (PST)
In-Reply-To: <1448288921-30307-2-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 23 November 2015 at 15:28, Juri Lelli <juri.lelli@arm.com> wrote:
> Instead of looping through all cpus calling set_capacity_scale, we can
> initialise cpu_scale per-cpu variables to SCHED_CAPACITY_SCALE with their
> definition.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 08b7847..ec279d1 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -40,7 +40,7 @@
>   * to run the rebalance_domains for all idle cores and the cpu_capacity can be
>   * updated during this sequence.
>   */
> -static DEFINE_PER_CPU(unsigned long, cpu_scale);
> +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>
>  unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> @@ -306,8 +306,6 @@ void __init init_cpu_topology(void)
>                 cpu_topo->socket_id = -1;
>                 cpumask_clear(&cpu_topo->core_sibling);
>                 cpumask_clear(&cpu_topo->thread_sibling);
> -
> -               set_capacity_scale(cpu, SCHED_CAPACITY_SCALE);
>         }
>         smp_wmb();

FWIW, Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> --
> 2.2.2
>
