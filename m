From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Tue, 15 Mar 2016 22:37:44 +0100
Message-ID: <20160315213744.GJ6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [198.137.202.9] ([198.137.202.9]:44676 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752722AbcCOVkz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:40:55 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:12PM -0700, Michael Turquette wrote:
> +++ b/kernel/sched/sched.h
> @@ -1368,7 +1368,21 @@ static inline int hrtick_enabled(struct rq *rq)
>  #ifdef CONFIG_SMP
>  extern void sched_avg_update(struct rq *rq);
>  
> -#ifndef arch_scale_freq_capacity

> +#ifdef CONFIG_CPU_FREQ
> +#define arch_scale_freq_capacity cpufreq_scale_freq_capacity
> +#elif !defined(arch_scale_freq_capacity)
>  static __always_inline
>  unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
>  {

This could not allow x86 to use the APERF/MPERF thing, so no, can't be
right.

Maybe something like

#ifndef arch_scale_freq_capacity
#ifdef CONFIG_CPU_FREQ
#define arch_scale_freq_capacity	cpufreq_scale_freq_capacity
#else
static __always_inline
unsigned long arch_scale_freq_capacity(..)
{
	return SCHED_CAPACITY_SCALE;
}
#endif
#endif

Which will let the arch override and only falls back to cpufreq if
the arch doesn't do anything.


