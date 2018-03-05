From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Date: Mon, 5 Mar 2018 17:50:52 +0100
Message-ID: <20180305165052.GE25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <3c051023-312b-d2bc-34b5-40e8c13ca796@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3c051023-312b-d2bc-34b5-40e8c13ca796@tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 05, 2018 at 04:36:20PM +0100, Thomas Ilsche wrote:
> I fear that might even create positive feedback loops on the
> heuristic, which will take into account the sleep durations for
> sched tick wakeups in sort of a self fulfilling prophecy:
> 1) The heuristic predicts to wake up in less than a full sched period,
> 2) The sched tick is kept enabled
> 3) The sched tick wakes up the system in less than a full sched period
> 4) Repeat

Right, I pointed out this same issue. We should ignore 'ticks' for the
purpose of measuring sleep duration.

That's slightly tricky to actually do though :/

> Question: Does disabling a timer on a cpu guarantee that this cpu will
> wake-up or is there a scenario where a timer is deleted or moved
> externally without the cpu having a chance to change it's idle state?

I think we let them sleep and don't modify any hardware timers,
resulting in them waking up at the predetermined time, not find anything
to do, recompute the next timer and go back to sleep.

Waking them up to reprogram the timer hardware is far more expensive.
