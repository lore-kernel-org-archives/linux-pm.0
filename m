From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 2/8] devfreq: exynos4: Support devicetree to get device id of
 Exynos4 SoC
Date: Fri, 14 Mar 2014 18:30:02 +0900
Message-ID: <1394789408-14648-3-git-send-email-cw00.choi@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch support DT(DeviceTree) method to probe exynos4_bus and get device
id of each Exynos4 SoC by using dt helper function.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index 378e4bd..2d2b44b 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -23,6 +23,7 @@
 #include <linux/devfreq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of.h>
 #include <linux/module.h>
 
 /* Exynos4 ASV has been in the mailing list, but not upstreamed, yet. */
@@ -1014,6 +1015,28 @@ unlock:
 	return NOTIFY_DONE;
 }
 
+static struct of_device_id exynos4_busfreq_id_match[] = {
+	{
+		.compatible = "samsung,exynos4210-busfreq",
+		.data = (void *)TYPE_BUSF_EXYNOS4210,
+	}, {
+		.compatible = "samsung,exynos4x12-busfreq",
+		.data = (void *)TYPE_BUSF_EXYNOS4x12,
+	},
+};
+
+static int exynos4_busfreq_get_driver_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+
+	match = of_match_node(exynos4_busfreq_id_match, dev->of_node);
+	if (!match)
+		return -ENODEV;
+
+	return (int) match->data;
+}
+
 static int exynos4_busfreq_probe(struct platform_device *pdev)
 {
 	struct busfreq_data *data;
@@ -1027,7 +1050,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	data->type = pdev->id_entry->driver_data;
+	data->type = exynos4_busfreq_get_driver_data(pdev);
 	data->dmc[0].hw_base = S5P_VA_DMC0;
 	data->dmc[1].hw_base = S5P_VA_DMC1;
 	data->pm_notifier.notifier_call = exynos4_busfreq_pm_notifier_event;
@@ -1151,6 +1174,7 @@ static struct platform_driver exynos4_busfreq_driver = {
 		.name	= "exynos4-busfreq",
 		.owner	= THIS_MODULE,
 		.pm	= &exynos4_busfreq_pm,
+		.of_match_table = exynos4_busfreq_id_match,
 	},
 };
 
-- 
1.8.0
