From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 14/33] thermal: exynos: remove TMU_SUPPORT_READY_STATUS flag
Date: Thu, 18 Sep 2014 17:27:31 +0200
Message-ID: <1411054070-25757-15-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace TMU_SUPPORT_READY_STATUS flag check in
exynos_tmu_initialize() by an explicit check for a SoC type
(all SoC types except Exynos5440 have TMU_SUPPORT_READY_STATUS
flag set in their struct exynos_tmu_init_data instances).

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
 drivers/thermal/samsung/exynos_tmu.c      |  2 +-
 drivers/thermal/samsung/exynos_tmu.h      |  7 ++-----
 drivers/thermal/samsung/exynos_tmu_data.c | 14 +++++---------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 641a77a..d9fa49a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -136,7 +136,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
 
-	if (TMU_SUPPORTS(pdata, READY_STATUS)) {
+	if (data->soc != SOC_ARCH_EXYNOS5440) {
 		status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 		if (!status) {
 			ret = -EBUSY;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 3430852..400f10d 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -54,8 +54,6 @@ enum soc_type {
  *			be reloaded.
  * TMU_SUPPORT_FALLING_TRIP - This features shows that interrupt can
  *			be registered for falling trips also.
- * TMU_SUPPORT_READY_STATUS - This feature tells that the TMU current
- *			state(active/idle) can be checked.
  * TMU_SUPPORT_EMUL_TIME - This features allows to set next temp emulation
  *			sample time.
  * TMU_SUPPORT_ADDRESS_MULTIPLE - This feature tells that the different TMU
@@ -66,9 +64,8 @@ enum soc_type {
 #define TMU_SUPPORT_MULTI_INST			BIT(1)
 #define TMU_SUPPORT_TRIM_RELOAD			BIT(2)
 #define TMU_SUPPORT_FALLING_TRIP		BIT(3)
-#define TMU_SUPPORT_READY_STATUS		BIT(4)
-#define TMU_SUPPORT_EMUL_TIME			BIT(5)
-#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(6)
+#define TMU_SUPPORT_EMUL_TIME			BIT(4)
+#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(5)
 
 #define TMU_SUPPORTS(a, b)	(a->features & TMU_SUPPORT_ ## b)
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index a63d945..af886e3 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -74,7 +74,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 		.freq_tab_count = 2,
 		.type = SOC_ARCH_EXYNOS4210,
 		.registers = &exynos4210_tmu_registers,
-		.features = TMU_SUPPORT_READY_STATUS,
 		},
 	},
 	.tmu_count = 1,
@@ -138,8 +137,7 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.freq_tab_count = 2, \
 	.registers = &exynos3250_tmu_registers, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
-			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
-			TMU_SUPPORT_EMUL_TIME)
+			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_EMUL_TIME)
 #endif
 
 #if defined(CONFIG_SOC_EXYNOS3250)
@@ -213,8 +211,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.freq_tab_count = 2, \
 	.registers = &exynos4412_tmu_registers, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
-			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
-			TMU_SUPPORT_EMUL_TIME)
+			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_EMUL_TIME)
 #endif
 
 #if defined(CONFIG_SOC_EXYNOS4412)
@@ -304,7 +301,7 @@ static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	__EXYNOS5260_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5260, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME)
+			TMU_SUPPORT_EMUL_TIME)
 
 struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 	.tmu_data = {
@@ -381,14 +378,13 @@ static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5250, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME)
+			TMU_SUPPORT_EMUL_TIME)
 
 #define EXYNOS5420_TMU_DATA_SHARED \
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420_TRIMINFO, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_READY_STATUS | TMU_SUPPORT_EMUL_TIME | \
-			TMU_SUPPORT_ADDRESS_MULTIPLE)
+			TMU_SUPPORT_EMUL_TIME | TMU_SUPPORT_ADDRESS_MULTIPLE)
 
 struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	.tmu_data = {
-- 
1.8.2.3
