From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 1/6] time: tick-sched: Reorganize idle tick
 management code
Date: Thu, 8 Mar 2018 16:14:10 +0100
Message-ID: <20180308151407.GA11118@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
 <4136227.b9g9WnMbNJ@aspire.rjw.lan>
 <20180307231827.GA9367@lerouge>
 <1938066.lrFpnYERYl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1938066.lrFpnYERYl@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 08, 2018 at 10:22:26AM +0100, Rafael J. Wysocki wrote:
> On Thursday, March 8, 2018 12:18:29 AM CET Frederic Weisbecker wrote:
> > On Tue, Mar 06, 2018 at 10:02:01AM +0100, Rafael J. Wysocki wrote:
> > > Index: linux-pm/kernel/time/tick-sched.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/time/tick-sched.c
> > > +++ linux-pm/kernel/time/tick-sched.c
> > > +
> > > +/**
> > > + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> > > + *
> > > + * Called when we start the idle loop.
> > > + */
> > > +void tick_nohz_idle_prepare(void)
> > > +{
> > > +	struct tick_sched *ts;
> > > +
> > > +	__tick_nohz_idle_prepare();
> > > +
> > > +	local_irq_disable();
> > > +
> > > +	ts = this_cpu_ptr(&tick_cpu_sched);
> > > +	ts->inidle = 1;
> > > +
> > > +	local_irq_enable();
> > > +}
> > 
> > Why not calling tick_nohz_start_idle() from there? This is going to
> > simplify the rest, you won't need to call tick_nohz_idle_go_idle()
> > from places that don't want to stop the tick and you can then remove
> > the stop_tick argument.
> 
> So I guess I would then use ts->idle_entrytime as "now" in the
> tick_nohz_get_sleep_length() computation, right?

Ah right, I missed the need for ktime_get().

You can't use ts->idle_entrytime in tick_nohz_get_sleep_length() because
full dynticks doesn't rely on it.

But I think you can just do the following, with a comment explaining that
idle_entrytime is expected to be fresh enough at this point:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 57b3de4..8e61796 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -923,7 +923,7 @@ static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
 
 		ts->idle_calls++;
 
-		expires = tick_nohz_stop_sched_tick(ts, now, cpu);
+		expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
 		if (expires > 0LL) {
 			ts->idle_sleeps++;
 			ts->idle_expires = expires;
