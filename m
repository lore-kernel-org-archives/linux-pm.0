From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 1 Mar 2016 13:57:27 +0100
Message-ID: <20160301125727.GT6357@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1792311.cuUNhUde5n@vostro.rjw.lan>
 <20160226091843.GX6356@twins.programming.kicks-ass.net>
 <1743951.Hhdov0yvNG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60333 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCAM5h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 07:57:37 -0500
Content-Disposition: inline
In-Reply-To: <1743951.Hhdov0yvNG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Sat, Feb 27, 2016 at 01:08:02AM +0100, Rafael J. Wysocki wrote:
> @@ -95,18 +98,20 @@ EXPORT_SYMBOL_GPL(cpufreq_set_update_uti
>   *
>   * This function is called by the scheduler on every invocation of
>   * update_load_avg() on the CPU whose utilization is being updated.
> + *
> + * It can only be called from RCU-sched read-side critical sections.
>   */
>  void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
>  {
>  	struct update_util_data *data;
>  
> -	rcu_read_lock();
> -

Maybe, just because I'm paranoid, add something like:

#ifdef CONFIG_LOCKDEP
	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
#endif

>  	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
> -	if (data && data->func)
> +	/*
> +	 * If this isn't inside of an RCU-sched read-side critical section, data
> +	 * may become NULL after the check below.
> +	 */
> +	if (data)
>  		data->func(data, time, util, max);
> -
> -	rcu_read_unlock();
>  }
