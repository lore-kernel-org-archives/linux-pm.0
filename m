From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched / idle: Drop default_idle_call() fallback from
 call_cpuidle()
Date: Mon, 18 Jan 2016 15:36:28 +0100
Message-ID: <20160118143628.GR6357@twins.programming.kicks-ass.net>
References: <1621492.NI2xz9vt7M@vostro.rjw.lan>
 <2393290.LAksQzHH19@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60912 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbcAROgc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 09:36:32 -0500
Content-Disposition: inline
In-Reply-To: <2393290.LAksQzHH19@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Sat, Jan 16, 2016 at 12:54:53AM +0100, Rafael J. Wysocki wrote:
> This eliminates one branch from the idle loop and makes the governors
> and find_deepest_state() handle the case when all states have been
> disabled from sysfs consistently.

> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -97,12 +97,6 @@ void default_idle_call(void)
>  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		      int next_state)
>  {
> -	/* Fall back to the default arch idle method on errors. */
> -	if (next_state < 0) {
> -		default_idle_call();
> -		return next_state;
> -	}
> -
>  	/*
>  	 * The idle task must be scheduled, it is pointless to go to idle, just
>  	 * update no idle residency and return.


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
