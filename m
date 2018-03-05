From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
Date: Mon, 5 Mar 2018 12:38:03 +0100
Message-ID: <20180305113803.GO25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2332986.m9oRvTSu8E@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2332986.m9oRvTSu8E@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 04, 2018 at 11:26:24PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to address the issue with short idle duration predictions
> by the idle governor after the tick has been stopped, prepare the
> menu governor code for reordering with respect to the timekeeping
> code that stops the tick.
> 
> Use the observation that menu_select() can be split into two
> functions, one predicting the idle duration and one selecting the
> idle state, and rework it accordingly.

I actually think this is the wrong way around.

We really should be predicting state not duration. Yes the duration
thing is an intermediate value, but I don't think it makes any sense
what so ever to preserve that in the predictor. The end result is the
idle state, we should aim for that.

As per:

  https://lkml.org/lkml/2017/7/18/615

there are definite advantages to _not_ preserving duration information
beyond the state boundaries.
