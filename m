From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/33] thermal: exynos: remove needless emul_time_shift
 abstraction
Date: Thu, 18 Sep 2014 17:27:26 +0200
Message-ID: <1411054070-25757-10-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->emul_time_shift is used only in exynos_tmu_set_emulation()
and accessed only if TMU_SUPPORT_EMUL_TIME flag is set.  This
flag is not set for Exynos4210 and Exynos5440 (reg->emul_time_shift
field is not even assigned in exynos[4210,5440]_tmu_registers
and is assigned to identical value for all other SoC types) so
the abstraction is not needed and can be removed.

There should be no functional changes caused by this patch.

Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 4 ++--
 drivers/thermal/samsung/exynos_tmu.h      | 2 --
 drivers/thermal/samsung/exynos_tmu_data.c | 4 ----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 974c337..a4ed576 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -365,8 +365,8 @@ static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp)
 		temp /= MCELSIUS;
 
 		if (TMU_SUPPORTS(pdata, EMUL_TIME)) {
-			val &= ~(EXYNOS_EMUL_TIME_MASK << reg->emul_time_shift);
-			val |= (EXYNOS_EMUL_TIME << reg->emul_time_shift);
+			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
+			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
 		}
 		val &= ~(EXYNOS_EMUL_DATA_MASK << EXYNOS_EMUL_DATA_SHIFT);
 		val |= (temp_to_code(data, temp) << EXYNOS_EMUL_DATA_SHIFT) |
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 649a654..6567293 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -96,7 +96,6 @@ enum soc_type {
  * @intclr_rise_mask: mask bits of all rising interrupt bits.
  * @intclr_fall_mask: mask bits of all rising interrupt bits.
  * @emul_con: TMU emulation controller register.
- * @emul_time_shift: shift bits of emulation time.
  * @tmu_irqstatus: register to find which TMU generated interrupts.
  * @tmu_pmin: register to get/set the Pmin value.
  */
@@ -126,7 +125,6 @@ struct exynos_tmu_registers {
 	u32	intclr_rise_mask;
 
 	u32	emul_con;
-	u32	emul_time_shift;
 
 	u32	tmu_irqstatus;
 	u32	tmu_pmin;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 3ae0376..b9a3778 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -99,7 +99,6 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
 #define EXYNOS3250_TMU_DATA \
@@ -175,7 +174,6 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
 #define EXYNOS4412_TMU_DATA \
@@ -263,7 +261,6 @@ static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.intclr_rise_mask = EXYNOS5260_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS5260_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS5260_EMUL_CON,
-	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
 #define __EXYNOS5260_TMU_DATA	\
@@ -341,7 +338,6 @@ static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
 #define __EXYNOS5420_TMU_DATA	\
-- 
1.8.2.3
