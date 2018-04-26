From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 17/18] thermal: exynos: remove unused defines for Exynos5433
Date: Thu, 26 Apr 2018 13:51:32 +0200
Message-ID: <1524743493-28113-18-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115241epcas1p4472048bd1647d9151718f573e6f1025a@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove unused defines for Exynos5433.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9639acf..ed02b40 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -96,11 +96,6 @@
 #define EXYNOS4412_MUX_ADDR_SHIFT          20
 
 /* Exynos5433 specific registers */
-#define EXYNOS5433_TMU_REG_CONTROL1		0x024
-#define EXYNOS5433_TMU_SAMPLING_INTERVAL	0x02c
-#define EXYNOS5433_TMU_COUNTER_VALUE0		0x030
-#define EXYNOS5433_TMU_COUNTER_VALUE1		0x034
-#define EXYNOS5433_TMU_REG_CURRENT_TEMP1	0x044
 #define EXYNOS5433_THD_TEMP_RISE3_0		0x050
 #define EXYNOS5433_THD_TEMP_RISE7_4		0x054
 #define EXYNOS5433_THD_TEMP_FALL3_0		0x060
-- 
1.9.1
