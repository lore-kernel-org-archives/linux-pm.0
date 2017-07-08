From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Fri,  7 Jul 2017 17:03:03 -0700
Message-ID: <20170708000303.21863-5-dbasehore@chromium.org>
References: <20170708000303.21863-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds validation of S0ix entry and enables it on Skylake. Using
the new tick_set_freeze_event function, we program the CPU to wake up
X seconds after entering freeze. After X seconds, it will wake the CPU
to check the S0ix residency counters and make sure we entered the
lowest power state for suspend-to-idle.

It exits freeze and reports an error to userspace when the SoC does
not enter S0ix on suspend-to-idle.

One example of a bug that can prevent a Skylake CPU from entering S0ix
(suspend-to-idle) is a leaked reference count to one of the i915 power
wells. The CPU will not be able to enter Package C10 and will
therefore use about 4x as much power for the entire system. The issue
is not specific to the i915 power wells though.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/idle/intel_idle.c | 142 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ebed3f804291..d38621da6e54 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -61,10 +61,12 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/suspend.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/pmc_core.h>
 
 #define INTEL_IDLE_VERSION "0.4.1"
 
@@ -93,12 +95,29 @@ struct idle_cpu {
 	bool disable_promotion_to_c1e;
 };
 
+/*
+ * The limit for the exponential backoff for the freeze duration. At this point,
+ * power impact is is far from measurable. It's about 3uW based on scaling from
+ * waking up 10 times a second.
+ */
+#define MAX_SLP_S0_SECONDS 1000
+#define SLP_S0_EXP_BASE 10
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
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
@@ -597,7 +616,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -605,7 +624,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -613,7 +632,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 70,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -621,7 +640,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x33",
@@ -629,7 +648,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 124,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -637,7 +656,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -645,7 +664,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 480,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -653,7 +672,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 890,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.enter = NULL }
 };
@@ -940,6 +959,8 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
  * @dev: cpuidle_device
  * @drv: cpuidle driver
  * @index: state index
+ *
+ * @return 0 for success, no failure state
  */
 static int intel_idle_freeze(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index)
@@ -952,6 +973,101 @@ static int intel_idle_freeze(struct cpuidle_device *dev,
 	return 0;
 }
 
+static int check_slp_s0(u32 slp_s0_saved_count)
+{
+	u32 slp_s0_new_count;
+
+	if (intel_pmc_slp_s0_counter_read(&slp_s0_new_count)) {
+		pr_warn("Unable to read SLP S0 residency counter\n");
+		return -EIO;
+	}
+
+	if (slp_s0_saved_count == slp_s0_new_count) {
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
+	u32 slp_s0_saved_count;
+	unsigned long flags;
+	int cpu = smp_processor_id();
+	int ret;
+
+	/* The last CPU to freeze sets up checking SLP S0 assertion. */
+	spin_lock_irqsave(&slp_s0_check_lock, flags);
+	slp_s0_num_cpus++;
+	if (slp_s0_seconds &&
+	    slp_s0_num_cpus == num_online_cpus() &&
+	    !slp_s0_check_inprogress &&
+	    !intel_pmc_slp_s0_counter_read(&slp_s0_saved_count)) {
+		ret = tick_set_freeze_event(cpu, ktime_set(slp_s0_seconds, 0));
+		if (ret < 0) {
+			spin_unlock_irqrestore(&slp_s0_check_lock, flags);
+			goto out;
+		}
+
+		/*
+		 * Make sure check_slp_s0 isn't scheduled on another CPU if it
+		 * were to leave freeze and enter it again before this CPU
+		 * leaves freeze.
+		 */
+		slp_s0_check_inprogress = true;
+		check_on_this_cpu = true;
+	}
+	spin_unlock_irqrestore(&slp_s0_check_lock, flags);
+
+	ret = intel_idle_freeze(dev, drv, index);
+	if (ret < 0)
+		goto out;
+
+	if (check_on_this_cpu && tick_clear_freeze_event(cpu))
+		ret = check_slp_s0(slp_s0_saved_count);
+
+out:
+	spin_lock_irqsave(&slp_s0_check_lock, flags);
+	if (check_on_this_cpu) {
+		slp_s0_check_inprogress = false;
+		slp_s0_seconds = min_t(unsigned int,
+				       SLP_S0_EXP_BASE * slp_s0_seconds,
+				       MAX_SLP_S0_SECONDS);
+	}
+	slp_s0_num_cpus--;
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
 static void __setup_broadcast_timer(bool on)
 {
 	if (on)
@@ -1454,6 +1570,13 @@ static int __init intel_idle_init(void)
 		goto init_driver_fail;
 	}
 
+	retval = register_pm_notifier(&intel_slp_s0_check_nb);
+	if (retval) {
+		free_percpu(intel_idle_cpuidle_devices);
+		cpuidle_unregister_driver(&intel_idle_driver);
+		goto pm_nb_fail;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
 
@@ -1469,6 +1592,8 @@ static int __init intel_idle_init(void)
 
 hp_setup_fail:
 	intel_idle_cpuidle_devices_uninit();
+	unregister_pm_notifier(&intel_slp_s0_check_nb);
+pm_nb_fail:
 	cpuidle_unregister_driver(&intel_idle_driver);
 init_driver_fail:
 	free_percpu(intel_idle_cpuidle_devices);
@@ -1484,3 +1609,4 @@ device_initcall(intel_idle_init);
  * is the easiest way (currently) to continue doing that.
  */
 module_param(max_cstate, int, 0444);
+module_param(slp_s0_check, bool, 0644);
-- 
2.13.2.725.g09c95d1e9-goog
