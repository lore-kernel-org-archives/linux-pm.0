From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 7/9] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date: Tue, 29 Jan 2019 10:25:13 +0530
Message-ID: <3c0f9702f2d68f684b16c4ab5dbb3222d64127e7.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/qoriq-cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f64b4df..4295e5476264 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -13,7 +13,6 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -31,7 +30,6 @@
 struct cpu_data {
 	struct clk **pclk;
 	struct cpufreq_frequency_table *table;
-	struct thermal_cooling_device *cdev;
 };
 
 /*
@@ -239,7 +237,6 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
-	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
@@ -258,23 +255,15 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 	return clk_set_parent(policy->clk, parent);
 }
 
-
-static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct cpu_data *cpud = policy->driver_data;
-
-	cpud->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.name		= "qoriq_cpufreq",
-	.flags		= CPUFREQ_CONST_LOOPS,
+	.flags		= CPUFREQ_CONST_LOOPS |
+			  CPUFREQ_IS_COOLING_DEV,
 	.init		= qoriq_cpufreq_cpu_init,
 	.exit		= qoriq_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
-	.ready		= qoriq_cpufreq_ready,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
2.17.1
