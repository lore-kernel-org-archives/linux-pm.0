From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 19 Jan 2016 16:30:07 +0100
Message-ID: <20160119153007.GZ6357@twins.programming.kicks-ass.net>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
 <20160119140036.GG6344@twins.programming.kicks-ass.net>
 <20160119144233.GG8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60298 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbcASPaK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 10:30:10 -0500
Content-Disposition: inline
In-Reply-To: <20160119144233.GG8573@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Tue, Jan 19, 2016 at 02:42:33PM +0000, Juri Lelli wrote:
> On 19/01/16 15:00, Peter Zijlstra wrote:
> > On Wed, Jan 13, 2016 at 10:21:31AM -0800, Michael Turquette wrote:
> > > RCU is absolutely not a magic bullet or elixir that lets us kick off
> > > DVFS transitions from the schedule() context. The frequency transitions
> > > are write-side operations, as we invariably touch struct cpufreq_policy.
> > > This means that the read-side stuff can live in the schedule() context,
> > > but write-side needs to be kicked out to a thread.
> > 
> > Why? If the state is per-cpu and acquired by RCU, updates should be no
> > problem at all.
> > 
> > If you need inter-cpu state, then things get to be a little tricky
> > though, but you can actually nest a raw_spinlock_t in there if you
> > absolutely have to.
> > 
> 
> We have at least two problems. First one is that state is per frequency
> domain (struct cpufreq_policy) and this usually spans more than one cpu.
> Second one is that we might need to sleep while servicing the frequency
> transition, both because platform needs to sleep and because some paths
> of cpufreq core use sleeping locks (yes, that might be changed as well I
> guess).  A solution based on spinlocks only might not be usable on
> platforms that needs to sleep, also.

Sure, if you need to actually sleep to poke the hardware you've lost and
you do indeed need the kthread thingy.

> Another thing that I was thinking of actually is that since struct
> cpufreq_policy is updated a lot (more or less at every frequency
> transition), is it actually suitable for RCU?

That entirely depends on how 'hard' it is to 'replace/change' the
cpufreq policy.

Typically I envision that to be very hard and require mutexes and the
like, in which case RCU can provide a cheap lookup and existence.

So on 'sane' hardware with per logical cpu hints you can get away
without any locks.
