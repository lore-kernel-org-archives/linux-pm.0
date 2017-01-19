From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 12/13] pinctrl: samsung: Move retention control from
 mach-s5pv210 to the pinctrl driver
Date: Thu, 19 Jan 2017 14:48:52 +0100
Message-ID: <1484833733-16082-13-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134910eucas1p2d401df77ccc1ef8e7b05f4cdb2ffc8d3@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch moves pad retention control from S5PV210 machine code to
Exynos pin controller driver. This helps to avoid possible ordering
and logical dependencies between machine and pin control code. Till
now it worked fine only because sys_ops for machine code and pin
controller were called in registration order.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
For mach-s5pv210:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s5pv210/pm.c               |  7 ----
 arch/arm/mach-s5pv210/regs-clock.h       |  4 ---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 2d5f08015e34..07cee14a363b 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -155,13 +155,6 @@ static void s5pv210_suspend_finish(void)
  */
 static void s5pv210_pm_resume(void)
 {
-	u32 tmp;
-
-	tmp = __raw_readl(S5P_OTHERS);
-	tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_CF |\
-		S5P_OTHERS_RET_MMC | S5P_OTHERS_RET_UART);
-	__raw_writel(tmp , S5P_OTHERS);
-
 	s3c_pm_do_restore_core(s5pv210_core_save, ARRAY_SIZE(s5pv210_core_save));
 }
 
diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
index 4640f0f03c12..fb3eb77412db 100644
--- a/arch/arm/mach-s5pv210/regs-clock.h
+++ b/arch/arm/mach-s5pv210/regs-clock.h
@@ -188,10 +188,6 @@
 #define S5P_SLEEP_CFG_USBOSC_EN		(1 << 1)
 
 /* OTHERS Resgister */
-#define S5P_OTHERS_RET_IO		(1 << 31)
-#define S5P_OTHERS_RET_CF		(1 << 30)
-#define S5P_OTHERS_RET_MMC		(1 << 29)
-#define S5P_OTHERS_RET_UART		(1 << 28)
 #define S5P_OTHERS_USB_SIG_MASK		(1 << 16)
 
 /* S5P_DAC_CONTROL */
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index e7a099c4fb78..63e51b56a22a 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -24,6 +24,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -643,6 +644,60 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 			exynos_pinctrl_resume_bank(drvdata, bank);
 }
 
+/* Retention control for S5PV210 are located at the end of clock controller */
+#define S5P_OTHERS 0xE000
+
+#define S5P_OTHERS_RET_IO		(1 << 31)
+#define S5P_OTHERS_RET_CF		(1 << 30)
+#define S5P_OTHERS_RET_MMC		(1 << 29)
+#define S5P_OTHERS_RET_UART		(1 << 28)
+
+static void s5pv210_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
+{
+	void *clk_base = drvdata->retention_ctrl->priv;
+	u32 tmp;
+
+	tmp = __raw_readl(clk_base + S5P_OTHERS);
+	tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_CF | S5P_OTHERS_RET_MMC |
+		S5P_OTHERS_RET_UART);
+	__raw_writel(tmp, clk_base + S5P_OTHERS);
+}
+
+static struct samsung_retention_ctrl *
+s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
+		       const struct samsung_retention_data *data)
+{
+	struct samsung_retention_ctrl *ctrl;
+	struct device_node *np;
+	void *clk_base;
+
+	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
+	if (!np) {
+		pr_err("%s: failed to find clock controller DT node\n",
+			__func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	clk_base = of_iomap(np, 0);
+	if (!clk_base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctrl->priv = clk_base;
+	ctrl->disable = s5pv210_retention_disable;
+
+	return ctrl;
+}
+
+static const struct samsung_retention_data s5pv210_retention_data __initconst = {
+	.init	 = s5pv210_retention_init,
+};
+
 /* pin banks of s5pv210 pin-controller */
 static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -690,6 +745,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &s5pv210_retention_data,
 	},
 };
 
-- 
1.9.1
