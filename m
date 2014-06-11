From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/3] devfreq: exynos4_bus: Access memory mapped I/O region via
 dynamic allocation.
Date: Wed, 11 Jun 2014 10:17:55 +0900
Message-ID: <1402449476-6782-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61587 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbaFKBSO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 21:18:14 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z00HRLCY0V4C0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 11 Jun 2014 10:18:00 +0900 (KST)
In-reply-to: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Instead of using statically allocated MMIO(Memory Mapped IO) region,
it makes driver to use ioremap() to allocate the SFR region dynamically.

This patch also includes minor code clean.

WARNING: line over 80 characters
 907: FILE: drivers/devfreq/exynos/exynos4_bus.c:907:

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index cadad03..7c5e940 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -25,8 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/clk.h>
-
-#include <mach/map.h>
+#include <linux/io.h>
 
 #include "exynos_ppmu.h"
 #include "exynos4_bus.h"
@@ -902,9 +901,9 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	struct busfreq_ppmu_data *ppmu_data;
 	struct dev_pm_opp *opp;
 	struct device *dev = &pdev->dev;
-	int err = 0;
+	int i, err = 0;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct busfreq_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct busfreq_data), GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(dev, "Cannot allocate memory.\n");
 		return -ENOMEM;
@@ -921,8 +920,20 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	}
 
 	data->type = pdev->id_entry->driver_data;
-	ppmu_data->ppmu[PPMU_DMC0].hw_base = S5P_VA_DMC0;
-	ppmu_data->ppmu[PPMU_DMC1].hw_base = S5P_VA_DMC1;
+
+	/*  Allocate MMIO region for PPMU SFRs */
+	for (i = 0; i < PPMU_END; i++) {
+		struct resource *res;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			dev_err(dev, "No mem resource for ppmu[%d]\n", i);
+			return -ENOENT;
+		}
+
+		ppmu_data->ppmu[i].hw_base = devm_ioremap_resource(dev, res);
+	}
+
 	data->pm_notifier.notifier_call = exynos4_busfreq_pm_notifier_event;
 	data->dev = dev;
 	mutex_init(&data->lock);
-- 
1.7.9.5

