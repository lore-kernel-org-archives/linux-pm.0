From: dbasehore@chromium.org
Subject: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Wed,  1 Jun 2016 21:33:29 -0700
Message-ID: <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de
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
 drivers/idle/intel_idle.c | 177 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 98565de..e748e0d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -55,15 +55,18 @@
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
+#include <linux/debugfs.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
 #include <linux/sched.h>
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
@@ -93,12 +96,39 @@ struct idle_cpu {
 	bool disable_promotion_to_c1e;
 };
 
+/*
+ * Default chosen to have <= 1% power increase while allowing fast detection of
+ * SLP S0 entry errors. Waking up 10 times a second shows ~30% increase in
+ * system power on Skylake Y. Waking up once every 10 seconds is
+ * indistinguishable from not waking up at all (as ~0.3% power increase would
+ * be). Any reasonable power increases above this will not be visible to the
+ * user.
+ */
+#define DEFAULT_SLP_S0_SECONDS 10
+
+struct timed_freeze_data {
+	u32 slp_s0_saved_count;
+	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv;
+	int index;
+};
+
+static struct dentry *debugfs_dir;
+static struct dentry *slp_s0_file;
+static unsigned int slp_s0_seconds = DEFAULT_SLP_S0_SECONDS;
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
@@ -599,7 +629,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C1E-SKL",
 		.desc = "MWAIT 0x01",
@@ -607,7 +637,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C3-SKL",
 		.desc = "MWAIT 0x10",
@@ -615,7 +645,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 70,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C6-SKL",
 		.desc = "MWAIT 0x20",
@@ -623,7 +653,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C7s-SKL",
 		.desc = "MWAIT 0x33",
@@ -631,7 +661,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 124,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C8-SKL",
 		.desc = "MWAIT 0x40",
@@ -639,7 +669,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C9-SKL",
 		.desc = "MWAIT 0x50",
@@ -647,7 +677,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 480,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.name = "C10-SKL",
 		.desc = "MWAIT 0x60",
@@ -655,7 +685,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.exit_latency = 890,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_freeze = intel_idle_freeze_and_check, },
 	{
 		.enter = NULL }
 };
@@ -869,6 +899,8 @@ static int intel_idle(struct cpuidle_device *dev,
  * @dev: cpuidle_device
  * @drv: cpuidle driver
  * @index: state index
+ *
+ * @return 0 for success, no failure state
  */
 static int intel_idle_freeze(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index)
@@ -881,6 +913,121 @@ static int intel_idle_freeze(struct cpuidle_device *dev,
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
+	if (check_on_this_cpu)
+		slp_s0_check_inprogress = false;
+
+	spin_unlock_irqrestore(&slp_s0_check_lock, flags);
+	return ret;
+}
+
+static ssize_t slp_s0_seconds_read(struct file *fp, char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	char buf[10];
+	int len;
+
+	len = snprintf(buf, 10, "%u\n", slp_s0_seconds);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static ssize_t slp_s0_seconds_write(struct file *fp,
+				    const char __user *user_buf, size_t count,
+				    loff_t *ppos)
+{
+	unsigned int value;
+	int ret;
+
+	ret = kstrtouint_from_user(user_buf, count, 10, &value);
+	if (ret < 0)
+		return -EINVAL;
+
+	slp_s0_seconds = value;
+	if (!slp_s0_seconds)
+		pr_info("SLP S0 validation disabled by userspace\n");
+	return count;
+}
+
+static const struct file_operations slp_s0_fops = {
+	.open = simple_open,
+	.read = slp_s0_seconds_read,
+	.write = slp_s0_seconds_write,
+};
+
 static void __setup_broadcast_timer(void *arg)
 {
 	unsigned long on = (unsigned long)arg;
@@ -1415,6 +1562,17 @@ static int __init intel_idle_init(void)
 	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
 		lapic_timer_reliable_states);
 
+	debugfs_dir = debugfs_create_dir("intel_idle", NULL);
+	if (!debugfs_dir) {
+		pr_warn("intel_idle failed to create debugfs directory\n");
+		return 0;
+	}
+
+	slp_s0_file = debugfs_create_file("slp_s0_seconds", S_IRUSR | S_IWUSR,
+					  debugfs_dir, NULL, &slp_s0_fops);
+	if (!slp_s0_file)
+		pr_warn("intel_idle failed to create debugfs file\n");
+
 	return 0;
 }
 
@@ -1423,6 +1581,9 @@ static void __exit intel_idle_exit(void)
 	struct cpuidle_device *dev;
 	int i;
 
+	debugfs_remove(slp_s0_file);
+	debugfs_remove(debugfs_dir);
+
 	cpu_notifier_register_begin();
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-- 
2.8.0.rc3.226.g39d4020
