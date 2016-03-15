From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into
 cpufreq_update_util
Date: Tue, 15 Mar 2016 22:25:20 +0100
Message-ID: <20160315212520.GF6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38740 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcCOVZX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:25:23 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:09PM -0700, Michael Turquette wrote:
> +++ b/include/linux/sched.h
> @@ -2362,15 +2362,25 @@ extern u64 scheduler_tick_max_deferment(void);
>  static inline bool sched_can_stop_tick(void) { return false; }
>  #endif
>  
> +enum sched_class_util {
> +	cfs_util,
> +	rt_util,
> +	dl_util,
> +	nr_util_types,
> +};
> +
>  #ifdef CONFIG_CPU_FREQ
>  struct freq_update_hook {
> +	void (*func)(struct freq_update_hook *hook,
> +		     enum sched_class_util sched_class, u64 time,
>  		     unsigned long util, unsigned long max);
>  };
>  
>  void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
> +			void (*func)(struct freq_update_hook *hook,
> +				     enum sched_class_util sched_class,
> +				     u64 time, unsigned long util,
> +				     unsigned long max));

Have you looked at the asm that generated? At some point you'll start
spilling on the stack and it'll be a god awful mess.

