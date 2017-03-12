From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 RESEND] power: reset: Add a driver for the Gemini poweroff
Date: Sun, 12 Mar 2017 23:36:21 +0100
Message-ID: <20170312223621.3010-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34889 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935355AbdCLWg2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 18:36:28 -0400
Received: by mail-lf0-f54.google.com with SMTP id j90so57369055lfk.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Mar 2017 15:36:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org, inux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org

The Gemini (SL3516) SoC has a special power controller block
that only deal with shutting down the system.

If you do not register a driver and activate the block, the
power button on the systems utilizing this SoC will do an
uncontrolled power cut, which is why it is important to have
a special poweroff driver.

The most basic functionality is to just shut down the system
by writing a special bit in the control register after the
system has reached pm_poweroff.

It also handles the poweroff from a button or other sources:

When the poweroff button is pressed, or a signal is sent to
poweroff from an infrared remote control, or when the RTC
fires a special alarm (!) the system emits an interrupt.
At this point, Linux must acknowledge the interrupt and
proceed to do an orderly shutdown of the system.

After adding this driver, pressing the poweroff button gives
this dmesg:

root@gemini:/
root@gemini:/ gemini-poweroff 4b000000.power-controller:
poweroff button pressed

calling shutdown scripts..
setting /dev/rtc0 from system time
unmounting file systems...
umount: tmpfs busy - remounted read-only
umount: can't unmount /: Invalid argument
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
uhci_hcd 0000:00:09.1: HCRESET not completed yet!
uhci_hcd 0000:00:09.0: HCRESET not completed yet!
reboot: Power down
gemini-poweroff 4b000000.power-controller: Gemini power off

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sebastian: please just merge this when your are pleased
with it. I will funnel the ARM parts through the ARM SoC tree.
---
 drivers/power/reset/Kconfig           |   9 ++
 drivers/power/reset/Makefile          |   1 +
 drivers/power/reset/gemini-poweroff.c | 160 ++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/power/reset/gemini-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index b8cacccf18c8..13f1714cf6f7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -67,6 +67,15 @@ config POWER_RESET_BRCMSTB
 	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
+config POWER_RESET_GEMINI_POWEROFF
+	bool "Cortina Gemini power-off driver"
+	depends on ARCH_GEMINI || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	default ARCH_GEMINI
+	help
+	  This driver supports turning off the Cortina Gemini SoC.
+	  Select this if you're building a kernel with Gemini SoC support.
+
 config POWER_RESET_GPIO
 	bool "GPIO power-off driver"
 	depends on OF_GPIO
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11dae3b56ff9..58cf5b30559f 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) += at91-sama5d2_shdwc.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
+obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
diff --git a/drivers/power/reset/gemini-poweroff.c b/drivers/power/reset/gemini-poweroff.c
new file mode 100644
index 000000000000..de878fd26f27
--- /dev/null
+++ b/drivers/power/reset/gemini-poweroff.c
@@ -0,0 +1,160 @@
+/*
+ * Gemini power management controller
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Inspired by code from the SL3516 board support by Jason Lee
+ * Inspired by code from Janos Laube <janos.dev@gmail.com>
+ */
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/reboot.h>
+
+#define GEMINI_PWC_ID		0x00010500
+#define	GEMINI_PWC_IDREG	0x00
+#define	GEMINI_PWC_CTRLREG	0x04
+#define	GEMINI_PWC_STATREG	0x08
+
+#define GEMINI_CTRL_SHUTDOWN	BIT(0)
+#define GEMINI_CTRL_ENABLE	BIT(1)
+#define GEMINI_CTRL_IRQ_CLR	BIT(2)
+
+#define GEMINI_STAT_CIR		BIT(4)
+#define	GEMINI_STAT_RTC		BIT(5)
+#define	GEMINI_STAT_POWERBUTTON	BIT(6)
+
+struct gemini_powercon {
+        struct device           *dev;
+        void __iomem            *base;
+};
+
+static irqreturn_t gemini_powerbutton_interrupt(int irq, void *data)
+{
+	struct gemini_powercon *gpw = data;
+	u32 val;
+
+	/* ACK the IRQ */
+	val = readl(gpw->base + GEMINI_PWC_CTRLREG);
+	val |= GEMINI_CTRL_IRQ_CLR;
+	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	val = readl(gpw->base + GEMINI_PWC_STATREG);
+	val &= 0x70U;
+	switch (val) {
+	case GEMINI_STAT_CIR:
+		dev_info(gpw->dev, "infrared poweroff\n");
+		orderly_poweroff(true);
+		break;
+	case GEMINI_STAT_RTC:
+		dev_info(gpw->dev, "RTC poweroff\n");
+		orderly_poweroff(true);
+		break;
+	case GEMINI_STAT_POWERBUTTON:
+		dev_info(gpw->dev, "poweroff button pressed\n");
+		orderly_poweroff(true);
+		break;
+	default:
+		dev_info(gpw->dev, "other power management IRQ\n");
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* This callback needs this static local as it has void as argument */
+static struct gemini_powercon *gpw_poweroff;
+
+static void gemini_poweroff(void)
+{
+	struct gemini_powercon *gpw = gpw_poweroff;
+	u32 val;
+
+	dev_crit(gpw->dev, "Gemini power off\n");
+	val = readl(gpw->base + GEMINI_PWC_CTRLREG);
+	val |= GEMINI_CTRL_ENABLE | GEMINI_CTRL_IRQ_CLR;
+	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	val &= ~GEMINI_CTRL_ENABLE;
+	val |= GEMINI_CTRL_SHUTDOWN;
+	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+}
+
+static int gemini_poweroff_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct gemini_powercon *gpw;
+	u32 val;
+	int irq;
+	int ret;
+
+	gpw = devm_kzalloc(dev, sizeof(*gpw), GFP_KERNEL);
+	if (!gpw)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpw->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(gpw->base))
+		return PTR_ERR(gpw->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (!irq)
+		return -EINVAL;
+
+	gpw->dev = dev;
+
+	val = readl(gpw->base + GEMINI_PWC_IDREG);
+	val &= 0xFFFFFF00U;
+	if (val != GEMINI_PWC_ID) {
+		dev_err(dev, "wrong power controller ID: %08x\n",
+			val);
+		return -ENODEV;
+	}
+
+	/* Clear the power management IRQ */
+	val = readl(gpw->base + GEMINI_PWC_CTRLREG);
+	val |= GEMINI_CTRL_IRQ_CLR;
+	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	ret = devm_request_irq(dev, irq, gemini_powerbutton_interrupt, 0,
+			       "poweroff", gpw);
+	if (ret)
+		return ret;
+
+	pm_power_off = gemini_poweroff;
+	gpw_poweroff = gpw;
+
+	/*
+	 * Enable the power controller. This is crucial on Gemini
+	 * systems: if this is not done, pressing the power button
+	 * will result in unconditional poweroff without any warning.
+	 * This makes the kernel handle the poweroff.
+	 */
+	val = readl(gpw->base + GEMINI_PWC_CTRLREG);
+	val |= GEMINI_CTRL_ENABLE;
+	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	dev_info(dev, "Gemini poweroff driver registered\n");
+
+	return 0;
+}
+
+static const struct of_device_id gemini_poweroff_of_match[] = {
+	{
+		.compatible = "cortina,gemini-power-controller",
+	},
+	{}
+};
+
+static struct platform_driver gemini_poweroff_driver = {
+	.probe = gemini_poweroff_probe,
+	.driver = {
+		.name = "gemini-poweroff",
+		.of_match_table = gemini_poweroff_of_match,
+	},
+};
+builtin_platform_driver(gemini_poweroff_driver);
-- 
2.9.3
