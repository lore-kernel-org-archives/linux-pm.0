From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/33] thermal: exynos: replace tmu_pmin check by Exynos5440 one
Date: Thu, 18 Sep 2014 17:27:28 +0200
Message-ID: <1411054070-25757-12-git-send-email-b.zolnierkie@samsung.com>
References: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411054070-25757-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

reg->tmu_pmin is set to non-zero value only for Exynos5440
so replace check for non-zero value of reg->tmu_pmin by
explicitly checking for Exynos5440 SoC type.  Then remove no
longer needed reg->tmu_pmin register abstraction.

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
 drivers/thermal/samsung/exynos_tmu.h      | 3 ---
 drivers/thermal/samsung/exynos_tmu_data.c | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 85e74e1..f009a04 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -256,8 +256,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		}
 	}
 	/*Clear the PMIN in the common TMU register*/
-	if (reg->tmu_pmin && !data->id)
-		writel(0, data->base_second + reg->tmu_pmin);
+	if (data->soc == SOC_ARCH_EXYNOS5440 && !data->id)
+		writel(0, data->base_second + EXYNOS5440_TMU_PMIN);
 out:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5ab7482..7098e37 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -96,7 +96,6 @@ enum soc_type {
  * @intclr_rise_mask: mask bits of all rising interrupt bits.
  * @intclr_fall_mask: mask bits of all rising interrupt bits.
  * @emul_con: TMU emulation controller register.
- * @tmu_pmin: register to get/set the Pmin value.
  */
 struct exynos_tmu_registers {
 	u32	tmu_ctrl;
@@ -124,8 +123,6 @@ struct exynos_tmu_registers {
 	u32	intclr_rise_mask;
 
 	u32	emul_con;
-
-	u32	tmu_pmin;
 };
 
 /**
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 5811b99..23beb70 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -423,7 +423,6 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.intclr_rise_mask = EXYNOS5440_TMU_RISE_INT_MASK,
 	.intclr_fall_mask = EXYNOS5440_TMU_FALL_INT_MASK,
 	.emul_con = EXYNOS5440_TMU_S0_7_DEBUG,
-	.tmu_pmin = EXYNOS5440_TMU_PMIN,
 };
 
 #define EXYNOS5440_TMU_DATA \
-- 
1.8.2.3
