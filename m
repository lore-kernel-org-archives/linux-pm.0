From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 8/8] PM / devfreq: exynos-bus: Register cooling device
Date: Fri, 13 Oct 2017 16:48:24 +0900
Message-ID: <1507880904-31956-9-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074837epcas1p49957bd030fc1a27cc845d63c50ad0aba@epcas1p4.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch registers the Exynos Bus-Frequency scaling device
as a cooling device of thermal management.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/devfreq/exynos-bus.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c25658b26598..1c7521b65c2f 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -41,6 +42,8 @@ struct exynos_bus {
 	struct clk *clk;
 	unsigned int voltage_tolerance;
 	unsigned int ratio;
+
+	struct thermal_cooling_device *cdev;
 };
 
 /*
@@ -468,6 +471,19 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	/*
+	 * Register devfreq cooling device if thermal DT code
+	 * takes care of matching them.
+	 */
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		bus->cdev = of_devfreq_cooling_register(np, bus->devfreq);
+		if (IS_ERR(bus->cdev)) {
+			dev_err(dev, "running exynos-bus without cooling device\n");
+			bus->cdev = NULL;
+		}
+	}
+	of_node_put(np);
+
 	goto out;
 passive:
 	/* Initialize the struct profile and governor data for passive device */
@@ -514,6 +530,16 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int exynos_bus_remove(struct platform_device *pdev)
+{
+	struct exynos_bus *bus = platform_get_drvdata(pdev);
+
+	if (bus->cdev)
+		devfreq_cooling_unregister(bus->cdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int exynos_bus_resume(struct device *dev)
 {
@@ -556,6 +582,7 @@ static int exynos_bus_suspend(struct device *dev)
 
 static struct platform_driver exynos_bus_platdrv = {
 	.probe		= exynos_bus_probe,
+	.remove		= exynos_bus_remove,
 	.driver = {
 		.name	= "exynos-bus",
 		.pm	= &exynos_bus_pm,
-- 
1.9.1
