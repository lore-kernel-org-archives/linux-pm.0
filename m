From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 08/18] cpufreq: exynos: Use device tree to determine if
 cpufreq cooling should be registered
Date: Fri, 23 Jan 2015 13:14:20 +0100
Message-ID: <1422015260-14225-1-git-send-email-l.majewski@samsung.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

With thermal subsystem rework it is necessary to tune current cpufreq code
to use cpu frequency change as a potential cooling device.

Now the cpu cooling device is registered only when proper nodes and properties
are available in device tree. Lack of them, however, will not prevent
cpufreq for normal operation.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v6:
- New patch

---
 drivers/cpufreq/exynos-cpufreq.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index f99a0b0..5e98c6b 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -18,10 +18,13 @@
 #include <linux/cpufreq.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpu.h>
 
 #include "exynos-cpufreq.h"
 
 static struct exynos_dvfs_info *exynos_info;
+static struct thermal_cooling_device *cdev;
 static struct regulator *arm_regulator;
 static unsigned int locking_frequency;
 
@@ -156,6 +159,7 @@ static struct cpufreq_driver exynos_driver = {
 
 static int exynos_cpufreq_probe(struct platform_device *pdev)
 {
+	struct device_node *cpus, *np;
 	int ret = -EINVAL;
 
 	exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
@@ -198,9 +202,36 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	/* Done here as we want to capture boot frequency */
 	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
 
-	if (!cpufreq_register_driver(&exynos_driver))
+	ret = cpufreq_register_driver(&exynos_driver);
+	if (ret)
+		goto err_cpufreq_reg;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus) {
+		pr_err("failed to find cpus node\n");
+		return 0;
+	}
+
+	np = of_get_next_child(cpus, NULL);
+	if (!np) {
+		pr_err("failed to find cpus child node\n");
+		of_node_put(cpus);
 		return 0;
+	}
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		cdev = of_cpufreq_cooling_register(np,
+						   cpu_present_mask);
+		if (IS_ERR(cdev))
+			pr_err("running cpufreq without cooling device: %ld\n",
+			       PTR_ERR(cdev));
+	}
+	of_node_put(np);
+	of_node_put(cpus);
+
+	return 0;
 
+err_cpufreq_reg:
 	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
 	regulator_put(arm_regulator);
 err_vdd_arm:
-- 
2.0.0.rc2
