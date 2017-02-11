From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: exynos: Remove parsing unused samsung,tmu_cal_mode property
Date: Sat, 11 Feb 2017 22:12:00 +0200
Message-ID: <20170211201200.27616-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdBKUMM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Feb 2017 15:12:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The property samsung,tmu_cal_mode is not used and not used.  We can
safely remove it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 -
 drivers/thermal/samsung/exynos_tmu.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ad1186dd6132..7b8ef09d2b3c 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1168,7 +1168,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->default_temp_offset = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
-	of_property_read_u32(np, "samsung,tmu_cal_mode", &pdata->cal_mode);
 
 	of_node_put(np);
 	return 0;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 440c7140b660..5149c2a3030c 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -70,7 +70,6 @@ struct exynos_tmu_platform_data {
 
 	enum soc_type type;
 	u32 cal_type;
-	u32 cal_mode;
 };
 
 #endif /* _EXYNOS_TMU_H */
-- 
2.9.3

