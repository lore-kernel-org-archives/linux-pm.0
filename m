From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 6/7] arm: cpuidle: let genpd handle the cluster power transition with 'power-states'
Date: Fri, 25 Sep 2015 15:04:08 +0200
Message-ID: <1443186249-14596-7-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35146 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbbIYNEj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 09:04:39 -0400
Received: by wicge5 with SMTP id ge5so19891435wic.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2015 06:04:38 -0700 (PDT)
In-Reply-To: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

Cpuidle now handles c-states and power-states differently. c-states do not decrement
 the reference count for the CPUs in the cluster, while power-states i.e.
cluster level states like 'CLUSTER_SLEEP_0' in the case of juno, will.

The 'D1' fake device also registers intermediate power-state,
for experimentation.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm64/boot/dts/arm/juno.dts |  2 +-
 drivers/cpuidle/cpuidle-arm.c    | 50 ++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 10 deletions(-)

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
index ca118ed..592bb1cb 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -39,7 +39,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
-	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -48,11 +47,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 
 	ret = cpu_pm_enter();
 	if (!ret) {
-		/*
-		* Notify runtime PM as well of this cpu powering down
-		* TODO: Merge CPU_PM and runtime PM.
-		*/
-		pm_runtime_put_sync(cpu_dev);
 
 		/*
 		 * Pass idle state index to cpu_suspend which in turn will
@@ -61,6 +55,43 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
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
+ */
+static int arm_enter_power_state(struct cpuidle_device *dev,
+				 struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
+
+	BUG_ON(idx == 0);
+
+	ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		 * Notify runtime PM as well of this cpu powering down
+		 * TODO: Merge CPU_PM and runtime PM.
+		 */
+		pm_runtime_put_sync(cpu_dev);
+
+		arm_cpuidle_suspend(idx);
+
 		pm_runtime_get_sync(cpu_dev);
 		cpu_pm_exit();
 	}
@@ -89,9 +120,10 @@ static struct cpuidle_driver arm_idle_driver = {
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

