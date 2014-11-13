From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 19/33] thermal: exynos: add get_con_reg() helper
Date: Thu, 13 Nov 2014 16:01:14 +0100
Message-ID: <1415890888-8881-20-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Factor out code for preparing TMU_CONTROL register value from
exynos_tmu_control() into get_con_reg().

This is a preparation for introducing per-SoC type tmu_control
method.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 736ef78..f65e6d8 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -197,17 +197,9 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	return ret;
 }
 
-static void exynos_tmu_control(struct platform_device *pdev, bool on)
+static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 {
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct exynos_tmu_platform_data *pdata = data->pdata;
-	const struct exynos_tmu_registers *reg = pdata->registers;
-	unsigned int con, interrupt_en;
-
-	mutex_lock(&data->lock);
-	clk_enable(data->clk);
-
-	con = readl(data->base + reg->tmu_ctrl);
 
 	if (pdata->test_mux)
 		con |= (pdata->test_mux << EXYNOS4412_MUX_ADDR_SHIFT);
@@ -223,6 +215,21 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 		con |= (pdata->noise_cancel_mode << EXYNOS_TMU_TRIP_MODE_SHIFT);
 	}
 
+	return con;
+}
+
+static void exynos_tmu_control(struct platform_device *pdev, bool on)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct exynos_tmu_platform_data *pdata = data->pdata;
+	const struct exynos_tmu_registers *reg = pdata->registers;
+	unsigned int con, interrupt_en;
+
+	mutex_lock(&data->lock);
+	clk_enable(data->clk);
+
+	con = get_con_reg(data, readl(data->base + reg->tmu_ctrl));
+
 	if (on) {
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		interrupt_en =
-- 
1.8.2.3
