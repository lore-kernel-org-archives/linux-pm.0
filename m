From: Adam Belay <abelay@novell.com>
Subject: [PATCH 5/6] CPUIDLE: remove cpuidle_get_bm_activity()
Date: Tue, 21 Aug 2007 18:26:06 -0400
Message-ID: <1187735167.7199.54.camel__35103.2640239739$1187740257$gmane$org@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brown@smtp2.linux-foundation.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This patch removes cpuidle_get_bm_activity() and updates governors
accordingly.

Please Apply,
Adam

Change Summary:
 drivers/cpuidle/driver.c           |   13 ----------
 drivers/cpuidle/governors/ladder.c |   46 -------------------------------------
 drivers/cpuidle/governors/menu.c   |   26 +-------------------
 include/linux/cpuidle.h            |    4 ---
 4 files changed, 3 insertions(+), 86 deletions(-)
---

diff -urN a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
--- a/drivers/cpuidle/driver.c	2007-08-15 21:51:46.000000000 -0400
+++ b/drivers/cpuidle/driver.c	2007-08-15 22:07:59.000000000 -0400
@@ -54,16 +54,3 @@
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-
-/**
- * cpuidle_get_bm_activity - determines if BM activity has occured
- */
-int cpuidle_get_bm_activity(void)
-{
-	if (cpuidle_curr_driver->bm_check)
-		return cpuidle_curr_driver->bm_check();
-	else
-		return 0;
-}
-
-EXPORT_SYMBOL_GPL(cpuidle_get_bm_activity);
diff -urN a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
--- a/drivers/cpuidle/governors/ladder.c	2007-08-15 21:51:46.000000000 -0400
+++ b/drivers/cpuidle/governors/ladder.c	2007-08-15 22:23:18.000000000 -0400
@@ -24,24 +24,12 @@
 #define PROMOTION_COUNT 4
 #define DEMOTION_COUNT 1
 
-/*
- * bm_history -- bit-mask with a bit per jiffy of bus-master activity
- * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
- * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
- * 100 HZ: 0x0000000F: 4 jiffies = 40ms
- * reduce history for more aggressive entry into C3
- */
-static unsigned int bm_history __read_mostly =
-    (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
-module_param(bm_history, uint, 0644);
-
 struct ladder_device_state {
 	struct {
 		u32 promotion_count;
 		u32 demotion_count;
 		u32 promotion_time;
 		u32 demotion_time;
-		u32 bm;
 	} threshold;
 	struct {
 		int promotion_count;
@@ -51,9 +39,6 @@
 
 struct ladder_device {
 	struct ladder_device_state states[CPUIDLE_STATE_MAX];
-	unsigned int bm_check:1;
-	unsigned long bm_check_timestamp;
-	unsigned long bm_activity; /* FIXME: bm activity should be global */
 	int last_state_idx;
 };
 
@@ -88,26 +73,6 @@
 
 	last_state = &ldev->states[last_idx];
 
-	/* demote if within BM threshold */
-	if (ldev->bm_check) {
-		unsigned long diff;
-
-		diff = jiffies - ldev->bm_check_timestamp;
-		if (diff > 31)
-			diff = 31;
-
-		ldev->bm_activity <<= diff;
-		if (cpuidle_get_bm_activity())
-			ldev->bm_activity |= ((1 << diff) - 1);
-
-		ldev->bm_check_timestamp = jiffies;
-		if ((last_idx > 0) &&
-		    (last_state->threshold.bm & ldev->bm_activity)) {
-			ladder_do_selection(ldev, last_idx, last_idx - 1);
-			return last_idx - 1;
-		}
-	}
-
 	if (dev->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID)
 		last_residency = cpuidle_get_last_residency(dev) - dev->states[last_idx].exit_latency;
 	else
@@ -146,14 +111,12 @@
  */
 static int ladder_enable_device(struct cpuidle_device *dev)
 {
-	int i, bm_check = 0;
+	int i;
 	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
 
 	ldev->last_state_idx = 0;
-	ldev->bm_check_timestamp = 0;
-	ldev->bm_activity = 0;
 
 	for (i = 0; i < dev->state_count; i++) {
 		state = &dev->states[i];
@@ -169,15 +132,8 @@
 			lstate->threshold.promotion_time = state->exit_latency;
 		if (i > 0)
 			lstate->threshold.demotion_time = state->exit_latency;
-		if (state->flags & CPUIDLE_FLAG_CHECK_BM) {
-			lstate->threshold.bm = bm_history;
-			bm_check = 1;
-		} else
-			lstate->threshold.bm = 0;
 	}
 
-	ldev->bm_check = bm_check;
-
 	return 0;
 }
 
diff -urN a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
--- a/drivers/cpuidle/governors/menu.c	2007-08-15 21:57:19.000000000 -0400
+++ b/drivers/cpuidle/governors/menu.c	2007-08-15 22:24:10.000000000 -0400
@@ -14,7 +14,6 @@
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
 
-#define BM_HOLDOFF	2000	/* 2 ms */
 #define BREAK_FUZZ	4	/* 4 us */
 
 struct menu_device {
@@ -24,10 +23,6 @@
 	unsigned int	predicted_us;
 	unsigned int	last_measured_us;
 	unsigned int	elapsed_us;
-
-	int		deepest_bm_state;
-	unsigned int	bm_elapsed_us;
-	unsigned int	bm_holdoff_us;
 };
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -39,20 +34,14 @@
 static int menu_select(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
-	int i, max_state = dev->state_count;
+	int i;
 
 	/* determine the expected residency time */
 	data->expected_us =
 		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
 
-	/* determine the maximum state compatible with current BM status */
-	if (cpuidle_get_bm_activity())
-		data->bm_elapsed_us = 0;
-	if (data->bm_elapsed_us <= data->bm_holdoff_us)
-		max_state = data->deepest_bm_state + 1;
-
 	/* find the deepest idle state that satisfies our constraints */
-	for (i = 1; i < max_state; i++) {
+	for (i = 1; i < dev->state_count; i++) {
 		struct cpuidle_state *s = &dev->states[i];
 
 		if (s->target_residency > data->expected_us)
@@ -91,10 +80,6 @@
 	if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
 		measured_us = USEC_PER_SEC / HZ;
 
-	/* Update time elapsed since last BM detection */
-	if (data->bm_elapsed_us <= data->bm_holdoff_us)
-		data->bm_elapsed_us += measured_us;
-
 	/* Predict time remaining until next break event */
 	if (measured_us + BREAK_FUZZ < data->expected_us - target->exit_latency) {
 		data->predicted_us = max(measured_us, data->last_measured_us);
@@ -116,15 +101,8 @@
 static int menu_enable_device(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
-	int i;
 
 	memset(data, 0, sizeof(struct menu_device));
-	data->bm_holdoff_us = BM_HOLDOFF;
-
-	for (i = 1; i < dev->state_count; i++)
-		if (dev->states[i].flags & CPUIDLE_FLAG_CHECK_BM)
-			break;
-	data->deepest_bm_state = i - 1;
 
 	return 0;
 }
diff -urN a/include/linux/cpuidle.h b/include/linux/cpuidle.h
--- a/include/linux/cpuidle.h	2007-08-15 21:52:11.000000000 -0400
+++ b/include/linux/cpuidle.h	2007-08-15 22:07:40.000000000 -0400
@@ -114,7 +114,6 @@
 
 struct cpuidle_driver {
 	char			name[CPUIDLE_NAME_LEN];
-	int  (*bm_check)	(void);
 	struct module 		*owner;
 };
 
@@ -169,15 +168,12 @@
 
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
 extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
-extern int cpuidle_get_bm_activity(void);
 
 #else
 
 static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
 static inline void cpuidle_unregister_governor(struct cpuidle_governor *gov) { }
-static inline int cpuidle_get_bm_activity(void)
-{return 0;}
 
 #endif
 
