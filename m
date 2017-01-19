From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Thu, 19 Jan 2017 14:48:51 +0100
Message-ID: <1484833733-16082-12-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134909eucas1p11a7638a4b9bf69b00458189ba9c1bb90@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch moves pad retention control from PMU driver to Exynos pin
controller driver. This helps to avoid possible ordering and logical
dependencies between machine, PMU and pin control code. Till now it
worked fine only because sys_ops for PMU and pin controller were called
in registration order.
This is also a preparation for adding new features to Exynos pin
controller driver, like runtime power management and suspending
individual pin controllers, which might be a part of some power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/suspend.c           |  64 --------------
 drivers/pinctrl/samsung/pinctrl-exynos.c | 145 +++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 94df5d5c024e..710bcb4d8f60 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -57,7 +57,6 @@ struct exynos_wkup_irq {
 struct exynos_pm_data {
 	const struct exynos_wkup_irq *wkup_irq;
 	unsigned int wake_disable_mask;
-	const unsigned int *release_ret_regs;
 
 	void (*pm_prepare)(void);
 	void (*pm_resume_prepare)(void);
@@ -95,47 +94,6 @@ struct exynos_pm_data {
 	{ /* sentinel */ },
 };
 
-static const unsigned int exynos_release_ret_regs[] = {
-	S5P_PAD_RET_MAUDIO_OPTION,
-	S5P_PAD_RET_GPIO_OPTION,
-	S5P_PAD_RET_UART_OPTION,
-	S5P_PAD_RET_MMCA_OPTION,
-	S5P_PAD_RET_MMCB_OPTION,
-	S5P_PAD_RET_EBIA_OPTION,
-	S5P_PAD_RET_EBIB_OPTION,
-	REG_TABLE_END,
-};
-
-static const unsigned int exynos3250_release_ret_regs[] = {
-	S5P_PAD_RET_MAUDIO_OPTION,
-	S5P_PAD_RET_GPIO_OPTION,
-	S5P_PAD_RET_UART_OPTION,
-	S5P_PAD_RET_MMCA_OPTION,
-	S5P_PAD_RET_MMCB_OPTION,
-	S5P_PAD_RET_EBIA_OPTION,
-	S5P_PAD_RET_EBIB_OPTION,
-	S5P_PAD_RET_MMC2_OPTION,
-	S5P_PAD_RET_SPI_OPTION,
-	REG_TABLE_END,
-};
-
-static const unsigned int exynos5420_release_ret_regs[] = {
-	EXYNOS_PAD_RET_DRAM_OPTION,
-	EXYNOS_PAD_RET_MAUDIO_OPTION,
-	EXYNOS_PAD_RET_JTAG_OPTION,
-	EXYNOS5420_PAD_RET_GPIO_OPTION,
-	EXYNOS5420_PAD_RET_UART_OPTION,
-	EXYNOS5420_PAD_RET_MMCA_OPTION,
-	EXYNOS5420_PAD_RET_MMCB_OPTION,
-	EXYNOS5420_PAD_RET_MMCC_OPTION,
-	EXYNOS5420_PAD_RET_HSI_OPTION,
-	EXYNOS_PAD_RET_EBIA_OPTION,
-	EXYNOS_PAD_RET_EBIB_OPTION,
-	EXYNOS5420_PAD_RET_SPI_OPTION,
-	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
-	REG_TABLE_END,
-};
-
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
@@ -441,15 +399,6 @@ static int exynos5420_pm_suspend(void)
 	return 0;
 }
 
-static void exynos_pm_release_retention(void)
-{
-	unsigned int i;
-
-	for (i = 0; (pm_data->release_ret_regs[i] != REG_TABLE_END); i++)
-		pmu_raw_writel(EXYNOS_WAKEUP_FROM_LOWPWR,
-				pm_data->release_ret_regs[i]);
-}
-
 static void exynos_pm_resume(void)
 {
 	u32 cpuid = read_cpuid_part();
@@ -457,9 +406,6 @@ static void exynos_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	/* For release retention */
-	exynos_pm_release_retention();
-
 	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
@@ -481,9 +427,6 @@ static void exynos3250_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	/* For release retention */
-	exynos_pm_release_retention();
-
 	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
 
 	if (call_firmware_op(resume) == -ENOSYS
@@ -521,9 +464,6 @@ static void exynos5420_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	/* For release retention */
-	exynos_pm_release_retention();
-
 	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
 
 early_wakeup:
@@ -636,7 +576,6 @@ static void exynos_suspend_finish(void)
 static const struct exynos_pm_data exynos3250_pm_data = {
 	.wkup_irq	= exynos3250_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
-	.release_ret_regs = exynos3250_release_ret_regs,
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos3250_pm_resume,
 	.pm_prepare	= exynos3250_pm_prepare,
@@ -646,7 +585,6 @@ static void exynos_suspend_finish(void)
 static const struct exynos_pm_data exynos4_pm_data = {
 	.wkup_irq	= exynos4_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
-	.release_ret_regs = exynos_release_ret_regs,
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos_pm_resume,
 	.pm_prepare	= exynos_pm_prepare,
@@ -656,7 +594,6 @@ static void exynos_suspend_finish(void)
 static const struct exynos_pm_data exynos5250_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
-	.release_ret_regs = exynos_release_ret_regs,
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos_pm_resume,
 	.pm_prepare	= exynos_pm_prepare,
@@ -666,7 +603,6 @@ static void exynos_suspend_finish(void)
 static const struct exynos_pm_data exynos5420_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = (0x7F << 7) | (0x1F << 1),
-	.release_ret_regs = exynos5420_release_ret_regs,
 	.pm_resume_prepare = exynos5420_prepare_pm_resume,
 	.pm_resume	= exynos5420_pm_resume,
 	.pm_suspend	= exynos5420_pm_suspend,
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 70b94ad10cc1..e7a099c4fb78 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -28,7 +28,10 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/err.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
@@ -690,6 +693,54 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 	},
 };
 
+/* Pad retention control code for accessing PMU regmap */
+static atomic_t exynos_shared_retention_refcnt;
+
+static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
+{
+	if (drvdata->retention_ctrl->refcnt)
+		atomic_inc(drvdata->retention_ctrl->refcnt);
+}
+
+static void exynos_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
+{
+	struct samsung_retention_ctrl *ctrl = drvdata->retention_ctrl;
+	struct regmap *pmu_regs = ctrl->priv;
+	int i;
+
+	if (ctrl->refcnt && !atomic_dec_and_test(ctrl->refcnt))
+		return;
+
+	for (i = 0; i < ctrl->nr_regs; i++)
+		regmap_write(pmu_regs, ctrl->regs[i], ctrl->value);
+}
+
+static struct samsung_retention_ctrl *
+exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
+		      const struct samsung_retention_data *data)
+{
+	struct samsung_retention_ctrl *ctrl;
+	struct regmap *pmu_regs;
+
+	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	pmu_regs = exynos_get_pmu_regmap();
+	if (IS_ERR(pmu_regs))
+		return ERR_CAST(pmu_regs);
+
+	ctrl->priv = pmu_regs;
+	ctrl->regs = data->regs;
+	ctrl->nr_regs = data->nr_regs;
+	ctrl->value = data->value;
+	ctrl->refcnt = data->refcnt;
+	ctrl->enable = exynos_retention_enable;
+	ctrl->disable = exynos_retention_disable;
+
+	return ctrl;
+}
+
 /* pin banks of exynos3250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -722,6 +773,30 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 };
 
 /*
+ * PMU pad retention groups for Exynos3250 doesn't match pin banks, so handle
+ * them all together
+ */
+static const u32 exynos3250_retention_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+	S5P_PAD_RET_MMC2_OPTION,
+	S5P_PAD_RET_SPI_OPTION,
+};
+
+static const struct samsung_retention_data exynos3250_retention_data __initconst = {
+	.regs	 = exynos3250_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos3250_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/*
  * Samsung pinctrl driver data for Exynos3250 SoC. Exynos3250 SoC includes
  * two gpio/pin-mux/pinconfig controllers.
  */
@@ -733,6 +808,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos3250_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos3250_pin_banks1,
@@ -741,6 +817,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos3250_retention_data,
 	},
 };
 
@@ -793,6 +870,36 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
 };
 
+/* PMU pad retention groups registers for Exynos4 (without audio) */
+static const u32 exynos4_retention_regs[] = {
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+};
+
+static const struct samsung_retention_data exynos4_retention_data __initconst = {
+	.regs	 = exynos4_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos4_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/* PMU retention control for audio pins can be tied to audio pin bank */
+static const u32 exynos4_audio_retention_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+};
+
+static const struct samsung_retention_data exynos4_audio_retention_data __initconst = {
+	.regs	 = exynos4_audio_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos4_audio_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.init	 = exynos_retention_init,
+};
+
 /*
  * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
  * three gpio/pin-mux/pinconfig controllers.
@@ -805,6 +912,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos4210_pin_banks1,
@@ -813,10 +921,12 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos4210_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks2),
+		.retention_data	= &exynos4_audio_retention_data,
 	},
 };
 
@@ -890,6 +1000,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos4x12_pin_banks1,
@@ -898,6 +1009,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos4x12_pin_banks2,
@@ -905,6 +1017,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_audio_retention_data,
 	}, {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos4x12_pin_banks3,
@@ -984,6 +1097,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5250_pin_banks1,
@@ -991,6 +1105,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5250_pin_banks2,
@@ -1005,6 +1120,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_audio_retention_data,
 	},
 };
 
@@ -1231,6 +1347,30 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
+/* PMU pad retention groups registers for Exynos5420 (without audio) */
+static const u32 exynos5420_retention_regs[] = {
+	EXYNOS_PAD_RET_DRAM_OPTION,
+	EXYNOS_PAD_RET_JTAG_OPTION,
+	EXYNOS5420_PAD_RET_GPIO_OPTION,
+	EXYNOS5420_PAD_RET_UART_OPTION,
+	EXYNOS5420_PAD_RET_MMCA_OPTION,
+	EXYNOS5420_PAD_RET_MMCB_OPTION,
+	EXYNOS5420_PAD_RET_MMCC_OPTION,
+	EXYNOS5420_PAD_RET_HSI_OPTION,
+	EXYNOS_PAD_RET_EBIA_OPTION,
+	EXYNOS_PAD_RET_EBIB_OPTION,
+	EXYNOS5420_PAD_RET_SPI_OPTION,
+	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
+};
+
+static const struct samsung_retention_data exynos5420_retention_data __initconst = {
+	.regs	 = exynos5420_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos5420_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
 /*
  * Samsung pinctrl driver data for Exynos5420 SoC. Exynos5420 SoC includes
  * four gpio/pin-mux/pinconfig controllers.
@@ -1242,26 +1382,31 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5420_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5420_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos5420_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 4 data */
 		.pin_banks	= exynos5420_pin_banks4,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos4_audio_retention_data,
 	},
 };
 
-- 
1.9.1
