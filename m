From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH] thermal:samsung: fix compilation warning
Date: Fri, 20 Dec 2013 17:42:07 +0530
Message-ID: <1387541527-4762-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30114 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724Ab3LTMLo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 07:11:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com

This patch fixes a compilation warning.

warning: passing argument 5 of 'thermal_zone_device_register' discards 'const'
qualifier from pointer target type [enabled by default]
include/linux/thermal.h:270:29: note: expected 'struct thermal_zone_device_ops *'
but argument is of type 'const struct thermal_zone_device_ops *'

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/thermal/samsung/exynos_thermal_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index c2301da..3f5ad25 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -280,7 +280,7 @@ static int exynos_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 /* Operation callback functions for thermal zone */
-static struct thermal_zone_device_ops const exynos_dev_ops = {
+static struct thermal_zone_device_ops exynos_dev_ops = {
 	.bind = exynos_bind,
 	.unbind = exynos_unbind,
 	.get_temp = exynos_get_temp,
-- 
1.7.10.4

