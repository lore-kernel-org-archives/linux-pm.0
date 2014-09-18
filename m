From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 16/33] thermal: exynos: add sanitize_temp_error() helper
Date: Thu, 18 Sep 2014 17:27:33 +0200
Message-ID: <1411054070-25757-17-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Factor out code for initializing data->temp_error[1,2] values
from exynos_tmu_initialize() into sanitize_temp_error().

This is a preparation for introducing per-SoC type tmu_initialize
method.

There should be no functional changes caused by this patch.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4903a6e..a32ca04 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -122,6 +122,25 @@ static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
 	return temp;
 }
 
+static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
+{
+	struct exynos_tmu_platform_data *pdata = data->pdata;
+
+	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
+	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
+				EXYNOS_TMU_TEMP_MASK);
+
+	if (!data->temp_error1 ||
+		(pdata->min_efuse_value > data->temp_error1) ||
+		(data->temp_error1 > pdata->max_efuse_value))
+		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
+
+	if (!data->temp_error2)
+		data->temp_error2 =
+			(pdata->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
+			EXYNOS_TMU_TEMP_MASK;
+}
+
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -183,19 +202,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		else
 			trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	}
-	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
-	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				EXYNOS_TMU_TEMP_MASK);
-
-	if (!data->temp_error1 ||
-		(pdata->min_efuse_value > data->temp_error1) ||
-		(data->temp_error1 > pdata->max_efuse_value))
-		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
-
-	if (!data->temp_error2)
-		data->temp_error2 =
-			(pdata->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			EXYNOS_TMU_TEMP_MASK;
+	sanitize_temp_error(data, trim_info);
 
 	rising_threshold = readl(data->base + reg->threshold_th0);
 
-- 
1.8.2.3
