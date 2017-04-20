From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 15:08:13 +0200
Message-ID: <20170420130813.h7dycr5cptbrvdkz@hirez.programming.kicks-ass.net>
References: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: ville.syrjala@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 03:44:47PM +0300, ville.syrjala@linux.intel.com wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> This reverts commit e93e59ce5b85e6c2b444f09fd1f707274ec066dc.
> 
> The TSC stops in deeper C states, 

On some old hardware (Core2 era and before) only. You've forgotten to
mention what hardware you've observed problems with.

> so using local_clock() in cpuidle

But on said hardware, local_clock() isn't an immediate TSC user.

> to track the C state residency seems like a bad idea. With local_clock()
> powertop is reporting mostly 0% residency for C states here. Presumably
> the core is still spending most of its time in some deep C-state since
> the totals typically add up to only 5% or so, so perhaps the governor
> isn't getting totally confused by these bogus numbers. But let's go
> back to using ktime_get() as that at least works correctly across the
> board.

Does this cure it?

---
 drivers/cpuidle/cpuidle.c | 2 ++
 kernel/sched/clock.c      | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 548b90be7685..e0d4ad108887 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -219,6 +219,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
+	sched_clock_idle_wakeup_event(0);
+
 	time_end = ns_to_ktime(local_clock());
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 00a45c45beca..15e848706be4 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -347,6 +347,9 @@ void sched_clock_tick(void)
 {
 	struct sched_clock_data *scd;
 
+	if (timekeeping_suspended)
+		return;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
 	/*
@@ -378,11 +381,7 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_sleep_event);
  */
 void sched_clock_idle_wakeup_event(u64 delta_ns)
 {
-	if (timekeeping_suspended)
-		return;
-
 	sched_clock_tick();
-	touch_softlockup_watchdog_sched();
 }
 EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
