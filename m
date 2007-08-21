From: Adam Belay <abelay@novell.com>
Subject: [PATCH 2/6] CPUIDLE: menu governor updates
Date: Tue, 21 Aug 2007 18:25:14 -0400
Message-ID: <1187735114.7199.49.camel__17678.5439638936$1187740237$gmane$org@callisto.site>
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

This patch tweaks the menu governor to more effectively handle non-timer
break events.  Non-timer break events are detected by comparing the
actual sleep time to the expected sleep time.  In future revisions, it
may be more reliable to use the timer data structures directly.

Please Apply,
Adam

Change Summary:
 menu.c |   46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)
---

diff -urN a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
--- a/drivers/cpuidle/governors/menu.c	2007-08-13 00:02:10.000000000 -0400
+++ b/drivers/cpuidle/governors/menu.c	2007-08-13 02:00:09.000000000 -0400
@@ -15,15 +15,19 @@
 #include <linux/tick.h>
 
 #define BM_HOLDOFF	2000	/* 2 ms */
+#define BREAK_FUZZ	4	/* 4 us */
 
 struct menu_device {
-	int	last_state_idx;
+	int		last_state_idx;
 
-	int	predicted_us;
-	int	last_measured_us;
-	int	deepest_bm_state;
-	int	bm_elapsed_us;
-	int	bm_holdoff_us;
+	unsigned int	expected_us;
+	unsigned int	predicted_us;
+	unsigned int	last_measured_us;
+	unsigned int	elapsed_us;
+
+	int		deepest_bm_state;
+	unsigned int	bm_elapsed_us;
+	unsigned int	bm_holdoff_us;
 };
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -35,10 +39,11 @@
 static int menu_select(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
-	int i, expected_us, max_state = dev->state_count;
+	int i, max_state = dev->state_count;
 
 	/* determine the expected residency time */
-	expected_us = (s32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
+	data->expected_us =
+		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
 
 	/* determine the maximum state compatible with current BM status */
 	if (cpuidle_get_bm_activity())
@@ -50,7 +55,7 @@
 	for (i = 1; i < max_state; i++) {
 		struct cpuidle_state *s = &dev->states[i];
 
-		if (s->target_residency > expected_us)
+		if (s->target_residency > data->expected_us)
 			break;
 		if (s->target_residency > data->predicted_us)
 			break;
@@ -73,7 +78,8 @@
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int last_idx = data->last_state_idx;
-	int measured_us = cpuidle_get_last_residency(dev);
+	unsigned int measured_us =
+		cpuidle_get_last_residency(dev) + data->elapsed_us;
 	struct cpuidle_state *target = &dev->states[last_idx];
 
 	/*
@@ -90,8 +96,17 @@
 		data->bm_elapsed_us += measured_us;
 
 	/* Predict time remaining until next break event */
-	data->predicted_us = max(measured_us, data->last_measured_us);
-	data->last_measured_us = measured_us;
+	if (measured_us + BREAK_FUZZ < data->expected_us - target->exit_latency) {
+		data->predicted_us = max(measured_us, data->last_measured_us);
+		data->last_measured_us = measured_us;
+		data->elapsed_us = 0;
+	} else {
+		if (data->elapsed_us < data->elapsed_us + measured_us)
+			data->elapsed_us = measured_us;
+		else
+			data->elapsed_us = -1;
+		data->predicted_us = max(measured_us, data->last_measured_us);
+	}
 }
 
 /**
@@ -103,10 +118,7 @@
 	struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
 	int i;
 
-	data->last_state_idx = 0;
-	data->predicted_us = 0;
-	data->last_measured_us = 0;
-	data->bm_elapsed_us = 0;
+	memset(data, 0, sizeof(struct menu_device));
 	data->bm_holdoff_us = BM_HOLDOFF;
 
 	for (i = 1; i < dev->state_count; i++)
@@ -117,7 +129,7 @@
 	return 0;
 }
 
-struct cpuidle_governor menu_governor = {
+static struct cpuidle_governor menu_governor = {
 	.name =		"menu",
 	.rating =	20,
 	.enable =	menu_enable_device,
