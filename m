From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 2/3 v4] thermal: samsung: change base_common to more meaningful
 base_second
Date: Wed, 09 Oct 2013 17:38:28 +0530
Message-ID: <1381320509-23967-2-git-send-email-ch.naveen@samsung.com>
References: <1378268629-2886-3-git-send-email-ch.naveen@samsung.com>
 <1381320509-23967-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1381320509-23967-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

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

 .../devicetree/bindings/thermal/exynos-thermal.txt         |    4 ++--
 drivers/thermal/samsung/exynos_tmu.c                       |   12 ++++++------
 drivers/thermal/samsung/exynos_tmu.h                       |    4 ++--
 drivers/thermal/samsung/exynos_tmu_data.c                  |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

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
index af69209..40c4243 100644
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
@@ -451,7 +451,7 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	/* Find which sensor generated this interrupt */
 	if (reg->tmu_irqstatus) {
-		val_type = readl(data->base_common + reg->tmu_irqstatus);
+		val_type = readl(data->base_second + reg->tmu_irqstatus);
 		if (!((val_type >> data->id) & 0x1))
 			goto out;
 	}
@@ -576,7 +576,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
 	 */
-	if (!TMU_SUPPORTS(pdata, SHARED_MEMORY))
+	if (!TMU_SUPPORTS(pdata, ADDRESS_MULTIPLE))
 		return 0;
 
 	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {
@@ -584,7 +584,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->base_common = devm_ioremap(&pdev->dev, res.start,
+	data->base_second = devm_ioremap(&pdev->dev, res.start,
 					resource_size(&res));
 	if (!data->base_common) {
 		dev_err(&pdev->dev, "Failed to ioremap memory\n");
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 7c6c34a..ebd2ec1 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -59,7 +59,7 @@ enum soc_type {
  *			state(active/idle) can be checked.
  * TMU_SUPPORT_EMUL_TIME - This features allows to set next temp emulation
  *			sample time.
- * TMU_SUPPORT_SHARED_MEMORY - This feature tells that the different TMU
+ * TMU_SUPPORT_ADDRESS_MULTIPLE - This feature tells that the different TMU
  *			sensors shares some common registers.
  * TMU_SUPPORT - macro to compare the above features with the supplied.
  */
@@ -69,7 +69,7 @@ enum soc_type {
 #define TMU_SUPPORT_FALLING_TRIP		BIT(3)
 #define TMU_SUPPORT_READY_STATUS		BIT(4)
 #define TMU_SUPPORT_EMUL_TIME			BIT(5)
-#define TMU_SUPPORT_SHARED_MEMORY		BIT(6)
+#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(6)
 
 #define TMU_SUPPORTS(a, b)	(a->features & TMU_SUPPORT_ ## b)
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 23fea23..58570d0 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -239,7 +239,7 @@ static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.type = SOC_ARCH_EXYNOS5440, \
 	.registers = &exynos5440_tmu_registers, \
 	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_MULTI_INST | TMU_SUPPORT_SHARED_MEMORY),
+			TMU_SUPPORT_MULTI_INST | TMU_SUPPORT_ADDRESS_MULTIPLE),
 
 struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	.tmu_data = {
-- 
1.7.10.4
