From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/3] thermal: exynos: Fix wrong control of power down detection
 mode for Exynos7
Date: Mon, 16 Feb 2015 23:20:13 +0900
Message-ID: <1424096414-4327-3-git-send-email-cw00.choi@samsung.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, kyungmin.park@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the wrong control of PD_DET_EN (power down detection mode)
for Exynos7 because exynos7_tmu_control() always enables the power down detection
mode regardless 'on' parameter.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b8846f1..b199fff 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 
 	if (on) {
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
 		interrupt_en =
 			(of_thermal_is_trip_valid(tz, 7)
 			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
@@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 	} else {
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
 		interrupt_en = 0; /* Disable all interrupts */
 	}
-	con |= 1 << EXYNOS7_PD_DET_EN_SHIFT;
 
 	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-- 
1.8.5.5
