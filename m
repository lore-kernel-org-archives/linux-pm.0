From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 10/10] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
Date: Thu, 5 Apr 2018 16:13:26 +0200
Message-ID: <20180405141326.GH4129@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <6542020.eHGLEK9V0J@aspire.rjw.lan>
 <20180405124757.GQ4082@hirez.programming.kicks-ass.net>
 <CAJZ5v0h2c5RtUxwF2z3Gjy8O2RSBaD7wN3CxUXrg57jH57_xoA@mail.gmail.com>
 <20180405141127.GS4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180405141127.GS4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 05, 2018 at 04:11:27PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 03:49:32PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 5, 2018 at 2:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Apr 04, 2018 at 10:50:36AM +0200, Rafael J. Wysocki wrote:
> > >> +     if (tick_nohz_tick_stopped()) {
> > >> +             /*
> > >> +              * If the tick is already stopped, the cost of possible short
> > >> +              * idle duration misprediction is much higher, because the CPU
> > >> +              * may be stuck in a shallow idle state for a long time as a
> > >> +              * result of it.  In that case say we might mispredict and try
> > >> +              * to force the CPU into a state for which we would have stopped
> > >> +              * the tick, unless the tick timer is going to expire really
> > >> +              * soon anyway.
> > >
> > > Wait what; the tick was stopped, therefore it _cannot_ expire soon.
> > >
> > > *confused*
> > >
> > > Did you mean s/tick/a/ ?
> > 
> > Yeah, that should be "a timer".
> 
> *phew* ok, that makes a lot more sense ;-)
> 
> My only concern with this is that we can now be overly pessimistic. The
> predictor might know that statistically it's very likely a device
> interrupt will arrive soon, but because the tick is already disabled, we
> don't dare trust it, causing possible excessive latencies.
> 
> Would an alternative be to make @stop_tick be an enum capable of forcing
> the tick back on?
> 
> enum tick_action {
> 	NOHZ_TICK_STOP,
> 	NOHZ_TICK_RETAIN,
> 	NOHZ_TICK_START,
> };
> 
> 	enum tick_action tick_action = NOHZ_TICK_STOP;
> 
> 	state = cpuidle_select(..., &tick_action);
> 
> 	switch (tick_action) {
> 	case NOHZ_TICK_STOP:
> 		tick_nohz_stop_tick();
> 		break;
> 
> 	case NOHZ_TICK_RETAIN:
> 		tick_nozh_retain_tick();
> 		break;
> 
> 	case NOHZ_TICK_START:
> 		tick_nohz_start_tick();
> 		break;
> 	};
> 
> 
> Or something along those lines?

To clarify, RETAIN keeps the status quo, if its off, it stays off, if
its on it stays on.
