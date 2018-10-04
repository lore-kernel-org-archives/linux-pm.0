From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] OPP: Improve error handling in dev_pm_opp_of_cpumask_add_table()
Date: Thu,  4 Oct 2018 09:46:20 +0530
Message-ID: <50b6b87c8484da8bb5dcce00f84ec80aee8fc2bd.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org, d-gerlach@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The error handling wasn't appropriate in
dev_pm_opp_of_cpumask_add_table(). For example it returns 0 on success
and also for the case where cpumask is empty or cpu_device wasn't found
for any of the CPUs.

It should really return error on such cases, so that the callers can be
aware of the outcome.

Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a71ff3acca0f..67a384c8ead2 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -614,16 +614,18 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
-	int cpu, ret = 0;
+	int cpu, ret;
 
-	WARN_ON(cpumask_empty(cpumask));
+	if (WARN_ON(cpumask_empty(cpumask)))
+		return -ENODEV;
 
 	for_each_cpu(cpu, cpumask) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev) {
 			pr_err("%s: failed to get cpu%d device\n", __func__,
 			       cpu);
-			continue;
+			ret = -ENODEV;
+			goto remove_table;
 		}
 
 		ret = dev_pm_opp_of_add_table(cpu_dev);
@@ -635,12 +637,16 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 			pr_debug("%s: couldn't find opp table for cpu:%d, %d\n",
 				 __func__, cpu, ret);
 
-			/* Free all other OPPs */
-			_dev_pm_opp_cpumask_remove_table(cpumask, cpu);
-			break;
+			goto remove_table;
 		}
 	}
 
+	return 0;
+
+remove_table:
+	/* Free all other OPPs */
+	_dev_pm_opp_cpumask_remove_table(cpumask, cpu);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
-- 
2.18.0.rc1.242.g61856ae69a2c
