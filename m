From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 2/3 v5] thermal: samsung: change base_common to more meaningful
 base_second
Date: Wed, 16 Oct 2013 08:22:06 +0530
Message-ID: <1381891926-30204-1-git-send-email-ch.naveen@samsung.com>
References: <1378268629-2886-2-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14270 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757666Ab3JPCuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 22:50:06 -0400
In-reply-to: <1378268629-2886-2-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, l.majewski@samsung.com, cpgs@samsung.com

On Exynos5440 and Exynos5420 there are registers common
across the TMU channels.

To support that, we introduced a ADDRESS_MULTIPLE flag in the
driver and the 2nd set of register base and size are provided
in the "reg" property of the node.

As per Amit's suggestion, this patch changes the base_common
to base_second and SHARED_MEMORY to ADDRESS_MULTIPLE.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Changes since v1:
 None
Changes since v2:
 Changed the flag name from SHARED_MEMORY to ADDRESS_MULTIPLE.
 https://lkml.org/lkml/2013/8/1/38
Changes since v3:
 None
Changes since v4:
 Corrected a compilation error, undeclared variable

 .../devicetree/bindings/thermal/exynos-thermal.txt       |    4 ++--
 drivers/thermal/samsung/exynos_tmu.c                     |   14 +++++++-------
 drivers/thermal/samsung/exynos_tmu.h                     |    4 ++--
 drivers/thermal/samsung/exynos_tmu_data.c                |    2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 284f530..116cca0 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -11,8 +11,8 @@
 - reg : Address range of the thermal registers. For soc's which has multiple
 	instances of TMU and some registers are shared across all TMU's like
 	interrupt related then 2 set of register has to supplied. First set
-	belongs	to each instance of TMU and second set belongs to common TMU
-	registers.
+	belongs	to each instance of TMU and second set belongs to second set
+	of common TMU registers.
 - interrupts : Should contain interrupt for thermal system
 - clocks : The main clock for TMU device
 - clock-names : Thermal system clock name
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b2202fa..ae80a87 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -41,7 +41,7 @@
  * @id: identifier of the one instance of the TMU controller.
  * @pdata: pointer to the tmu platform/configuration data
  * @base: base address of the single instance of the TMU controller.
- * @base_common: base address of the common registers of the TMU controller.
+ * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
  * @irq_work: pointer to the irq work structure.
@@ -56,7 +56,7 @@ struct exynos_tmu_data {
 	int id;
 	struct exynos_tmu_platform_data *pdata;
 	void __iomem *base;
-	void __iomem *base_common;
+	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
 	struct work_struct irq_work;
@@ -297,7 +297,7 @@ skip_calib_data:
 	}
 	/*Clear the PMIN in the common TMU register*/
 	if (reg->tmu_pmin && !data->id)
-		writel(0, data->base_common + reg->tmu_pmin);
+		writel(0, data->base_second + reg->tmu_pmin);
 out:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
@@ -454,7 +454,7 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	/* Find which sensor generated this interrupt */
 	if (reg->tmu_irqstatus) {
-		val_type = readl(data->base_common + reg->tmu_irqstatus);
+		val_type = readl(data->base_second + reg->tmu_irqstatus);
 		if (!((val_type >> data->id) & 0x1))
 			goto out;
 	}
@@ -579,7 +579,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
 	 */
-	if (!TMU_SUPPORTS(pdata, SHARED_MEMORY))
+	if (!TMU_SUPPORTS(pdata, ADDRESS_MULTIPLE))
 		return 0;
 
 	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {
@@ -587,9 +587,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->base_common = devm_ioremap(&pdev->dev, res.start,
+	data->base_second = devm_ioremap(&pdev->dev, res.start,
 					resource_size(&res));
-	if (!data->base_common) {
+	if (!data->base_second) {
 		dev_err(&pdev->dev, "Failed to ioremap memory\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5f4fe6c..d79264f 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -60,7 +60,7 @@ enum soc_type {
  *			state(active/idle) can be checked.
  * TMU_SUPPORT_EMUL_TIME - This features allows to set next temp emulation
  *			sample time.
- * TMU_SUPPORT_SHARED_MEMORY - This feature tells that the different TMU
+ * TMU_SUPPORT_ADDRESS_MULTIPLE - This feature tells that the different TMU
  *			sensors shares some common registers.
  * TMU_SUPPORT - macro to compare the above features with the supplied.
  */
@@ -70,7 +70,7 @@ enum soc_type {
 #define TMU_SUPPORT_FALLING_TRIP		BIT(3)
 #define TMU_SUPPORT_READY_STATUS		BIT(4)
 #define TMU_SUPPORT_EMUL_TIME			BIT(5)
-#define TMU_SUPPORT_SHARED_MEMORY		BIT(6)
+#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(6)
 
 #define TMU_SUPPORTS(a, b)	(a->features & TMU_SUPPORT_ ## b)
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 09a8a27..3d9ade5 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -257,7 +257,7 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.type = SOC_ARCH_EXYNOS5440, \
 	.registers = &exynos5440_tmu_registers, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_MULTI_INST | TMU_SUPPORT_SHARED_MEMORY),
+			TMU_SUPPORT_MULTI_INST | TMU_SUPPORT_ADDRESS_MULTIPLE),
 
 struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	.tmu_data = {
-- 
1.7.10.4

