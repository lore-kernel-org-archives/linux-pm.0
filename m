From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 2/6] thermal:exynos4: TMU Common clock framework support for
 TMU (Thermal Monitoring Unit)
Date: Fri, 19 Apr 2013 18:38:09 +0200
Message-ID: <1366389493-8239-3-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch modifies exynos_thermal.c file to use clk_disable_unprepare()
and clk_prepare_enable() instead of clk_{enable|disable}.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/exynos_thermal.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 46568c0..ba6094c 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -584,7 +584,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	int ret = 0, threshold_code, i, trigger_levs = 0;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	clk_prepare_enable(data->clk);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -655,7 +655,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 				data->base + EXYNOS_TMU_REG_INTCLEAR);
 	}
 out:
-	clk_disable(data->clk);
+	clk_disable_unprepare(data->clk);
 	mutex_unlock(&data->lock);
 
 	return ret;
@@ -668,7 +668,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	unsigned int con, interrupt_en;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	clk_prepare_enable(data->clk);
 
 	con = pdata->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT |
 		pdata->gain << EXYNOS_TMU_GAIN_SHIFT;
@@ -693,7 +693,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 
-	clk_disable(data->clk);
+	clk_disable_unprepare(data->clk);
 	mutex_unlock(&data->lock);
 }
 
@@ -703,12 +703,12 @@ static int exynos_tmu_read(struct exynos_tmu_data *data)
 	int temp;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	clk_prepare_enable(data->clk);
 
 	temp_code = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
 	temp = code_to_temp(data, temp_code);
 
-	clk_disable(data->clk);
+	clk_disable_unprepare(data->clk);
 	mutex_unlock(&data->lock);
 
 	return temp;
@@ -721,7 +721,7 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	exynos_report_trigger();
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	clk_prepare_enable(data->clk);
 	if (data->soc == SOC_ARCH_EXYNOS)
 		writel(EXYNOS_TMU_CLEAR_RISE_INT |
 				EXYNOS_TMU_CLEAR_FALL_INT,
@@ -729,7 +729,7 @@ static void exynos_tmu_work(struct work_struct *work)
 	else
 		writel(EXYNOS4210_TMU_INTCLEAR_VAL,
 				data->base + EXYNOS_TMU_REG_INTCLEAR);
-	clk_disable(data->clk);
+	clk_disable_unprepare(data->clk);
 	mutex_unlock(&data->lock);
 
 	enable_irq(data->irq);
@@ -985,7 +985,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->clk = clk_get(NULL, "tmu_apbif");
+	data->clk = clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		return  PTR_ERR(data->clk);
-- 
1.7.10.4
