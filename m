From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 05/18] thermal: exynos: use sanitize_temp_error() in
 exynos7_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:20 +0200
Message-ID: <1524743493-28113-6-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Fix sanitize_temp_error() to handle Exynos7 SoCs and then use it in
exynos7_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3b41666..5a64879 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -286,7 +286,11 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
+	u16 tmu_temp_mask =
+		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
+						: EXYNOS_TMU_TEMP_MASK;
+
+	data->temp_error1 = trim_info & tmu_temp_mask;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
 				EXYNOS_TMU_TEMP_MASK);
 
@@ -592,12 +596,7 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 	unsigned int reg_off, bit_off;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-
-	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
-	if (!data->temp_error1 ||
-	    (data->min_efuse_value > data->temp_error1) ||
-	    (data->temp_error1 > data->max_efuse_value))
-		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
+	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
-- 
1.9.1
