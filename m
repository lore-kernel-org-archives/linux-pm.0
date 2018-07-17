From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 2/5] thermal: exynos: cleanup of clk err check for exynos_tmu_work
Date: Tue, 17 Jul 2018 10:12:19 +0000
Message-ID: <1531822342-4293-2-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-pm@vger.kernel.org

cleanup err check in exynos_tmu_work as clk internal
framework will perform if clk is enable/disable
so drop the double check of IS_ERR and other such references.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0164c9e..2dbde97 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 out:
 	return ret;
 }
@@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
-
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
+	clk_enable(data->clk_sec);
 
 	/* TODO: take action based on particular interrupt */
 	data->tmu_clear_irqs(data);
 
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	enable_irq(data->irq);
@@ -1134,8 +1129,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 err_clk:
 	clk_disable_unprepare(data->clk);
 err_sensor:
@@ -1155,8 +1149,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_disable_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.7.4
