From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: dt: Support governor tunables per policy
Date: Fri,  9 Sep 2016 16:48:08 +0530
Message-ID: <186c7da02a81faaf13d4b6323c0d331ae0bdd174.1473419844.git.viresh.kumar@linaro.org>
References: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
In-Reply-To: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
References: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Juri.Lelli@arm.com, arnd.bergmann@linaro.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt driver is also used for systems with multiple
clock/voltage domains for CPUs, i.e. multiple cpufreq policies in a
system.

And in such cases the platform users may want to enable "governor
tunables per policy". Support that via platform data, as not all users
of the driver would want that behavior.

Reported-by: Juri Lelli <Juri.Lelli@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c |  7 +++++--
 drivers/cpufreq/cpufreq-dt.c         |  6 ++++++
 drivers/cpufreq/cpufreq-dt.h         | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq-dt.h

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 285ed3e6494e..da2fa27b5b30 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -11,6 +11,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "cpufreq-dt.h"
+
 static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "allwinner,sun4i-a10", },
 	{ .compatible = "allwinner,sun5i-a10s", },
@@ -92,7 +94,8 @@ static int __init cpufreq_dt_platdev_init(void)
 	if (!match)
 		return -ENODEV;
 
-	return PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt", -1,
-							       NULL, 0));
+	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
+			       -1, match->data,
+			       sizeof(struct cpufreq_dt_platform_data)));
 }
 device_initcall(cpufreq_dt_platdev_init);
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 2bd20534155d..5c07ae05d69a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#include "cpufreq-dt.h"
+
 struct private_data {
 	struct device *cpu_dev;
 	struct thermal_cooling_device *cdev;
@@ -353,6 +355,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
+	struct cpufreq_dt_platform_data *data = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	/*
@@ -366,6 +369,9 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (data && data->have_governor_per_policy)
+		dt_cpufreq_driver.flags |= CPUFREQ_HAVE_GOVERNOR_PER_POLICY;
+
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
new file mode 100644
index 000000000000..54d774e46c43
--- /dev/null
+++ b/drivers/cpufreq/cpufreq-dt.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2016 Linaro
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPUFREQ_DT_H__
+#define __CPUFREQ_DT_H__
+
+#include <linux/types.h>
+
+struct cpufreq_dt_platform_data {
+	bool have_governor_per_policy;
+};
+
+#endif /* __CPUFREQ_DT_H__ */
-- 
2.7.1.410.g6faf27b
