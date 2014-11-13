From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 30/33] thermal: exynos: remove test_mux pdata field
Date: Thu, 13 Nov 2014 16:01:25 +0100
Message-ID: <1415890888-8881-31-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace pdata->test_mux check in get_con_reg() by explicitly
checking for SoC type.

Also since the used pdata->test_mux value is always identical
use it directly and remove pdata->test_mux completely.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 5 +++--
 drivers/thermal/samsung/exynos_tmu.h      | 2 --
 drivers/thermal/samsung/exynos_tmu_data.c | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 65eeecc..2fcb4cd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -193,8 +193,9 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 
-	if (pdata->test_mux)
-		con |= (pdata->test_mux << EXYNOS4412_MUX_ADDR_SHIFT);
+	if (data->soc == SOC_ARCH_EXYNOS4412 ||
+	    data->soc == SOC_ARCH_EXYNOS3250)
+		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
 
 	con &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
 	con |= pdata->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 2eb4cb9..8de0f82 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -89,7 +89,6 @@ enum soc_type {
  * @first_point_trim: temp value of the first point trimming
  * @second_point_trim: temp value of the second point trimming
  * @default_temp_offset: default temperature offset in case of no trimming
- * @test_mux; information if SoC supports test MUX
  * @cal_type: calibration type for temperature
  * @freq_clip_table: Table representing frequency reduction percentage.
  * @freq_tab_count: Count of the above table as frequency reduction may
@@ -115,7 +114,6 @@ struct exynos_tmu_platform_data {
 	u8 first_point_trim;
 	u8 second_point_trim;
 	u8 default_temp_offset;
-	u8 test_mux;
 
 	enum calibration_type cal_type;
 	enum soc_type type;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index d90b050..708c3e1 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -109,7 +109,6 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 		{
 			EXYNOS3250_TMU_DATA,
 			.type = SOC_ARCH_EXYNOS3250,
-			.test_mux = EXYNOS4412_MUX_ADDR_VALUE,
 		},
 	},
 	.tmu_count = 1,
@@ -160,7 +159,6 @@ struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
 		{
 			EXYNOS4412_TMU_DATA,
 			.type = SOC_ARCH_EXYNOS4412,
-			.test_mux = EXYNOS4412_MUX_ADDR_VALUE,
 		},
 	},
 	.tmu_count = 1,
-- 
1.8.2.3
