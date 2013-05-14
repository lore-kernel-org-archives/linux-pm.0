From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V4 23/30] thermal: exynos: Fix to set the second point correction value properly
Date: Tue, 14 May 2013 15:28:53 +0530
Message-ID: <1368525540-15034-24-git-send-email-amit.daniel@samsung.com>
References: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch sets the second point trimming value according to the platform
data if the register value is 0.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7ca9c4d..28804a5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -161,10 +161,15 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	data->temp_error2 = ((trim_info >> reg->triminfo_85_shift) &
 				EXYNOS_TMU_TEMP_MASK);
 
-	if ((pdata->min_efuse_value > data->temp_error1) ||
-			(data->temp_error1 > pdata->max_efuse_value) ||
-			(data->temp_error2 != 0))
-		data->temp_error1 = pdata->efuse_value;
+	if (!data->temp_error1 ||
+		(pdata->min_efuse_value > data->temp_error1) ||
+		(data->temp_error1 > pdata->max_efuse_value))
+		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
+
+	if (!data->temp_error2)
+		data->temp_error2 =
+			(pdata->efuse_value >> reg->triminfo_85_shift) &
+			EXYNOS_TMU_TEMP_MASK;
 
 	/* Count trigger levels to be enabled */
 	for (i = 0; i < MAX_THRESHOLD_LEVS; i++)
-- 
1.7.1
