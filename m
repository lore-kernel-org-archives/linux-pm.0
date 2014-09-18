From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 08/33] thermal: exynos: remove needless emul_temp_shift
 abstraction
Date: Thu, 18 Sep 2014 17:27:25 +0200
Message-ID: <1411054070-25757-9-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->emul_temp_shift is used only in exynos_tmu_set_emulation()
and accessed only if TMU_SUPPORT_EMULATION flag is set.  This
flag is not set for Exynos4210 (reg->emul_temp_shift field is
not even assigned in exynos4210_tmu_registers and is assigned
to identical value for all other SoC types) so the abstraction
is not needed and can be removed.

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
 drivers/thermal/samsung/exynos_tmu_data.c | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 350a1f5..974c337 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -368,8 +368,8 @@ static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp)
 			val &= ~(EXYNOS_EMUL_TIME_MASK << reg->emul_time_shift);
 			val |= (EXYNOS_EMUL_TIME << reg->emul_time_shift);
 		}
-		val &= ~(EXYNOS_EMUL_DATA_MASK << reg->emul_temp_shift);
-		val |= (temp_to_code(data, temp) << reg->emul_temp_shift) |
+		val &= ~(EXYNOS_EMUL_DATA_MASK << EXYNOS_EMUL_DATA_SHIFT);
+		val |= (temp_to_code(data, temp) << EXYNOS_EMUL_DATA_SHIFT) |
 			EXYNOS_EMUL_ENABLE;
 	} else {
 		val &= ~EXYNOS_EMUL_ENABLE;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 8f5ffcb..649a654 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -96,7 +96,6 @@ enum soc_type {
  * @intclr_rise_mask: mask bits of all rising interrupt bits.
  * @intclr_fall_mask: mask bits of all rising interrupt bits.
  * @emul_con: TMU emulation controller register.
- * @emul_temp_shift: shift bits of emulation temperature.
  * @emul_time_shift: shift bits of emulation time.
  * @tmu_irqstatus: register to find which TMU generated interrupts.
  * @tmu_pmin: register to get/set the Pmin value.
@@ -127,7 +126,6 @@ struct exynos_tmu_registers {
 	u32	intclr_rise_mask;
 
 	u32	emul_con;
-	u32	emul_temp_shift;
 	u32	emul_time_shift;
 
 	u32	tmu_irqstatus;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index a37f490..3ae0376 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -99,7 +99,6 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
 	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
@@ -176,7 +175,6 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
 	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
@@ -265,7 +263,6 @@ static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.intclr_rise_mask = EXYNOS5260_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS5260_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS5260_EMUL_CON,
-	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
 	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
@@ -344,7 +341,6 @@ static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.intclr_rise_mask = EXYNOS_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS_EMUL_CON,
-	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
 	.emul_time_shift = EXYNOS_EMUL_TIME_SHIFT,
 };
 
@@ -432,7 +428,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.intclr_fall_mask = EXYNOS5440_TMU_FALL_INT_MASK,
 	.tmu_irqstatus = EXYNOS5440_TMU_IRQ_STATUS,
 	.emul_con = EXYNOS5440_TMU_S0_7_DEBUG,
-	.emul_temp_shift = EXYNOS_EMUL_DATA_SHIFT,
 	.tmu_pmin = EXYNOS5440_TMU_PMIN,
 };
 
-- 
1.8.2.3
