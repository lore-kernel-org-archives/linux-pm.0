From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v2 5/6] arm: cpuidle: let genpd handle the cluster power transition with 'power-states'
Date: Tue,  6 Oct 2015 16:27:44 +0200
Message-ID: <1444141665-18534-6-git-send-email-mtitinger+renesas@baylibre.com>
References: <20151006022702.GA78570@linaro.org>
 <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: lina.iyer@linaro.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

Cpuidle now handles c-states and power-states differently. c-states do not decrement
 the reference count for the CPUs in the cluster, while power-states i.e.
cluster level states like 'CLUSTER_SLEEP_0' in the case of juno, will.

The 'D1' fake device also registers intermediate power-state,
for experimentation.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm64/boot/dts/arm/juno.dts |  2 +-
 drivers/cpuidle/cpuidle-arm.c    | 52 ++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index cadc5de..0bb0dd7 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -47,7 +47,7 @@
 			};
 
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state","arm,power-state";
+				compatible = "arm,power-state";
 				arm,psci-suspend-param = <0x1010000>;
 				local-timer-stop;
 				entry-latency-us = <800>;
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 7c791f9..8dd5dc3 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -40,7 +40,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
-	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -50,18 +49,49 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
-		 * Notify runtime PM as well of this cpu powering down
-		 * TODO: Merge CPU_PM and runtime PM.
-		 */
-		RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
-
-		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
 
+		cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
+
+/*
+ * arm_enter_power_state - delegate state trasition to genpd
+ *
+ * dev: cpuidle device
+ * drv: cpuidle driver
+ * idx: state index
+ *
+ * Called from the CPUidle framework to delegate a state transition
+ * to the generic domain. This will be a cluster poweroff state
+ * the Domain will chose to actually turn off the cluster based on
+ * the status of other CPUs, and devices and subdomains in the Cluster
+ * domain.
+*/
+static int arm_enter_power_state(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
+
+	BUG_ON(idx == 0);
+
+	ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		* Notify runtime PM as well of this cpu powering down
+		* TODO: Merge CPU_PM and runtime PM.
+		*/
+		RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
+
+		arm_cpuidle_suspend(idx);
+
 		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
@@ -69,6 +99,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	return ret ? -1 : idx;
 }
 
+
 static struct cpuidle_driver arm_idle_driver = {
 	.name = "arm_idle",
 	.owner = THIS_MODULE,
@@ -90,9 +121,10 @@ static struct cpuidle_driver arm_idle_driver = {
 };
 
 static const struct of_device_id arm_idle_state_match[] __initconst = {
-	{ .compatible = "arm,idle-state",
-	  .data = arm_enter_idle_state },
-	{ },
+	{.compatible = "arm,idle-state",
+	 .data = arm_enter_idle_state},
+	{.compatible = "arm,power-state",
+	 .data = arm_enter_power_state},
 };
 
 /*
-- 
1.9.1
