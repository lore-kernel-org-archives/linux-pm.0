From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 16:47:16 +0200
Message-ID: <20170420144716.33lwdp47fwdczr3p@hirez.programming.kicks-ass.net>
References: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
 <20170420130813.h7dycr5cptbrvdkz@hirez.programming.kicks-ass.net>
 <20170420143751.GE2523@mai>
 <20170420144146.fuoqagm6xxrpxfoo@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942331AbdDTOrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 10:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20170420144146.fuoqagm6xxrpxfoo@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ville.syrjala@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Thu, Apr 20, 2017 at 04:41:46PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 20, 2017 at 04:37:51PM +0200, Daniel Lezcano wrote:
> 
> > >  
> > > +	sched_clock_idle_wakeup_event(0);
> > > +
> > 
> > Is it planned to skip this if the tsc is reliable?
> 
> Yes. Current code doesn't quite do that, but if you follow that link I
> send earlier, I'm about to fix that (again).

Bugger, just noticed that never went to the list... see below.

Was reported to not work sufficiently well, now fighting my Core2 box
that hasn't been booted/updated in ages.

---
Subject: sched/clock,x86/tsc: Improve clock continuity for stable->unstable transition
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Apr 13 14:56:44 CEST 2017

Marta reported that commit:

  7b09cc5a9deb ("sched/clock: Fix broken stable to unstable transfer")

appeared to have broken things on a Core2Duo machine. While that patch
is in fact correct, it exposes a problem with commit:

  5680d8094ffa ("sched/clock: Provide better clock continuity")

Where we hoped that TSC would not make big jumps after SMP bringup. Of
course, TSC needs to prove us wrong. Because Core2 comes up with a
semi-stable TSC and only goes funny once we probe the idle drivers,
because Core2 stops TSC on idle.

Now we could of course delay the final switch to stable longer, but it
would be better to entirely remove the assumption that TSC doesn't
make big jumps and improve things all-round.

So instead we have the clocksource watchdog call a special function
when it finds the TSC is still good (there's a race, it could've
gotten bad between us determining it's still good and calling our
function, do we care?).

This function then updates the __gtod_offset using sane values, which
is the value needed for clock continuity when being marked unstable.

Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Martin Peres <martin.peres@linux.intel.com>
Reported-by: "Lofstedt, Marta" <marta.lofstedt@intel.com>
Fixes: 5680d8094ffa ("sched/clock: Provide better clock continuity")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c       |   12 ++++++++++
 include/linux/clocksource.h |    1 
 include/linux/sched/clock.h |    2 -
 kernel/sched/clock.c        |   50 ++++++++++++++++++++++++--------------------
 kernel/time/clocksource.c   |    3 ++
 5 files changed, 45 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -374,6 +374,8 @@ static int __init tsc_setup(char *str)
 		tsc_clocksource_reliable = 1;
 	if (!strncmp(str, "noirqtime", 9))
 		no_sched_irq_time = 1;
+	if (!strcmp(str, "unstable"))
+		mark_tsc_unstable("boot parameter");
 	return 1;
 }
 
@@ -1127,6 +1129,15 @@ static void tsc_cs_mark_unstable(struct
 	pr_info("Marking TSC unstable due to clocksource watchdog\n");
 }
 
+static void tsc_cs_tick_stable(struct clocksource *cs)
+{
+	if (tsc_unstable)
+		return;
+
+	if (using_native_sched_clock())
+		sched_clock_tick_stable();
+}
+
 /*
  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
  */
@@ -1140,6 +1151,7 @@ static struct clocksource clocksource_ts
 	.archdata               = { .vclock_mode = VCLOCK_TSC },
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
+	.tick_stable		= tsc_cs_tick_stable,
 };
 
 void mark_tsc_unstable(char *reason)
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -96,6 +96,7 @@ struct clocksource {
 	void (*suspend)(struct clocksource *cs);
 	void (*resume)(struct clocksource *cs);
 	void (*mark_unstable)(struct clocksource *cs);
+	void (*tick_stable)(struct clocksource *cs);
 
 	/* private: */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -63,8 +63,8 @@ extern void clear_sched_clock_stable(voi
  */
 extern u64 __sched_clock_offset;
 
-
 extern void sched_clock_tick(void);
+extern void sched_clock_tick_stable(void);
 extern void sched_clock_idle_sleep_event(void);
 extern void sched_clock_idle_wakeup_event(u64 delta_ns);
 
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -152,25 +152,15 @@ static void __clear_sched_clock_stable(v
 {
 	struct sched_clock_data *scd = this_scd();
 
-	/*
-	 * Attempt to make the stable->unstable transition continuous.
-	 *
-	 * Trouble is, this is typically called from the TSC watchdog
-	 * timer, which is late per definition. This means the tick
-	 * values can already be screwy.
-	 *
-	 * Still do what we can.
-	 */
-	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - (scd->tick_gtod);
+	if (!sched_clock_stable())
+		return;
 
 	printk(KERN_INFO "sched_clock: Marking unstable (%lld, %lld)<-(%lld, %lld)\n",
 			scd->tick_gtod, __gtod_offset,
 			scd->tick_raw,  __sched_clock_offset);
 
 	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
-
-	if (sched_clock_stable())
-		schedule_work(&sched_clock_work);
+	schedule_work(&sched_clock_work);
 }
 
 void clear_sched_clock_stable(void)
@@ -347,21 +337,37 @@ void sched_clock_tick(void)
 {
 	struct sched_clock_data *scd;
 
+	if (sched_clock_stable())
+		return;
+
+	if (unlikely(!sched_clock_running))
+		return;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
-	/*
-	 * Update these values even if sched_clock_stable(), because it can
-	 * become unstable at any point in time at which point we need some
-	 * values to fall back on.
-	 *
-	 * XXX arguably we can skip this if we expose tsc_clocksource_reliable
-	 */
 	scd = this_scd();
 	scd->tick_raw  = sched_clock();
 	scd->tick_gtod = ktime_get_ns();
+	sched_clock_local(scd);
+}
 
-	if (!sched_clock_stable() && likely(sched_clock_running))
-		sched_clock_local(scd);
+void sched_clock_tick_stable(void)
+{
+	u64 gtod, clock;
+
+	if (!sched_clock_stable())
+		return;
+
+	/*
+	 * Called under watchdog_lock.
+	 *
+	 * The watchdog just found this TSC to (still) be stable, so now is a
+	 * good moment to update our __gtod_offset. Because once we find the
+	 * TSC to be unstable, any computation will be computing crap.
+	 */
+	gtod = ktime_get_ns();
+	clock = sched_clock();
+	__gtod_offset = (clock + __sched_clock_offset) - gtod;
 }
 
 /*
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -233,6 +233,9 @@ static void clocksource_watchdog(unsigne
 			continue;
 		}
 
+		if (cs == curr_clocksource && cs->tick_stable)
+			cs->tick_stable(cs);
+
 		if (!(cs->flags & CLOCK_SOURCE_VALID_FOR_HRES) &&
 		    (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS) &&
 		    (watchdog->flags & CLOCK_SOURCE_IS_CONTINUOUS)) {
