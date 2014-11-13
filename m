From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 29/33] thermal: exynos: remove TMU_SUPPORT_MULTI_INST flag
Date: Thu, 13 Nov 2014 16:01:24 +0100
Message-ID: <1415890888-8881-30-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove unused TMU_SUPPORT_MULTI_INST flag, no longer
needed TMU_SUPPORTS() macro and features field from
struct exynos_tmu_platform_data.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.h      | 13 -------------
 drivers/thermal/samsung/exynos_tmu_data.c |  3 +--
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 54f018d..2eb4cb9 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -46,16 +46,6 @@ enum soc_type {
 };
 
 /**
- * EXYNOS TMU supported features.
- * TMU_SUPPORT_MULTI_INST - This features denotes that the soc
- *			has many instances of TMU.
- * TMU_SUPPORT - macro to compare the above features with the supplied.
- */
-#define TMU_SUPPORT_MULTI_INST			BIT(0)
-
-#define TMU_SUPPORTS(a, b)	(a->features & TMU_SUPPORT_ ## b)
-
-/**
  * struct exynos_tmu_platform_data
  * @threshold: basic temperature for generating interrupt
  *	       25 <= threshold <= 125 [unit: degree Celsius]
@@ -104,8 +94,6 @@ enum soc_type {
  * @freq_clip_table: Table representing frequency reduction percentage.
  * @freq_tab_count: Count of the above table as frequency reduction may
  *	applicable to only some of the trigger levels.
- * @features: a bitfield value indicating the features supported in SOC like
- *	emulation, multi instance etc
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
@@ -133,7 +121,6 @@ struct exynos_tmu_platform_data {
 	enum soc_type type;
 	struct freq_clip_table freq_tab[4];
 	unsigned int freq_tab_count;
-	unsigned int features;
 };
 
 /**
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 13ac00b..d90b050 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -308,8 +308,7 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	.first_point_trim = 25, \
 	.second_point_trim = 70, \
 	.default_temp_offset = 25, \
-	.type = SOC_ARCH_EXYNOS5440, \
-	.features = TMU_SUPPORT_MULTI_INST,
+	.type = SOC_ARCH_EXYNOS5440
 
 struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	.tmu_data = {
-- 
1.8.2.3
