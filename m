From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3] cpufreq: cpufreq-cpu0: defer probe when regulator is not ready
Date: Wed, 1 May 2013 08:38:12 -0500
Message-ID: <1367415492-20956-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970Ab3EANiS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 May 2013 09:38:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>

With commit 1e4b545, regulator_get will now return -EPROBE_DEFER
when the cpu0-supply node is present, but the regulator is not yet
registered.

It is possible for this to occur when the regulator registration
by itself might be defered due to some dependent interface not yet
instantiated. For example: an regulator which uses I2C and GPIO might
need both systems available before proceeding, in this case, the
regulator might defer it's registration.

However, the cpufreq-cpu0 driver assumes that any un-successful return
result is equivalent of failure.

When the regulator_get returns failure other than -EPROBE_DEFER, it
makes sense to assume that supply node is not present and proceed with
the assumption that only clock control is necessary in the platform.

With this change, we can now handle the following conditions:
a) cpu0-supply binding is not present, regulator_get will return
appropriate error result, resulting in cpufreq-cpu0 driver controlling
just the clock.
b) cpu0-supply binding is present, regulator_get returns
-EPROBE_DEFER, we retry resulting in cpufreq-cpu0 driver registering
later once the regulator is available.
c) cpu0-supply binding is present, regulator_get returns
-EPROBE_DEFER, however, regulator never registers, we retry until
cpufreq-cpu0 driver fails to register pointing at device tree
information bug. However, in this case, the fact that cpufreq-cpu0
operates with clock only when the DT binding clearly indicates need of
a supply is a bug of it's own.
d) cpu0-supply gets an regulator at probe - cpufreq-cpu0 driver
controls both the clock and regulator

Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
V3: Changes since V1 (for 3.10-rc2?)
	review comment updates (and dropped Viresh's original ack ;) ).
   	Now that regulator patch https://patchwork.kernel.org/patch/2451211/
	has been merged to master
	based on git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.10-rc1

V2: https://patchwork.kernel.org/patch/2505311/
V1: https://patchwork.kernel.org/patch/2396541/

 drivers/cpufreq/cpufreq-cpu0.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 3ab8294..ecd8af9 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -195,6 +195,22 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	cpu_dev = &pdev->dev;
 	cpu_dev->of_node = np;
 
+	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
+	if (IS_ERR(cpu_reg)) {
+		/*
+		 * If cpu0 regulator supply node is present, but regulator is
+		 * not yet registered, we should try defering probe.
+		 */
+		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
+			dev_err(cpu_dev, "cpu0 regulator not ready, retry\n");
+			ret = -EPROBE_DEFER;
+			goto out_put_node;
+		}
+		pr_warn("failed to get cpu0 regulator: %ld\n",
+			PTR_ERR(cpu_reg));
+		cpu_reg = NULL;
+	}
+
 	cpu_clk = devm_clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
@@ -202,12 +218,6 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 		goto out_put_node;
 	}
 
-	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
-	if (IS_ERR(cpu_reg)) {
-		pr_warn("failed to get cpu0 regulator\n");
-		cpu_reg = NULL;
-	}
-
 	ret = of_init_opp_table(cpu_dev);
 	if (ret) {
 		pr_err("failed to init OPP table: %d\n", ret);
-- 
1.7.9.5

