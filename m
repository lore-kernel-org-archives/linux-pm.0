From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 22/33] thermal: exynos: add get_emul_con_reg() helper
Date: Thu, 18 Sep 2014 17:27:39 +0200
Message-ID: <1411054070-25757-23-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Factor out code for preparing EMUL_CON register value from
exynos_tmu_set_emulation() into get_emul_con_reg().

This is a preparation for introducing per-SoC type
tmu_set_emulation method.

There should be no functional changes caused by this patch.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 38 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a35f045..59708b6 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -436,6 +436,28 @@ static int exynos_tmu_read(struct exynos_tmu_data *data)
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
+static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
+			    unsigned long temp)
+{
+	struct exynos_tmu_platform_data *pdata = data->pdata;
+
+	if (temp) {
+		temp /= MCELSIUS;
+
+		if (TMU_SUPPORTS(pdata, EMUL_TIME)) {
+			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
+			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
+		}
+		val &= ~(EXYNOS_EMUL_DATA_MASK << EXYNOS_EMUL_DATA_SHIFT);
+		val |= (temp_to_code(data, temp) << EXYNOS_EMUL_DATA_SHIFT) |
+			EXYNOS_EMUL_ENABLE;
+	} else {
+		val &= ~EXYNOS_EMUL_ENABLE;
+	}
+
+	return val;
+}
+
 static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp)
 {
 	struct exynos_tmu_data *data = drv_data;
@@ -454,21 +476,7 @@ static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp)
 	clk_enable(data->clk);
 
 	val = readl(data->base + reg->emul_con);
-
-	if (temp) {
-		temp /= MCELSIUS;
-
-		if (TMU_SUPPORTS(pdata, EMUL_TIME)) {
-			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
-			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		}
-		val &= ~(EXYNOS_EMUL_DATA_MASK << EXYNOS_EMUL_DATA_SHIFT);
-		val |= (temp_to_code(data, temp) << EXYNOS_EMUL_DATA_SHIFT) |
-			EXYNOS_EMUL_ENABLE;
-	} else {
-		val &= ~EXYNOS_EMUL_ENABLE;
-	}
-
+	val = get_emul_con_reg(data, val, temp);
 	writel(val, data->base + reg->emul_con);
 
 	clk_disable(data->clk);
-- 
1.8.2.3
