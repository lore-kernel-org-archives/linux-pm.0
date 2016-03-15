From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Tue, 15 Mar 2016 22:48:21 +0100
Message-ID: <20160315214821.GM6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [198.137.202.9] ([198.137.202.9]:47114 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754049AbcCOVtl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:49:41 -0400
Content-Disposition: inline
In-Reply-To: <20160315214043.30639.75507@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Tue, Mar 15, 2016 at 02:40:43PM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2016-03-15 14:20:47)
> > On Sun, Mar 13, 2016 at 10:22:08PM -0700, Michael Turquette wrote:
> > > With the addition of the global cfs capacity margin helpers in patch,
> > > "sched/cpufreq: new cfs capacity margin helpers", we can now export
> > > sysfs tunables from the schedutil governor. This allows privileged users
> > > to tune the value more easily.
> > > 
> > > The margin value is global to cfs, not per-policy. As such schedutil
> > > does not store any state about the margin. Schedutil restores the margin
> > > value to its default value when exiting.
> > 
> > Yuck sysfs.. I would really rather we did not expose this per default.
> > And certainly not in this weird form.
> 
> I'm happy to change capacity_margin to up_threshold and use a
> percentage.
> 
> The sysfs approach has two benefits. First, it is aligned with cpufreq
> user expectations. Second, there has been rough consensus that this
> value should be tunable and sysfs gets us there quickly and painlessly.
> We're already exporting rate_limit_us for schedutil via sysfs. Is there
> a better way interface you can recommend?

It really depends on how tunable you want this to be. Do we always want
this to be a tunable, or just now while we're playing about with the
whole thing?

The problem with exposing it in sysfs is that you cannot take it out
again, it becomes ABI.

What we do for all the scheduler tunables (pretty much every time we
have to take a value out of thin air), is we make them const for
!SCHED_DEBUG builds, but have them as sysctl for SCHED_DEBUG builds
(although we should probably move them to /debug/sched/ or somesuch).

That way you get better code generation (compile time constants rule)
for !debug builds, while having the 'joy' of poking at your number on
debug builds.


