From: ville.syrjala@linux.intel.com
Subject: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 15:44:47 +0300
Message-ID: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

This reverts commit e93e59ce5b85e6c2b444f09fd1f707274ec066dc.

The TSC stops in deeper C states, so using local_clock() in cpuidle
to track the C state residency seems like a bad idea. With local_clock()
powertop is reporting mostly 0% residency for C states here. Presumably
the core is still spending most of its time in some deep C-state since
the totals typically add up to only 5% or so, so perhaps the governor
isn't getting totally confused by these bogus numbers. But let's go
back to using ktime_get() as that at least works correctly across the
board.

Note that the code has changed somewhat since the regression happened,
so this isn't a 1:1 revert of the offending commit.

Cc: stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/cpuidle/cpuidle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 548b90be7685..24a52805527f 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -213,13 +213,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	sched_idle_set_state(target_state);
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
-	time_start = ns_to_ktime(local_clock());
+	time_start = ktime_get();
 
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
-	time_end = ns_to_ktime(local_clock());
+	time_end = ktime_get();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
-- 
2.10.2
