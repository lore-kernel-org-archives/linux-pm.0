From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 09/12] pinctrl: samsung: Add infrastructure for pin-bank
 retention control
Date: Mon, 16 Jan 2017 07:45:04 +0100
Message-ID: <1484549107-5957-10-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064527eucas1p1f0f78e9420e7d9d60d94b6e7381caeb1@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Pad retention control after suspend/resume cycle should be done from pin
controller driver instead of PMU (power management unit) driver to avoid
possible ordering and logical dependencies. Till now it worked fine only
because PMU driver registered its sys_ops after pin controller.

This patch adds infrastructure to handle pad retention during pin control
driver resume.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 12 ++++++---
 drivers/pinctrl/samsung/pinctrl-samsung.h | 42 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 86f23842f681..95a84086a2e9 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1075,6 +1075,9 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 		ctrl->eint_gpio_init(drvdata);
 	if (ctrl->eint_wkup_init)
 		ctrl->eint_wkup_init(drvdata);
+	if (ctrl->retention_data && ctrl->retention_data->init)
+		drvdata->retention_ctrl = ctrl->retention_data->init(drvdata,
+							  ctrl->retention_data);
 
 	platform_set_drvdata(pdev, drvdata);
 
@@ -1127,15 +1130,15 @@ static void samsung_pinctrl_suspend_dev(
 
 	if (drvdata->suspend)
 		drvdata->suspend(drvdata);
+	if (drvdata->retention_ctrl && drvdata->retention_ctrl->on)
+		drvdata->retention_ctrl->on(drvdata);
+
 }
 
 /**
  * samsung_pinctrl_resume_dev - restore pinctrl state from suspend for a device
  *
  * Restore one of the banks that was saved during suspend.
- *
- * We don't bother doing anything complicated to avoid glitching lines since
- * we're called before pad retention is turned off.
  */
 static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 {
@@ -1174,6 +1177,9 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 			if (widths[type])
 				writel(bank->pm_save[type], reg + offs[type]);
 	}
+
+	if (drvdata->retention_ctrl && drvdata->retention_ctrl->off)
+		drvdata->retention_ctrl->off(drvdata);
 }
 
 /**
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 6f7ce7539a00..6079142422f8 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -185,10 +185,48 @@ struct samsung_pin_bank {
 };
 
 /**
+ * struct samsung_retention_data: runtime pin-bank retention control data.
+ * @regs: array of PMU registers to control pad retention.
+ * @nr_regs: number of registers in @regs array.
+ * @value: value to store to registers to turn off retention.
+ * @refcnt: atomic counter if retention control affects more than one bank.
+ * @priv: retention control code private data
+ * @on: platform specific callback to enter retention mode.
+ * @off: platform specific callback to exit retention mode.
+ **/
+struct samsung_retention_ctrl {
+	const u32	*regs;
+	int		nr_regs;
+	u32		value;
+	atomic_t	*refcnt;
+	void		*priv;
+	void		(*on)(struct samsung_pinctrl_drv_data *);
+	void		(*off)(struct samsung_pinctrl_drv_data *);
+};
+
+/**
+ * struct samsung_retention_data: represent a pin-bank retention control data.
+ * @regs: array of PMU registers to control pad retention.
+ * @nr_regs: number of registers in @regs array.
+ * @value: value to store to registers to turn off retention.
+ * @refcnt: atomic counter if retention control affects more than one bank.
+ * @init: platform specific callback to initialize retention control.
+ **/
+struct samsung_retention_data {
+	const u32	*regs;
+	int		nr_regs;
+	u32		value;
+	atomic_t	*refcnt;
+	struct samsung_retention_ctrl *(*init)(struct samsung_pinctrl_drv_data *,
+					const struct samsung_retention_data *);
+};
+
+/**
  * struct samsung_pin_ctrl: represent a pin controller.
  * @pin_banks: list of pin banks included in this controller.
  * @nr_banks: number of pin banks.
  * @nr_ext_resources: number of the extra base address for pin banks.
+ * @retention_data: configuration data for retention control.
  * @eint_gpio_init: platform specific callback to setup the external gpio
  *	interrupts for the controller.
  * @eint_wkup_init: platform specific callback to setup the external wakeup
@@ -198,6 +236,7 @@ struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
 	u32		nr_banks;
 	int		nr_ext_resources;
+	const struct samsung_retention_data *retention_data;
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
@@ -219,6 +258,7 @@ struct samsung_pin_ctrl {
  * @nr_function: number of such pin functions.
  * @pin_base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
+ * @retention_ctrl: retention control runtime data.
  */
 struct samsung_pinctrl_drv_data {
 	struct list_head		node;
@@ -238,6 +278,8 @@ struct samsung_pinctrl_drv_data {
 	unsigned int			pin_base;
 	unsigned int			nr_pins;
 
+	const struct samsung_retention_ctrl *retention_ctrl;
+
 	void (*suspend)(struct samsung_pinctrl_drv_data *);
 	void (*resume)(struct samsung_pinctrl_drv_data *);
 };
-- 
1.9.1

