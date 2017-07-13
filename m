From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 14:18:04 +0530
Message-ID: <20170713084804.GC352@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170712092755.GD1679@vireshk-i7>
 <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
 <14176128.txNmPKaVBr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36075 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdGMIsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 04:48:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so26170738pfl.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 01:48:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <14176128.txNmPKaVBr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 13-07-17, 01:13, Rafael J. Wysocki wrote:
> On Wednesday, July 12, 2017 01:14:26 PM Peter Zijlstra wrote:
> > On Wed, Jul 12, 2017 at 02:57:55PM +0530, Viresh Kumar wrote:

> > > IIUC, it will take more time to change the frequency eventually with
> > > the interrupt-driven state machine as there may be multiple bottom
> > > halves involved here, for supply, clk, etc, which would run at normal
> > > priorities now. And those were boosted currently due to the high
> > > priority sugov thread. And we are fine with that (from performance
> > > point of view) ?
> > 
> > I'm not sure what you mean; bottom halves as in softirq?

Workqueues or normal threads actually. Maybe I am completely wrong,
but this is how I believe things are going to be:

Configuration: Both regulator and clk registers accessible over I2C
bus.

Scheduler calls schedutil, which eventually calls cpufreq driver (w/o
kthread). The cpufreq backend driver will queue a async request with
callback (with regulator core) to update regulator's constraints
(which can sleep as we need to talk over I2C). The callback will be
called once regulator is programmed. And we return right after
submitting the request with regulator core.

Now, I2C transfer will finish (i.e. regulator programmed) and the
driver specific callback will get called. It will try to change the
frequency now and wait (sleep) until it finishes. I hope the regulator
core wouldn't call the driver callback from interrupt context but some
sort of bottom half, maybe workqueue (That's what I was referring to
earlier).

And finally the clk is programmed and the state machine finished.

> > From what I can
> > tell an i2c bus does clk_prepare_enable() on registration and from that
> > point on clk_enable() is usable from atomic contexts.

That assumes that we can access registers of the I2C controller
atomically without sleeping. Not sure how many ARM platforms have I2C
controller connected over a slow bus though.

> > But afaict clk
> > stuff doesn't do interrupts at all.

The clk stuff may not need it if the clock controllers registers can
be accessed atomically. But if (as in my example) the clk controller
is also over the I2C bus, then the interrupt will be provided from I2C
bus and clk routines would return only after transfer is done.

> > (with a note that I absolutely hate the clk locking)

Yeah, that's a beast :)

> > I think the interrupt driven thing can actually be faster than the
> > 'regular' task waiting on the mutex. The regulator message can be
> > locklessly queued (it only ever makes sense to have 1 such message
> > pending, any later one will invalidate a prior one).
> > 
> > Then the i2c interrupt can detect the availability of this pending
> > message and splice it into the transfer queue at an opportune moment.
> > 
> > (of course, the current i2c bits don't support any of that)
> 
> I *guess* the concern is that in the new model there is no control over the
> time of requesting the frequency change and when the change actually
> happens.

Right.

> IIUC the whole point of making the governor thread an RT or DL one is to
> ensure that the change will happen as soon as technically possible, because if
> it doesn't happen in a specific time frame, it can very well be skipped entirely.

Yes, or actually we can have more trouble (below..).

> > > Coming back to where we started from (where should we call
> > > arch_set_freq_scale() from ?).
> > 
> > The drivers.. the core cpufreq doesn't know when (if any) transition is
> > completed.
> 
> Right.
>  
> > > I think we would still need some kind of synchronization between
> > > cpufreq core and the cpufreq drivers to make sure we don't start
> > > another freq change before the previous one is complete. Otherwise
> > > the cpufreq drivers would be required to have similar support with
> > > proper locking in place.
> > 
> > Not sure what you mean; also not sure why. On x86 we never know, cannot
> > know. So why would this stuff be any different.

So as per the above example, the software on ARM requires to program
multiple hardware components (clk, regulator, power-domain, etc) for
changing CPUs frequency. And this has to be non-racy, otherwise we
might have programmed regulator, domain etc, but right before we
change the frequency another request may land which may try to program
the regulator again. We would be screwed badly here.

Its not a problem on X86 because (I believe) most of this is done by
the hardware for you. And you guys don't have to worry for that.

We already take care of these synchronization issues in slow switching
path (cpufreq_freq_transition_begin()), where we guarantee that a new
freq change request doesn't start before the previous one is over.

-- 
viresh
