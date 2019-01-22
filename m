From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Date: Tue, 22 Jan 2019 11:48:36 +0200
Message-ID: <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Initial support for watchdog block included in ROHM BD70528
power management IC.

Configurations for low power states are still to be checked.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/watchdog/Kconfig       |  12 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd70528_wdt.c | 161 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/watchdog/bd70528_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d74a97..f30e3a3e886e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
 	  watchdog. Be aware that governors might affect the watchdog because it
 	  is purely software, e.g. the panic governor will stall it!
 
+config BD70528_WATCHDOG
+	tristate "ROHM BD70528 PMIC Watchdog"
+	depends on MFD_ROHM_BD70528
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
+	  cause system reset.
+
+	  Say Y here to include support for the ROHM BD70528 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called bd70528_wdt.
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052 || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a0917ef28e07..1ce87a3b1172 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
+obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
new file mode 100644
index 000000000000..e9a32566f595
--- /dev/null
+++ b/drivers/watchdog/bd70528_wdt.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// ROHM BD70528MWV watchdog driver
+
+#include <linux/bcd.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
+{
+	int ret;
+
+	if (bd70528->rtc_timer_lock)
+		mutex_lock(bd70528->rtc_timer_lock);
+
+	ret = bd70528->wdt_set(bd70528, enable, NULL);
+
+	if (bd70528->rtc_timer_lock)
+		mutex_unlock(bd70528->rtc_timer_lock);
+	return ret;
+}
+
+static int bd70528_wdt_start(struct watchdog_device *wdt)
+{
+	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
+
+	return bd70528_wdt_set(bd70528, 1);
+}
+
+static int bd70528_wdt_stop(struct watchdog_device *wdt)
+{
+	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
+
+	return bd70528_wdt_set(bd70528, 0);
+}
+
+static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
+				    unsigned int timeout)
+{
+	unsigned int hours;
+	unsigned int minutes;
+	unsigned int seconds;
+	int ret;
+	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
+
+	seconds = timeout;
+	hours = timeout / (60 * 60);
+	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
+	if (hours)
+		seconds -= (60 * 60);
+	minutes = seconds / 60;
+	seconds = seconds % 60;
+
+	if (bd70528->rtc_timer_lock)
+		mutex_lock(bd70528->rtc_timer_lock);
+
+	ret = bd70528->wdt_set(bd70528, 0, NULL);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_HOUR,
+				 BD70528_MASK_WDT_HOUR, hours);
+	if (ret) {
+		dev_err(bd70528->chip.dev, "Failed to set WDT hours\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_MINUTE,
+				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
+	if (ret) {
+		dev_err(bd70528->chip.dev, "Failed to set WDT minutes\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_SEC,
+				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
+	if (ret) {
+		dev_err(bd70528->chip.dev, "Failed to set WDT seconds\n");
+		goto out_en_unlock;
+	}
+
+out_en_unlock:
+	ret = bd70528->wdt_set(bd70528, 1, NULL);
+out_unlock:
+	if (bd70528->rtc_timer_lock)
+		mutex_lock(bd70528->rtc_timer_lock);
+
+	return ret;
+}
+
+static const struct watchdog_info bd70528_wdt_info = {
+	.identity = "bd70528-wdt",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops bd70528_wdt_ops = {
+	.start		= bd70528_wdt_start,
+	.stop		= bd70528_wdt_stop,
+	/*
+	 *  bd70528 WDT ping is same as enable. Eg, writing 'enable' to enabled
+	 * WDT will restart the timeout
+	 */
+	.ping		= bd70528_wdt_start,
+	.set_timeout	= bd70528_wdt_set_timeout,
+};
+
+/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
+#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
+/* Minimum time is 1 second */
+#define WDT_MIN_MS 1000
+static struct watchdog_device bd70528_wd = {
+	.info = &bd70528_wdt_info,
+	.ops =  &bd70528_wdt_ops,
+	.min_hw_heartbeat_ms = WDT_MIN_MS,
+	.max_hw_heartbeat_ms = WDT_MAX_MS,
+};
+
+static int bd70528_wdt_probe(struct platform_device *pdev)
+{
+	struct bd70528 *tmp;
+	struct bd70528 *bd70528;
+	int ret;
+
+	tmp = dev_get_drvdata(pdev->dev.parent);
+	if (!tmp) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
+	if (!bd70528)
+		return -ENOMEM;
+
+	*bd70528 = *tmp;
+	bd70528->chip.dev = &pdev->dev;
+
+	/*
+	 * TODO: Set the initial state and timeout.
+	 * See whether the low power states require special handling
+	 */
+	watchdog_set_drvdata(&bd70528_wd, bd70528);
+	ret = devm_watchdog_register_device(&pdev->dev, &bd70528_wd);
+	if (ret < 0)
+		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+
+	return ret;
+}
+static struct platform_driver bd70528_wdt = {
+	.driver = {
+		.name = "bd70528-wdt"
+	},
+	.probe = bd70528_wdt_probe,
+};
+
+module_platform_driver(bd70528_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
