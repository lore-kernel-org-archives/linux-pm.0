From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 01/10] PM / devfreq: exynos: use to_platform_device()
Date: Sun, 27 Dec 2015 21:15:39 +0800
Message-ID: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-135.163.com ([123.125.50.135]:42060 "EHLO m50-135.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbbL0NRj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 27 Dec 2015 08:17:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 3 +--
 drivers/devfreq/exynos/exynos5_bus.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index da95092..e3124bf 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -566,8 +566,7 @@ static int exynos4_bus_target(struct device *dev, unsigned long *_freq,
 			      u32 flags)
 {
 	int err = 0;
-	struct platform_device *pdev = container_of(dev, struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct busfreq_data *data = platform_get_drvdata(pdev);
 	struct dev_pm_opp *opp;
 	unsigned long freq;
diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 297ea30..81da78e 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -85,8 +85,7 @@ static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
 			      u32 flags)
 {
 	int err = 0;
-	struct platform_device *pdev = container_of(dev, struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct busfreq_data_int *data = platform_get_drvdata(pdev);
 	struct dev_pm_opp *opp;
 	unsigned long old_freq, freq;
@@ -145,8 +144,7 @@ out:
 static int exynos5_int_get_dev_status(struct device *dev,
 				      struct devfreq_dev_status *stat)
 {
-	struct platform_device *pdev = container_of(dev, struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct busfreq_data_int *data = platform_get_drvdata(pdev);
 	struct busfreq_ppmu_data *ppmu_data = &data->ppmu_data;
 	int busier_dmc;
@@ -370,8 +368,7 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int exynos5_busfreq_int_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev, struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct busfreq_data_int *data = platform_get_drvdata(pdev);
 	struct busfreq_ppmu_data *ppmu_data = &data->ppmu_data;
 
-- 
2.5.0


