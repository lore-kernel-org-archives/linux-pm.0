From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Sun, 13 Jan 2019 20:57:54 +0100
Message-ID: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kgene@kernel.org
Cc: krzk@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

There is possibility, that when probing driver, regulators are not yet
initialized. In this case we should return EPROBE_DEFER and wait till
they're initialized, since they're required currently for cpufreq driver
to work. Also move regulator initialization code at beginning of probe,
so we can defer as fast as posibble.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v3:
  - Zero dmc_base pointers after unmapping them
  - If getting vddarm regulator fails just return, no need to do goto
    jump which would do the same

Changes from v2:
  - Handle all error paths in probe

Changes from v1:
  - Fix compilation error
  - Reorganize code so it's smaller
---
 drivers/cpufreq/s5pv210-cpufreq.c | 67 ++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f51697f1e0b3..c7b7d1e65b08 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
-	int id;
+	int id, result = 0;
 
 	/*
 	 * HACK: This is a temporary workaround to get access to clock
@@ -594,18 +594,39 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * this whole driver as soon as S5PV210 gets migrated to use
 	 * cpufreq-dt driver.
 	 */
+	arm_regulator = regulator_get(NULL, "vddarm");
+	if (IS_ERR(arm_regulator)) {
+		if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
+			pr_debug("vddarm regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddarm\n");
+		return PTR_ERR(arm_regulator);
+	}
+
+	int_regulator = regulator_get(NULL, "vddint");
+	if (IS_ERR(int_regulator)) {
+		if (PTR_ERR(int_regulator) == -EPROBE_DEFER)
+			pr_debug("vddint regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddint\n");
+		result = PTR_ERR(int_regulator);
+		goto err_int_regulator;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
 		pr_err("%s: failed to find clock controller DT node\n",
 			__func__);
-		return -ENODEV;
+		result = -ENODEV;
+		goto err_clock;
 	}
 
 	clk_base = of_iomap(np, 0);
 	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		return -EFAULT;
+		result = -EFAULT;
+		goto err_clock;
 	}
 
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
@@ -614,7 +635,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
 				__func__, np);
 			of_node_put(np);
-			return id;
+			result = id;
+			goto err_clk_base;
 		}
 
 		dmc_base[id] = of_iomap(np, 0);
@@ -622,33 +644,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to map dmc%d registers\n",
 				__func__, id);
 			of_node_put(np);
-			return -EFAULT;
+			result = -EFAULT;
+			goto err_dmc;
 		}
 	}
 
 	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
 		if (!dmc_base[id]) {
 			pr_err("%s: failed to find dmc%d node\n", __func__, id);
-			return -ENODEV;
+			result = -ENODEV;
+			goto err_dmc;
 		}
 	}
 
-	arm_regulator = regulator_get(NULL, "vddarm");
-	if (IS_ERR(arm_regulator)) {
-		pr_err("failed to get regulator vddarm\n");
-		return PTR_ERR(arm_regulator);
-	}
-
-	int_regulator = regulator_get(NULL, "vddint");
-	if (IS_ERR(int_regulator)) {
-		pr_err("failed to get regulator vddint\n");
-		regulator_put(arm_regulator);
-		return PTR_ERR(int_regulator);
-	}
-
 	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
 
 	return cpufreq_register_driver(&s5pv210_driver);
+
+err_dmc:
+	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
+		if (dmc_base[id]) {
+			iounmap(dmc_base[id]);
+			dmc_base[id] = NULL;
+		}
+
+err_clk_base:
+	iounmap(clk_base);
+
+err_clock:
+	regulator_put(int_regulator);
+
+err_int_regulator:
+	regulator_put(arm_regulator);
+
+	return result;
 }
 
 static struct platform_driver s5pv210_cpufreq_platdrv = {
-- 
2.17.1
