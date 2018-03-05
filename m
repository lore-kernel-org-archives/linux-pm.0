From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Date: Mon, 5 Mar 2018 14:46:09 +0100
Message-ID: <20180305134609.GX25235@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305123552.GY25181@hirez.programming.kicks-ass.net>
 <1520255955.6857.18.camel@surriel.com>
 <20180305133725.GU25201@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180305133725.GU25201@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 05, 2018 at 02:37:25PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 05, 2018 at 08:19:15AM -0500, Rik van Riel wrote:

> > > Also, I think that at this point you've introduced a problem; by not
> > > disabling the tick unconditionally, we'll have extra wakeups due to
> > > the (now still running) tick, which will bias the estimation, as per
> > > reflect(), downwards.
> > > 
> > > We should effectively discard tick wakeups when we could have
> > > entered nohz but didn't, accumulating the idle period in reflect and
> > > only commit once we get a !tick wakeup.
> > 
> > How much of a problem would that actually be?
> > 
> > Don't all but the very deepest C-states have
> > target residencies that are orders of magnitude
> > smaller than the tick period?
> > 
> > In other words, if our sleeps end up getting
> > "cut short" to 600us, we will still select C6,
> > and it will not result in picking C3 by mistake.
> > 
> > This only seems to affect C7 states and deeper.
> 
> On modern Intel, what about other platforms? This is something that
> should work across the board.

Look at this for example:

arch/arm64/boot/dts/hisilicon/hi3660.dtsi:                              min-residency-us = <20000>;

That's 20ms right there..

But on average, considering ARM64 defaults to HZ=250, most of them are
<TICK_USEC.
