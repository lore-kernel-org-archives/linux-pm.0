From: dbasehore@chromium.org
Subject: [PATCH v2 5/5] intel_idle: Add S0ix validation
Date: Wed,  8 Jun 2016 17:43:37 -0700
Message-ID: <1465433017-13602-6-git-send-email-dbasehore@chromium.org>
References: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This adds validation of S0ix entry and enables it on Skylake. Using
the new timed_freeze function, we program the CPU to wake up X seconds
after entering freeze. After X seconds, it will wake the CPU to check
the S0ix residency counters and make sure we entered the lowest power
state for suspend-to-idle.

It exits freeze and reports an error to userspace when the SoC does
not enter S0ix on suspend-to-idle.

One example of a bug that can prevent a Skylake CPU from entering S0ix
(suspend-to-idle) is a leaked reference count to one of the i915 power
wells. The CPU will not be able to enter Package C10 and will
therefore use about 4x as much power for the entire system. The issue
is not specific to the i915 power wells though.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/idle/intel_idle.c | 153 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 145 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 98565de..85dcbc6 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -61,9 +61,11 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/pmc_core.h>
 
 #define INTEL_IDLE_VERSION "0.4.1"
 #define PREFIX "intel_idle: "
@@ -93,12 +95,36 @@ struct idle_cpu {
 	bool disable_promotion_to_c1e;
 };
 
+/*
+ * The limit for the exponential backoff for the freeze duration. At this point,
+ * power impact is is far from measurable. An estimate is about 3uW based on
+ * scaling from waking up 10 times a second.
+ */
+#define MAX_SLP_S0_SECONDS 1000
+#define SLP_S0_EXP_BASE 10
+
+struct timed_freeze_data {
+	u32 slp_s0_saved_count;
+	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv;
+	int index;
+};
+
+static bool slp_s0_check;
+static unsigned int slp_s0_seconds;
+
+static DEFINE_SPINLOCK(slp_s0_check_lock);
+static unsigned int slp_s0_num_cpus;
+static bool slp_s0_check_inprogress;
+
 static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
 static int intel_idle_freeze(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index);
+static int intel_idle_freeze_and_check(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index);
 static int intel_idle_cpu_init(int cpu);
 
 static struct cpuidle_state *cpuidle_state_table;
@@ -599,7 +625,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C1E-SKL",
 		.desc = "MWAIT 0x01",
@@ -607,7 +633,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C3-SKL",
 		.desc = "MWAIT 0x10",
@@ -615,7 +641,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 70,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C6-SKL",
 		.desc = "MWAIT 0x20",
@@ -623,7 +649,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C7s-SKL",
 		.desc = "MWAIT 0x33",
@@ -631,7 +657,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 124,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C8-SKL",
 		.desc = "MWAIT 0x40",
@@ -639,7 +665,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C9-SKL",
 		.desc = "MWAIT 0x50",
@@ -647,7 +673,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 480,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C10-SKL",
 		.desc = "MWAIT 0x60",
@@ -655,7 +681,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 890,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.enter = NULL }
 };
@@ -869,6 +895,8 @@ static int intel_idle(struct cpuidle_device *dev,
  * @dev: cpuidle_device
  * @drv: cpuidle driver
  * @index: state index
+ *
+ * @return 0 for success, no failure state
  */
 static int intel_idle_freeze(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index)
@@ -881,6 +909,105 @@ static int intel_idle_freeze(struct cpuidle_device *dev,
 	return 0;
 }
 
+static int intel_idle_freeze_wrapper(void *data)
+{
+	struct timed_freeze_data *tfd = data;
+
+	return intel_idle_freeze(tfd->dev, tfd->drv, tfd->index);
+}
+
+static int check_slp_s0(void *data)
+{
+	struct timed_freeze_data *tfd = data;
+	u32 slp_s0_new_count;
+
+	if (intel_pmc_slp_s0_counter_read(&slp_s0_new_count)) {
+		pr_warn("Unable to read SLP S0 residency counter\n");
+		return -EIO;
+	}
+
+	if (tfd->slp_s0_saved_count == slp_s0_new_count) {
+		pr_warn("CPU did not enter SLP S0 for suspend-to-idle.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * intel_idle_freeze_and_check - enters suspend-to-idle and validates the power
+ * state
+ *
+ * This function enters suspend-to-idle with intel_idle_freeze, but also sets up
+ * a timer to check that S0ix (low power state for suspend-to-idle on Intel
+ * CPUs) is properly entered.
+ *
+ * @dev: cpuidle_device
+ * @drv: cpuidle_driver
+ * @index: state index
+ * @return 0 for success, -EERROR if S0ix was not entered.
+ */
+static int intel_idle_freeze_and_check(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
+{
+	bool check_on_this_cpu = false;
+	struct timed_freeze_ops ops;
+	struct timed_freeze_data tfd;
+	unsigned long flags;
+	int ret = 0;
+
+	/* The last CPU to freeze sets up checking SLP S0 assertion. */
+	spin_lock_irqsave(&slp_s0_check_lock, flags);
+	if (slp_s0_seconds &&
+	    ++slp_s0_num_cpus == num_online_cpus() &&
+	    !slp_s0_check_inprogress &&
+	    !intel_pmc_slp_s0_counter_read(&tfd.slp_s0_saved_count)) {
+		tfd.dev = dev;
+		tfd.drv = drv;
+		tfd.index = index;
+		ops.enter_freeze = intel_idle_freeze_wrapper;
+		ops.callback = check_slp_s0;
+		check_on_this_cpu = true;
+		/*
+		 * Make sure check_slp_s0 isn't scheduled on another CPU if it
+		 * were to leave freeze and enter it again before this CPU
+		 * leaves freeze.
+		 */
+		slp_s0_check_inprogress = true;
+	}
+	spin_unlock_irqrestore(&slp_s0_check_lock, flags);
+
+	if (check_on_this_cpu)
+		ret = timed_freeze(&ops, &tfd, ktime_set(slp_s0_seconds, 0));
+	else
+		ret = intel_idle_freeze(dev, drv, index);
+
+	spin_lock_irqsave(&slp_s0_check_lock, flags);
+	slp_s0_num_cpus--;
+	if (check_on_this_cpu) {
+		slp_s0_check_inprogress = false;
+		slp_s0_seconds = min_t(unsigned int,
+				       SLP_S0_EXP_BASE * slp_s0_seconds,
+				       MAX_SLP_S0_SECONDS);
+	}
+
+	spin_unlock_irqrestore(&slp_s0_check_lock, flags);
+	return ret;
+}
+
+static int slp_s0_check_prepare(struct notifier_block *nb, unsigned long action,
+				void *data)
+{
+	if (action == PM_SUSPEND_PREPARE)
+		slp_s0_seconds = slp_s0_check ? 1 : 0;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block intel_slp_s0_check_nb = {
+	.notifier_call = slp_s0_check_prepare,
+};
+
 static void __setup_broadcast_timer(void *arg)
 {
 	unsigned long on = (unsigned long)arg;
@@ -1391,6 +1518,13 @@ static int __init intel_idle_init(void)
 		return retval;
 	}
 
+	retval = register_pm_notifier(&intel_slp_s0_check_nb);
+	if (retval) {
+		free_percpu(intel_idle_cpuidle_devices);
+		cpuidle_unregister_driver(&intel_idle_driver);
+		return retval;
+	}
+
 	cpu_notifier_register_begin();
 
 	for_each_online_cpu(i) {
@@ -1398,6 +1532,7 @@ static int __init intel_idle_init(void)
 		if (retval) {
 			intel_idle_cpuidle_devices_uninit();
 			cpu_notifier_register_done();
+			unregister_pm_notifier(&intel_slp_s0_check_nb);
 			cpuidle_unregister_driver(&intel_idle_driver);
 			free_percpu(intel_idle_cpuidle_devices);
 			return retval;
@@ -1436,6 +1571,7 @@ static void __exit intel_idle_exit(void)
 
 	cpu_notifier_register_done();
 
+	unregister_pm_notifier(&intel_slp_s0_check_nb);
 	cpuidle_unregister_driver(&intel_idle_driver);
 	free_percpu(intel_idle_cpuidle_devices);
 }
@@ -1444,6 +1580,7 @@ module_init(intel_idle_init);
 module_exit(intel_idle_exit);
 
 module_param(max_cstate, int, 0444);
+module_param(slp_s0_check, bool, 0644);
 
 MODULE_AUTHOR("Len Brown <len.brown@intel.com>");
 MODULE_DESCRIPTION("Cpuidle driver for Intel Hardware v" INTEL_IDLE_VERSION);
-- 
2.8.0.rc3.226.g39d4020
