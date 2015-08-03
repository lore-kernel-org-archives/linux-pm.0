From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv5 PATCH 01/46] arm: Frequency invariant scheduler
 load-tracking support
Date: Mon, 3 Aug 2015 11:22:50 +0200
Message-ID: <CAKfTPtBsx++wuWjT8XwpUS68ip=_d9BzqXb3SB7Un92WzJo-Gg@mail.gmail.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33595 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbHCJXM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 05:23:12 -0400
Received: by labpt2 with SMTP id pt2so11516753lab.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 02:23:11 -0700 (PDT)
In-Reply-To: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Yuyang Du <yuyang.du@intel.com>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Hi Morten,


On 7 July 2015 at 20:23, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> From: Morten Rasmussen <Morten.Rasmussen@arm.com>
>

[snip]

> -
>  #endif
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 08b7847..9c09e6e 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -169,6 +169,23 @@ static void update_cpu_capacity(unsigned int cpu)
>                 cpu, arch_scale_cpu_capacity(NULL, cpu));
>  }
>
> +/*
> + * Scheduler load-tracking scale-invariance
> + *
> + * Provides the scheduler with a scale-invariance correction factor that
> + * compensates for frequency scaling (arch_scale_freq_capacity()). The scaling
> + * factor is updated in smp.c
> + */
> +unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
> +{
> +       unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));

access to cpu_freq_capacity to should be put under #ifdef CONFIG_CPU_FREQ.

Why haven't you moved arm_arch_scale_freq_capacity in smp.c as
everything else for frequency in-variance is already in this file ?
This should also enable you to remove
DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity); from topology.h

Vincent

> +
> +       if (!curr)
> +               return SCHED_CAPACITY_SCALE;
> +
> +       return curr;
> +}
> +
>  #else
>  static inline void parse_dt_topology(void) {}
>  static inline void update_cpu_capacity(unsigned int cpuid) {}
> --
> 1.9.1
>
