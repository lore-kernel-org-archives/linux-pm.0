From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/3] devfreq: exynos4_bus: Enable PPMU's source clock before
 use.
Date: Wed, 11 Jun 2014 10:17:54 +0900
Message-ID: <1402449476-6782-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:63311 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaFKBSC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 21:18:02 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z00HTBCY03Y80@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 11 Jun 2014 10:18:00 +0900 (KST)
In-reply-to: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Current exynos4_bus driver uses PPMUs for DMC0/1 to gauge bus utilization,
and they has own operation clock. It's needed to be enabled before use.
While it isn't gated by default, we should assure if clock is gated.
It'll find related clocks with given name, and if it fails to find then
assumes that they are enabled and keeps probing. Otherwise, it'll try to
enable them and exit the probing unless clocks are enabled successfully.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index d9b08d3..cadad03 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 
 #include <mach/map.h>
 
@@ -79,6 +80,7 @@ struct busfreq_data {
 	struct regulator *vdd_mif; /* Exynos4412/4212 only */
 	struct busfreq_opp_info curr_oppinfo;
 	struct busfreq_ppmu_data ppmu_data;
+	struct clk *clk_ppmu[PPMU_END];
 
 	struct notifier_block pm_notifier;
 	struct mutex lock;
@@ -955,6 +957,28 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		}
 	}
 
+	data->clk_ppmu[PPMU_DMC0] = devm_clk_get(dev, "ppmudmc0");
+	if (IS_ERR(data->clk_ppmu[PPMU_DMC0])) {
+		dev_warn(dev, "Cannot get ppmudmc0 clock\n");
+	} else {
+		err = clk_prepare_enable(data->clk_ppmu[PPMU_DMC0]);
+		if (err) {
+			dev_err(dev, "Cannot enable ppmudmc0 clock\n");
+			return err;
+		}
+	}
+
+	data->clk_ppmu[PPMU_DMC1] = devm_clk_get(dev, "ppmudmc1");
+	if (IS_ERR(data->clk_ppmu[PPMU_DMC1])) {
+		dev_warn(dev, "Cannot get ppmudmc1 clock\n");
+	} else {
+		err = clk_prepare_enable(data->clk_ppmu[PPMU_DMC1]);
+		if (err) {
+			dev_err(dev, "Cannot enable ppmudmc0 clock\n");
+			return err;
+		}
+	}
+
 	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_floor(dev,
 					 &exynos4_devfreq_profile.initial_freq);
@@ -1001,6 +1025,10 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 static int exynos4_busfreq_remove(struct platform_device *pdev)
 {
 	struct busfreq_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < PPMU_END; i++)
+		clk_disable_unprepare(data->clk_ppmu[i]);
 
 	/* Unregister all of notifier chain */
 	unregister_pm_notifier(&data->pm_notifier);
-- 
1.7.9.5

