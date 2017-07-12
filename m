From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant load-tracking support
Date: Thu, 13 Jul 2017 01:13:43 +0200
Message-ID: <14176128.txNmPKaVBr@aspire.rjw.lan>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com> <20170712092755.GD1679@vireshk-i7> <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63892 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750775AbdGLXV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 19:21:29 -0400
In-Reply-To: <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Wednesday, July 12, 2017 01:14:26 PM Peter Zijlstra wrote:
> On Wed, Jul 12, 2017 at 02:57:55PM +0530, Viresh Kumar wrote:
> > On 12-07-17, 10:31, Peter Zijlstra wrote:
> > > So the problem with the thread is two-fold; one the one hand we like the
> > > scheduler to directly set frequency, but then we need to schedule a task
> > > to change the frequency, which will change the frequency and around we
> > > go.
> > > 
> > > On the other hand, there's very nasty issues with PI. This thread would
> > > have very high priority (otherwise the SCHED_DEADLINE stuff won't work)
> > > but that then means this thread needs to boost the owner of the i2c
> > > mutex. And that then creates a massive bandwidth accounting hole.
> > > 
> > > 
> > > The advantage of using an interrupt driven state machine is that all
> > > those issues go away.
> > > 
> > > But yes, whichever way around you turn things, its crap. But given the
> > > hardware its the best we can do.
> > 
> > Thanks for the explanation Peter.
> > 
> > IIUC, it will take more time to change the frequency eventually with
> > the interrupt-driven state machine as there may be multiple bottom
> > halves involved here, for supply, clk, etc, which would run at normal
> > priorities now. And those were boosted currently due to the high
> > priority sugov thread. And we are fine with that (from performance
> > point of view) ?
> 
> I'm not sure what you mean; bottom halves as in softirq? From what I can
> tell an i2c bus does clk_prepare_enable() on registration and from that
> point on clk_enable() is usable from atomic contexts. But afaict clk
> stuff doesn't do interrupts at all.
> 
> (with a note that I absolutely hate the clk locking)
> 
> I think the interrupt driven thing can actually be faster than the
> 'regular' task waiting on the mutex. The regulator message can be
> locklessly queued (it only ever makes sense to have 1 such message
> pending, any later one will invalidate a prior one).
> 
> Then the i2c interrupt can detect the availability of this pending
> message and splice it into the transfer queue at an opportune moment.
> 
> (of course, the current i2c bits don't support any of that)

I *guess* the concern is that in the new model there is no control over the
time of requesting the frequency change and when the change actually
happens.

IIUC the whole point of making the governor thread an RT or DL one is to
ensure that the change will happen as soon as technically possible, because if
it doesn't happen in a specific time frame, it can very well be skipped entirely.

> > Coming back to where we started from (where should we call
> > arch_set_freq_scale() from ?).
> 
> The drivers.. the core cpufreq doesn't know when (if any) transition is
> completed.

Right.
 
> > I think we would still need some kind of synchronization between
> > cpufreq core and the cpufreq drivers to make sure we don't start
> > another freq change before the previous one is complete. Otherwise
> > the cpufreq drivers would be required to have similar support with
> > proper locking in place.
> 
> Not sure what you mean; also not sure why. On x86 we never know, cannot
> know. So why would this stuff be any different.

We seem to be in violent agreement on this. :-)

Thanks,
Rafael
