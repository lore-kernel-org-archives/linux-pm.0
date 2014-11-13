From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 31/33] thermal: exynos: remove SoC type ifdefs
Date: Thu, 13 Nov 2014 16:01:26 +0100
Message-ID: <1415890888-8881-32-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Maximum theoretical size saving (i.e. with only Exynos5410
SoC support enabled in kernel config so all SoC dependend
Exynos thermal driver code was dropped) is 4096 bytes so
there is no much sense in keeping these ifdefs (especially
given that they are useless once the driver gets updated to
use device tree).

While at it remove needless 'void *' casts.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 16 ++++++------
 drivers/thermal/samsung/exynos_tmu_data.c | 18 --------------
 drivers/thermal/samsung/exynos_tmu_data.h | 41 -------------------------------
 3 files changed, 8 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2fcb4cd..6cc6b6e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -593,35 +593,35 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
-		.data = (void *)EXYNOS3250_TMU_DRV_DATA,
+		.data = &exynos3250_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos4210-tmu",
-		.data = (void *)EXYNOS4210_TMU_DRV_DATA,
+		.data = &exynos4210_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos4412-tmu",
-		.data = (void *)EXYNOS4412_TMU_DRV_DATA,
+		.data = &exynos4412_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5250-tmu",
-		.data = (void *)EXYNOS5250_TMU_DRV_DATA,
+		.data = &exynos5250_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5260-tmu",
-		.data = (void *)EXYNOS5260_TMU_DRV_DATA,
+		.data = &exynos5260_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5420-tmu",
-		.data = (void *)EXYNOS5420_TMU_DRV_DATA,
+		.data = &exynos5420_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
-		.data = (void *)EXYNOS5420_TMU_DRV_DATA,
+		.data = &exynos5420_default_tmu_data,
 	},
 	{
 		.compatible = "samsung,exynos5440-tmu",
-		.data = (void *)EXYNOS5440_TMU_DRV_DATA,
+		.data = &exynos5440_default_tmu_data,
 	},
 	{},
 };
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 708c3e1..02a1c34 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -24,7 +24,6 @@
 #include "exynos_tmu.h"
 #include "exynos_tmu_data.h"
 
-#if defined(CONFIG_CPU_EXYNOS4210)
 struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 	.tmu_data = {
 		{
@@ -63,9 +62,7 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 	},
 	.tmu_count = 1,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS3250)
 #define EXYNOS3250_TMU_DATA \
 	.threshold_falling = 10, \
 	.trigger_levels[0] = 70, \
@@ -101,9 +98,7 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 		.temp_level = 95, \
 	}, \
 	.freq_tab_count = 2
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS3250)
 struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 	.tmu_data = {
 		{
@@ -113,9 +108,7 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 	},
 	.tmu_count = 1,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
 #define EXYNOS4412_TMU_DATA \
 	.threshold_falling = 10, \
 	.trigger_levels[0] = 70, \
@@ -151,9 +144,7 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 		.temp_level = 95, \
 	}, \
 	.freq_tab_count = 2
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS4412)
 struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
 	.tmu_data = {
 		{
@@ -163,9 +154,7 @@ struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
 	},
 	.tmu_count = 1,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS5250)
 struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 	.tmu_data = {
 		{
@@ -175,9 +164,7 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 	},
 	.tmu_count = 1,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS5260)
 #define __EXYNOS5260_TMU_DATA	\
 	.threshold_falling = 10, \
 	.trigger_levels[0] = 85, \
@@ -228,9 +215,7 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 	},
 	.tmu_count = 5,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS5420)
 #define __EXYNOS5420_TMU_DATA	\
 	.threshold_falling = 10, \
 	.trigger_levels[0] = 85, \
@@ -285,9 +270,7 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	},
 	.tmu_count = 5,
 };
-#endif
 
-#if defined(CONFIG_SOC_EXYNOS5440)
 #define EXYNOS5440_TMU_DATA \
 	.trigger_levels[0] = 100, \
 	.trigger_levels[4] = 105, \
@@ -316,4 +299,3 @@ struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	},
 	.tmu_count = 3,
 };
-#endif
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 2af312d..0bfbbf2 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -104,53 +104,12 @@
 #define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
 #define EXYNOS5440_EFUSE_SWAP_OFFSET		8
 
-#if defined(CONFIG_SOC_EXYNOS3250)
 extern struct exynos_tmu_init_data const exynos3250_default_tmu_data;
-#define EXYNOS3250_TMU_DRV_DATA (&exynos3250_default_tmu_data)
-#else
-#define EXYNOS3250_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_CPU_EXYNOS4210)
 extern struct exynos_tmu_init_data const exynos4210_default_tmu_data;
-#define EXYNOS4210_TMU_DRV_DATA (&exynos4210_default_tmu_data)
-#else
-#define EXYNOS4210_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4412)
 extern struct exynos_tmu_init_data const exynos4412_default_tmu_data;
-#define EXYNOS4412_TMU_DRV_DATA (&exynos4412_default_tmu_data)
-#else
-#define EXYNOS4412_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5250)
 extern struct exynos_tmu_init_data const exynos5250_default_tmu_data;
-#define EXYNOS5250_TMU_DRV_DATA (&exynos5250_default_tmu_data)
-#else
-#define EXYNOS5250_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5260)
 extern struct exynos_tmu_init_data const exynos5260_default_tmu_data;
-#define EXYNOS5260_TMU_DRV_DATA (&exynos5260_default_tmu_data)
-#else
-#define EXYNOS5260_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5420)
 extern struct exynos_tmu_init_data const exynos5420_default_tmu_data;
-#define EXYNOS5420_TMU_DRV_DATA (&exynos5420_default_tmu_data)
-#else
-#define EXYNOS5420_TMU_DRV_DATA (NULL)
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5440)
 extern struct exynos_tmu_init_data const exynos5440_default_tmu_data;
-#define EXYNOS5440_TMU_DRV_DATA (&exynos5440_default_tmu_data)
-#else
-#define EXYNOS5440_TMU_DRV_DATA (NULL)
-#endif
 
 #endif /*_EXYNOS_TMU_DATA_H*/
-- 
1.8.2.3
