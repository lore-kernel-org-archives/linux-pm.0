From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 21/33] thermal: exynos: add ->tmu_read method
Date: Thu, 13 Nov 2014 16:01:16 +0100
Message-ID: <1415890888-8881-22-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add ->tmu_read method to struct exynos_tmu_data and use it
in exynos_tmu_control().  Then add ->tmu_read implementations
for Exynos4210, Exynos4412+ and Exynos5440.  Finally remove
no longer needed reg->tmu_cur_temp abstractions.

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      | 45 +++++++++++++++++++------------
 drivers/thermal/samsung/exynos_tmu.h      |  2 --
 drivers/thermal/samsung/exynos_tmu_data.c |  6 -----
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 938e8e63..b209593 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -54,6 +54,7 @@
  * @reg_conf: pointer to structure to register with core thermal.
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
+ * @tmu_read: SoC specific TMU temperature read method
  */
 struct exynos_tmu_data {
 	int id;
@@ -70,6 +71,7 @@ struct exynos_tmu_data {
 	struct thermal_sensor_conf *reg_conf;
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
+	int (*tmu_read)(struct exynos_tmu_data *data);
 };
 
 /*
@@ -422,29 +424,17 @@ static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
 
 static int exynos_tmu_read(struct exynos_tmu_data *data)
 {
-	struct exynos_tmu_platform_data *pdata = data->pdata;
-	const struct exynos_tmu_registers *reg = pdata->registers;
-	u8 temp_code;
-	int temp;
+	int ret;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-
-	temp_code = readb(data->base + reg->tmu_cur_temp);
-
-	if (data->soc == SOC_ARCH_EXYNOS4210)
-		/* temp_code should range between 75 and 175 */
-		if (temp_code < 75 || temp_code > 175) {
-			temp = -ENODATA;
-			goto out;
-		}
-
-	temp = code_to_temp(data, temp_code);
-out:
+	ret = data->tmu_read(data);
+	if (ret >= 0)
+		ret = code_to_temp(data, ret);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return temp;
+	return ret;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
@@ -494,6 +484,24 @@ static int exynos_tmu_set_emulation(void *drv_data,	unsigned long temp)
 	{ return -EINVAL; }
 #endif/*CONFIG_THERMAL_EMULATION*/
 
+static int exynos4210_tmu_read(struct exynos_tmu_data *data)
+{
+	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
+
+	/* "temp_code" should range between 75 and 175 */
+	return (ret < 75 || ret > 175) ? -ENODATA : ret;
+}
+
+static int exynos4412_tmu_read(struct exynos_tmu_data *data)
+{
+	return readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
+}
+
+static int exynos5440_tmu_read(struct exynos_tmu_data *data)
+{
+	return readb(data->base + EXYNOS5440_TMU_S0_7_TEMP);
+}
+
 static void exynos_tmu_work(struct work_struct *work)
 {
 	struct exynos_tmu_data *data = container_of(work,
@@ -718,6 +726,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS4210:
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos4210_tmu_read;
 		break;
 	case SOC_ARCH_EXYNOS3250:
 	case SOC_ARCH_EXYNOS4412:
@@ -727,10 +736,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
 		data->tmu_initialize = exynos4412_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos4412_tmu_read;
 		break;
 	case SOC_ARCH_EXYNOS5440:
 		data->tmu_initialize = exynos5440_tmu_initialize;
 		data->tmu_control = exynos5440_tmu_control;
+		data->tmu_read = exynos5440_tmu_read;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 7496b54..9460e6e 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -70,13 +70,11 @@ enum soc_type {
 /**
  * struct exynos_tmu_register - register descriptors to access registers.
  * The register validity may vary slightly across different exynos SOC's.
- * @tmu_cur_temp: register containing the current temperature of the TMU.
  * @tmu_intstat: Register containing the interrupt status values.
  * @tmu_intclear: Register for clearing the raised interrupt status.
  * @emul_con: TMU emulation controller register.
  */
 struct exynos_tmu_registers {
-	u32	tmu_cur_temp;
 	u32	tmu_intstat;
 	u32	tmu_intclear;
 	u32	emul_con;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 2bfd469..769b89d 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -26,7 +26,6 @@
 
 #if defined(CONFIG_CPU_EXYNOS4210)
 static const struct exynos_tmu_registers exynos4210_tmu_registers = {
-	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.tmu_intstat = EXYNOS_TMU_REG_INTSTAT,
 	.tmu_intclear = EXYNOS_TMU_REG_INTCLEAR,
 };
@@ -74,7 +73,6 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS3250)
 static const struct exynos_tmu_registers exynos3250_tmu_registers = {
-	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.tmu_intstat = EXYNOS_TMU_REG_INTSTAT,
 	.tmu_intclear = EXYNOS_TMU_REG_INTCLEAR,
 	.emul_con = EXYNOS_EMUL_CON,
@@ -135,7 +133,6 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
 static const struct exynos_tmu_registers exynos4412_tmu_registers = {
-	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.tmu_intstat = EXYNOS_TMU_REG_INTSTAT,
 	.tmu_intclear = EXYNOS_TMU_REG_INTCLEAR,
 	.emul_con = EXYNOS_EMUL_CON,
@@ -208,7 +205,6 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5260)
 static const struct exynos_tmu_registers exynos5260_tmu_registers = {
-	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT,
 	.tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR,
 	.emul_con = EXYNOS5260_EMUL_CON,
@@ -271,7 +267,6 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
-	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
 	.tmu_intstat = EXYNOS_TMU_REG_INTSTAT,
 	.tmu_intclear = EXYNOS_TMU_REG_INTCLEAR,
 	.emul_con = EXYNOS_EMUL_CON,
@@ -340,7 +335,6 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 
 #if defined(CONFIG_SOC_EXYNOS5440)
 static const struct exynos_tmu_registers exynos5440_tmu_registers = {
-	.tmu_cur_temp = EXYNOS5440_TMU_S0_7_TEMP,
 	.tmu_intstat = EXYNOS5440_TMU_S0_7_IRQ,
 	.tmu_intclear = EXYNOS5440_TMU_S0_7_IRQ,
 	.emul_con = EXYNOS5440_TMU_S0_7_DEBUG,
-- 
1.8.2.3
