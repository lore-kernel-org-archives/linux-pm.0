From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] sched / idle: Drop default_idle_call() fallback from call_cpuidle()
Date: Sat, 16 Jan 2016 00:54:53 +0100
Message-ID: <2393290.LAksQzHH19@vostro.rjw.lan>
References: <1621492.NI2xz9vt7M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1621492.NI2xz9vt7M@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 9c4b2867ed7c (cpuidle: menu: Fix menu_select() for
CPUIDLE_DRIVER_STATE_START == 0) it is clear that menu_select()
cannot return negative values.  Moreover, ladder_select_state()
will never return a negative value too, so make find_deepest_state()
return non-negative values too and drop the default_idle_call()
fallback from call_cpuidle().

This eliminates one branch from the idle loop and makes the governors
and find_deepest_state() handle the case when all states have been
disabled from sysfs consistently.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: Commit 9c4b2867ed7c (cpuidle: menu: Fix menu_select() for
CPUIDLE_DRIVER_STATE_START == 0) is in linux-next only ATM.

---
 drivers/cpuidle/cpuidle.c |    6 +++---
 kernel/sched/idle.c       |    6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -79,9 +79,9 @@ static int find_deepest_state(struct cpu
 			      bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = -ENXIO;
+	int i, ret = 0;
 
-	for (i = 0; i < drv->state_count; i++) {
+	for (i = 1; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
@@ -243,7 +243,7 @@ int cpuidle_enter_state(struct cpuidle_d
  * @drv: the cpuidle driver
  * @dev: the cpuidle device
  *
- * Returns the index of the idle state.
+ * Returns the index of the idle state.  The return value must not be negative.
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -97,12 +97,6 @@ void default_idle_call(void)
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      int next_state)
 {
-	/* Fall back to the default arch idle method on errors. */
-	if (next_state < 0) {
-		default_idle_call();
-		return next_state;
-	}
-
 	/*
 	 * The idle task must be scheduled, it is pointless to go to idle, just
 	 * update no idle residency and return.
