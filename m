From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] cpufreq: cpufreq-cpu0: defer probe when regulator is not ready
Date: Tue, 30 Apr 2013 10:13:02 -0500
Message-ID: <1367334782-32484-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: Changes since V1 (for 3.10-rc2?)
Now that regulator patch https://patchwork.kernel.org/patch/2451211/
has been merged to master
based on git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.10-rc1
picked up Acks from:
	http://marc.info/?l=linux-kernel&m=136514242716876&w=2
	http://marc.info/?l=linux-pm&m=136513879016003&w=2

V1: https://patchwork.kernel.org/patch/2396541/
 drivers/cpufreq/cpufreq-cpu0.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 37d23a0..e472167 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -200,6 +200,20 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
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
+			return -EPROBE_DEFER;
+		}
+		pr_err("failed to get cpu0 regulator: %ld\n", PTR_ERR(cpu_reg));
+		cpu_reg = NULL;
+	}
+
 	cpu_clk = devm_clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
@@ -207,12 +221,6 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
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

