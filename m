From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: [PATCH] cpuidle: menu governor: reduce latency on exit
Date: Sun, 19 Jul 2009 16:59:46 +0200
Message-ID: <200907191659.47179.czoccolo__44510.8220832937$1248015631$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: venkatesh.pallipadi@intel.com, abelay@novell.com
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch moves the state residency accounting and statistics
computation off the hot exit path.
On exit, the need to recompute statistics is recorded, and new
statistics will be computed when menu_select is called again.

Signed-off-by: Corrado Zoccolo <czoccolo@gmail.com>

---
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index f1df59f..5e905e0 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,6 +19,7 @@
 
 struct menu_device {
 	int		last_state_idx;
+	int             needs_update;
 
 	unsigned int	expected_us;
 	unsigned int	predicted_us;
@@ -29,6 +30,8 @@ struct menu_device {
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
 
+static void menu_update(struct cpuidle_device *dev);
+
 /**
  * menu_select - selects the next idle state to enter
  * @dev: the CPU
@@ -39,6 +42,11 @@ static int menu_select(struct cpuidle_device *dev)
 	int latency_req = pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 
+	if (data->needs_update) {
+		menu_update(dev);
+		data->needs_update = 0;
+	}
+
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0)) {
 		data->last_state_idx = 0;
@@ -72,7 +80,7 @@ static int menu_select(struct cpuidle_device *dev)
 }
 
 /**
- * menu_reflect - attempts to guess what happened after entry
+ * menu_reflect - records that data structures need update
  * @dev: the CPU
  *
  * NOTE: it's important to be fast here because this operation will add to
@@ -81,6 +89,16 @@ static int menu_select(struct cpuidle_device *dev)
 static void menu_reflect(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
+	data->needs_update = 1;
+}
+
+/**
+ * menu_update - attempts to guess what happened after entry
+ * @dev: the CPU
+ */
+static void menu_update(struct cpuidle_device *dev)
+{
+	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int last_idx = data->last_state_idx;
 	unsigned int last_idle_us = cpuidle_get_last_residency(dev);
 	struct cpuidle_state *target = &dev->states[last_idx];
