From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 13:15:47 +0200
Message-ID: <20170713111547.y33gkhugtccnsnto@hirez.programming.kicks-ass.net>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170712092755.GD1679@vireshk-i7>
 <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
 <14176128.txNmPKaVBr@aspire.rjw.lan>
 <20170713084804.GC352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60273 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdGMLPy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 07:15:54 -0400
Content-Disposition: inline
In-Reply-To: <20170713084804.GC352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Thu, Jul 13, 2017 at 02:18:04PM +0530, Viresh Kumar wrote:
> Workqueues or normal threads actually. Maybe I am completely wrong,
> but this is how I believe things are going to be:
> 
> Configuration: Both regulator and clk registers accessible over I2C
> bus.
> 
> Scheduler calls schedutil, which eventually calls cpufreq driver (w/o
> kthread). The cpufreq backend driver will queue a async request with
> callback (with regulator core) to update regulator's constraints
> (which can sleep as we need to talk over I2C). The callback will be
> called once regulator is programmed. And we return right after
> submitting the request with regulator core.
> 
> Now, I2C transfer will finish (i.e. regulator programmed) and the
> driver specific callback will get called. It will try to change the
> frequency now and wait (sleep) until it finishes. I hope the regulator
> core wouldn't call the driver callback from interrupt context but some
> sort of bottom half, maybe workqueue (That's what I was referring to
> earlier).
> 
> And finally the clk is programmed and the state machine finished.
> 
> > > From what I can
> > > tell an i2c bus does clk_prepare_enable() on registration and from that
> > > point on clk_enable() is usable from atomic contexts.
> 
> That assumes that we can access registers of the I2C controller
> atomically without sleeping. Not sure how many ARM platforms have I2C
> controller connected over a slow bus though.
> 
> > > But afaict clk
> > > stuff doesn't do interrupts at all.
> 
> The clk stuff may not need it if the clock controllers registers can
> be accessed atomically. But if (as in my example) the clk controller
> is also over the I2C bus, then the interrupt will be provided from I2C
> bus and clk routines would return only after transfer is done.

So no, that's not the idea at all.

The one thing we assume is that the I2C bus does indeed have interrupts
(which isn't a given per se, but lacking that we're completely hosed).

For interrupt enabled I2C busses, we must be able to write to their
registers from atomic context, otherwise the interrupts can't very well
work.

With that, you can drive the entire thing from the IRQ.


I don't believe anyone is quite as silly as to put the regulator on a
nested I2C; in which case I think you still _could_ do, but I'll just
class that with failure of using a polling I2C bus for your regulator.


As to the serialization, your driver can easily keep track of that and
not allow a new transition to start while a previous is still in
critical transit.
