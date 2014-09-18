From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 10/33] thermal: exynos: replace tmu_irqstatus check by
 Exynos5440 one
Date: Thu, 18 Sep 2014 17:27:27 +0200
Message-ID: <1411054070-25757-11-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->tmu_irqstatus is set to non-zero value only for Exynos5440
so replace check for non-zero value of reg->tmu_irqstatus by
explicitly checking for Exynos5440 SoC type.  Then remove no
longer needed reg->tmu_irqstatus register abstraction.

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
 drivers/thermal/samsung/exynos_tmu_data.c | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a4ed576..85e74e1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -399,8 +399,8 @@ static void exynos_tmu_work(struct work_struct *work)
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
 	/* Find which sensor generated this interrupt */
-	if (reg->tmu_irqstatus) {
-		val_type = readl(data->base_second + reg->tmu_irqstatus);
+	if (data->soc == SOC_ARCH_EXYNOS5440) {
+		val_type = readl(data->base_second + EXYNOS5440_TMU_IRQ_STATUS);
 		if (!((val_type >> data->id) & 0x1))
 			goto out;
 	}
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 6567293..5ab7482 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -96,7 +96,6 @@ enum soc_type {
  * @intclr_rise_mask: mask bits of all rising interrupt bits.
  * @intclr_fall_mask: mask bits of all rising interrupt bits.
  * @emul_con: TMU emulation controller register.
- * @tmu_irqstatus: register to find which TMU generated interrupts.
  * @tmu_pmin: register to get/set the Pmin value.
  */
 struct exynos_tmu_registers {
@@ -126,7 +125,6 @@ struct exynos_tmu_registers {
 
 	u32	emul_con;
 
-	u32	tmu_irqstatus;
 	u32	tmu_pmin;
 };
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index b9a3778..5811b99 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -422,7 +422,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.intclr_rise_shift = EXYNOS5440_TMU_RISE_INT_SHIFT,
 	.intclr_rise_mask = EXYNOS5440_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS5440_TMU_FALL_INT_MASK,
-	.tmu_irqstatus = EXYNOS5440_TMU_IRQ_STATUS,
 	.emul_con = EXYNOS5440_TMU_S0_7_DEBUG,
 	.tmu_pmin = EXYNOS5440_TMU_PMIN,
 };
-- 
1.8.2.3
