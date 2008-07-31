From: venkatesh.pallipadi@intel.com
Subject: [patch 1/3] cpuidle: Do not use poll_idle unless user
	asks for it
Date: Wed, 30 Jul 2008 19:21:42 -0700
Message-ID: <20080731022215.751308000@intel.com>
References: <20080731022141.088307000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=not_use_poll_idle_unless_asked_for.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: len.brown@intel.com, andi@firstfloor.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

poll_idle was added to CPUIDLE, just as a low latency idle handler, to be
used in cases when user desires CPUs not to enter any idle state at all. It
was supposed to be a run time idle=poll option to the user. But, it was indeed
getting used during normal menu and ladder governor default case, with no
special user setting (Reported by Linus Torvalds).

Change below ensures that poll_idle will not be used unless user explicitly
asks pm_qos infrastructure for zero latency requirement.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 drivers/cpuidle/governors/ladder.c |   14 ++++++++++----
 drivers/cpuidle/governors/menu.c   |   11 +++++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-2.6.orig/drivers/cpuidle/governors/menu.c	2008-07-28 16:52:04.000000000 -0700
+++ linux-2.6/drivers/cpuidle/governors/menu.c	2008-07-30 19:00:48.000000000 -0700
@@ -34,21 +34,28 @@ static DEFINE_PER_CPU(struct menu_device
 static int menu_select(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
+	int latency_req = pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 
+	/* Special case when user has set very strict latency requirement */
+	if (unlikely(latency_req == 0)) {
+		data->last_state_idx = 0;
+		return 0;
+	}
+
 	/* determine the expected residency time */
 	data->expected_us =
 		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
 
 	/* find the deepest idle state that satisfies our constraints */
-	for (i = 1; i < dev->state_count; i++) {
+	for (i = CPUIDLE_DRIVER_STATE_START + 1; i < dev->state_count; i++) {
 		struct cpuidle_state *s = &dev->states[i];
 
 		if (s->target_residency > data->expected_us)
 			break;
 		if (s->target_residency > data->predicted_us)
 			break;
-		if (s->exit_latency > pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY))
+		if (s->exit_latency > latency_req)
 			break;
 	}
 
Index: linux-2.6/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-2.6.orig/drivers/cpuidle/governors/ladder.c	2008-07-28 16:52:04.000000000 -0700
+++ linux-2.6/drivers/cpuidle/governors/ladder.c	2008-07-30 19:01:28.000000000 -0700
@@ -67,10 +67,17 @@ static int ladder_select_state(struct cp
 	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
+	int latency_req = pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
 
 	if (unlikely(!ldev))
 		return 0;
 
+	/* Special case when user has set very strict latency requirement */
+	if (unlikely(latency_req == 0)) {
+		ladder_do_selection(ldev, last_idx, 0);
+		return 0;
+	}
+
 	last_state = &ldev->states[last_idx];
 
 	if (dev->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID)
@@ -81,8 +88,7 @@ static int ladder_select_state(struct cp
 	/* consider promotion */
 	if (last_idx < dev->state_count - 1 &&
 	    last_residency > last_state->threshold.promotion_time &&
-	    dev->states[last_idx + 1].exit_latency <=
-			pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY)) {
+	    dev->states[last_idx + 1].exit_latency <= latency_req) {
 		last_state->stats.promotion_count++;
 		last_state->stats.demotion_count = 0;
 		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
@@ -92,7 +98,7 @@ static int ladder_select_state(struct cp
 	}
 
 	/* consider demotion */
-	if (last_idx > 0 &&
+	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
 	    last_residency < last_state->threshold.demotion_time) {
 		last_state->stats.demotion_count++;
 		last_state->stats.promotion_count = 0;
@@ -117,7 +123,7 @@ static int ladder_enable_device(struct c
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
 
-	ldev->last_state_idx = 0;
+	ldev->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
 	for (i = 0; i < dev->state_count; i++) {
 		state = &dev->states[i];

-- 
