From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 2/3] cpufreq: cpufreq-dt: extend with platform_data
Date: Sun, 19 Oct 2014 11:30:28 +0200
Message-ID: <1413711029-17419-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52061 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083AbaJSJak (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Oct 2014 05:30:40 -0400
In-Reply-To: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit extends the cpufreq-dt driver to take a platform_data
structure. This structure is for now used to tell the cpufreq-dt
driver the layout of the clocks on the platform, i.e whether all CPUs
share the same clock or whether each CPU has a separate clock.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++--
 include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/cpufreq-dt.h

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 6bbb8b9..52facda 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -18,6 +18,7 @@
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq-dt.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -178,6 +179,7 @@ try_again:
 
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_dt_platform_data *pd;
 	struct cpufreq_frequency_table *freq_table;
 	struct thermal_cooling_device *cdev;
 	struct device_node *np;
@@ -265,9 +267,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 
 	policy->clk = cpu_clk;
-	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
-	if (ret)
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
+			ret);
 		goto out_cooling_unregister;
+	}
+
+	policy->cpuinfo.transition_latency = transition_latency;
+
+	pd = cpufreq_get_driver_data();
+	if (pd && !pd->independent_clocks)
+		cpumask_setall(policy->cpus);
 
 	of_node_put(np);
 
@@ -335,6 +346,8 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
+	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
+
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(cpu_dev, "failed register driver: %d\n", ret);
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
new file mode 100644
index 0000000..0414009
--- /dev/null
+++ b/include/linux/cpufreq-dt.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2014 Marvell
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPUFREQ_DT_H__
+#define __CPUFREQ_DT_H__
+
+struct cpufreq_dt_platform_data {
+	/*
+	 * True when each CPU has its own clock to control its
+	 * frequency, false when all CPUs are controlled by a single
+	 * clock.
+	 */
+	bool independent_clocks;
+};
+
+#endif /* __CPUFREQ_DT_H__ */
-- 
2.0.0

