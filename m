From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] cpuidle: Make cpuidle_enable_device() call
 poll_idle_init()
Date: Wed, 12 Jan 2011 22:39:52 -0500
Message-ID: <d8c216cfa57e8a579f41729cbb88c97835d9ac8d.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
In-reply-to: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The following scenario is possible with the current cpuidle code and
the ACPI cpuidle driver:
(1) acpi_processor_cst_has_changed() is called,
(2) cpuidle_disable_device() is called,
(3) cpuidle_remove_state_sysfs() is called to remove the (presumably
    outdated) states info from sysfs,
(3) acpi_processor_get_power_info() is called, the first entry in the
    pr->power.states[] table is filled with zeros,
(4) acpi_processor_setup_cpuidle() is called and it doesn't fill the
    first entry in pr->power.states[],
(5) cpuidle_enable_device() is called,
(6) __cpuidle_register_device() is _not_ called, since the device has
    already been registered,
(7) Consequently, poll_idle_init() is _not_ called either,
(8) cpuidle_add_state_sysfs() is called to create the sysfs attributes
    for the new states and it uses the bogus first table entry from
    acpi_processor_get_power_info() for creating state0.

This problem is avoided if cpuidle_enable_device()
unconditionally calls poll_idle_init().

Reported-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
cc: stable@kernel.org
---
 drivers/cpuidle/cpuidle.c |   82 ++++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a507108..97df791 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -154,6 +154,45 @@ void cpuidle_resume_and_unlock(void)
 
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
 
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+static int poll_idle(struct cpuidle_device *dev, struct cpuidle_state *st)
+{
+	ktime_t	t1, t2;
+	s64 diff;
+	int ret;
+
+	t1 = ktime_get();
+	local_irq_enable();
+	while (!need_resched())
+		cpu_relax();
+
+	t2 = ktime_get();
+	diff = ktime_to_us(ktime_sub(t2, t1));
+	if (diff > INT_MAX)
+		diff = INT_MAX;
+
+	ret = (int) diff;
+	return ret;
+}
+
+static void poll_idle_init(struct cpuidle_device *dev)
+{
+	struct cpuidle_state *state = &dev->states[0];
+
+	cpuidle_set_statedata(state, NULL);
+
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
+	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
+	state->exit_latency = 0;
+	state->target_residency = 0;
+	state->power_usage = -1;
+	state->flags = CPUIDLE_FLAG_POLL;
+	state->enter = poll_idle;
+}
+#else
+static void poll_idle_init(struct cpuidle_device *dev) {}
+#endif /* CONFIG_ARCH_HAS_CPU_RELAX */
+
 /**
  * cpuidle_enable_device - enables idle PM for a CPU
  * @dev: the CPU
@@ -178,6 +217,8 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 			return ret;
 	}
 
+	poll_idle_init(dev);
+
 	if ((ret = cpuidle_add_state_sysfs(dev)))
 		return ret;
 
@@ -232,45 +273,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int poll_idle(struct cpuidle_device *dev, struct cpuidle_state *st)
-{
-	ktime_t	t1, t2;
-	s64 diff;
-	int ret;
-
-	t1 = ktime_get();
-	local_irq_enable();
-	while (!need_resched())
-		cpu_relax();
-
-	t2 = ktime_get();
-	diff = ktime_to_us(ktime_sub(t2, t1));
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	ret = (int) diff;
-	return ret;
-}
-
-static void poll_idle_init(struct cpuidle_device *dev)
-{
-	struct cpuidle_state *state = &dev->states[0];
-
-	cpuidle_set_statedata(state, NULL);
-
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
-	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
-	state->exit_latency = 0;
-	state->target_residency = 0;
-	state->power_usage = -1;
-	state->flags = CPUIDLE_FLAG_POLL;
-	state->enter = poll_idle;
-}
-#else
-static void poll_idle_init(struct cpuidle_device *dev) {}
-#endif /* CONFIG_ARCH_HAS_CPU_RELAX */
-
 /**
  * __cpuidle_register_device - internal register function called before register
  * and enable routines
@@ -291,8 +293,6 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	init_completion(&dev->kobj_unregister);
 
-	poll_idle_init(dev);
-
 	/*
 	 * cpuidle driver should set the dev->power_specified bit
 	 * before registering the device if the driver provides
-- 
1.7.4.rc1.14.g7fad99
