From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/4] cpufreq: cpufreq-dt: extend with platform_data
Date: Wed, 10 Sep 2014 11:41:50 +0200
Message-ID: <1410342112-13264-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

This commit extends the cpufreq-dt driver to take a platform_data
structure. This structure is for now used to tell the cpufreq-dt
driver the layout of the clocks on the platform, i.e whether all CPUs
share the same clock or whether each CPU has a separate clock.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpufreq/cpufreq-dt.c | 20 ++++++++++++++++++--
 include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/cpufreq-dt.h

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e002650..35d396e 100644
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
@@ -28,6 +29,9 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+/* cpufreq_driver->flags values */
+#define CPUFREQ_DT_INDEPENDENT_CLOCKS (1 << 16)
+
 struct private_data {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -266,9 +270,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
+	if (!(cpufreq_get_driver_flags() & CPUFREQ_DT_INDEPENDENT_CLOCKS))
+		cpumask_setall(policy->cpus);
 
 	return 0;
 
@@ -314,6 +326,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
+	struct cpufreq_dt_platform_data *pd = dev_get_platdata(&pdev->dev);
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
@@ -334,6 +347,9 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
+	if (pd->independent_clocks)
+		dt_cpufreq_driver.flags |= CPUFREQ_DT_INDEPENDENT_CLOCKS;
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
