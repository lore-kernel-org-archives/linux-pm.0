From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 12:51:57 +0100
Message-ID: <20160211115157.GH6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59904 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcBKLwF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 06:52:05 -0500
Content-Disposition: inline
In-Reply-To: <5387313.xAhVpzgZCg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Feb 09, 2016 at 09:05:05PM +0100, Rafael J. Wysocki wrote:
> > > One concern I had was, given that the lone scheduler update hook is in
> > > CFS, is it possible for governor updates to be stalled due to RT or DL
> > > task activity?
> > 
> > I don't think they may be completely stalled, but I'd prefer Peter to
> > answer that as he suggested to do it this way.
> 
> In any case, if that concern turns out to be significant in practice, it may
> be addressed like in the appended modification of patch [1/3] from the $subject
> series.
> 
> With that things look like before from the cpufreq side, but the other sched
> classes also get a chance to trigger a cpufreq update.  The drawback is the
> cpu_clock() call instead of passing the time value from update_load_avg(), but
> I guess we can live with that if necessary.
> 
> FWIW, this modification doesn't seem to break things on my test machine.

Not really pretty though. It blows a bit that you require this callback
to be periodic (in order to replace a timer).

Ideally we'd not have to call this if state doesn't change.


> +++ linux-pm/include/linux/sched.h
> @@ -3207,4 +3207,11 @@ static inline unsigned long rlimit_max(u
>  	return task_rlimit_max(current, limit);
>  }
>  
> +void cpufreq_update_util(unsigned long util, unsigned long max);

Didn't you have a timestamp in there?

> +
> +static inline void cpufreq_kick(void)
> +{
> +	cpufreq_update_util(ULONG_MAX, ULONG_MAX);
> +}
> +
>  #endif
