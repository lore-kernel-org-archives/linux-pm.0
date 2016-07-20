From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v3 2/6] power: add power sequence library
Date: Wed, 20 Jul 2016 17:40:25 +0800
Message-ID: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:49120
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753622AbcGTJtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jul 2016 05:49:00 -0400
In-Reply-To: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>

We have an well-known problem that the device needs to do some power
sequence before it can be recognized by related host, the typical
example like hard-wired mmc devices and usb devices.

This power sequence is hard to be described at device tree and handled by
related host driver, so we have created a common power sequence
library to cover this requirement. The core code has supplied
some common helpers for host driver, and individual power sequence
libraries handle kinds of power sequence for devices.

pwrseq_generic is intended for general purpose of power sequence, which
handles gpios and clocks currently, and can cover regulator and pinctrl
in future. The host driver calls pwrseq_alloc_generic to create
an generic pwrseq instance.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 MAINTAINERS                           |   9 ++
 drivers/power/Kconfig                 |   1 +
 drivers/power/Makefile                |   1 +
 drivers/power/pwrseq/Kconfig          |  20 +++++
 drivers/power/pwrseq/Makefile         |   2 +
 drivers/power/pwrseq/core.c           |  71 ++++++++++++++++
 drivers/power/pwrseq/pwrseq_generic.c | 151 ++++++++++++++++++++++++++++++++++
 include/linux/power/pwrseq.h          |  50 +++++++++++
 8 files changed, 305 insertions(+)
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/core.c
 create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
 create mode 100644 include/linux/power/pwrseq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 68a90d0..6fd879f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9243,6 +9243,15 @@ F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	drivers/powercap/
 
+POWER SEQUENCE LIBRARY
+M:	Peter Chen <Peter.Chen@nxp.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/pwrseq/
+F:	drivers/power/pwrseq/
+F:	include/linux/power/pwrseq.h/
+
 POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index acd4a15..f6aa4fd 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -515,3 +515,4 @@ endif # POWER_SUPPLY
 
 source "drivers/power/reset/Kconfig"
 source "drivers/power/avs/Kconfig"
+source "drivers/power/pwrseq/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d..4ed2e12 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -74,3 +74,4 @@ obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_POWER_RESET)	+= reset/
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
+obj-$(CONFIG_POWER_SEQUENCE)	+= pwrseq/
diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
new file mode 100644
index 0000000..188729e
--- /dev/null
+++ b/drivers/power/pwrseq/Kconfig
@@ -0,0 +1,20 @@
+#
+# Power Sequence library
+#
+
+config POWER_SEQUENCE
+	bool
+
+menu "Power Sequence Support"
+
+config PWRSEQ_GENERIC
+	bool "Generic power sequence control"
+	depends on OF
+	select POWER_SEQUENCE
+	help
+	  It is used for drivers which needs to do power sequence
+	  (eg, turn on clock, toggle reset gpio) before the related
+	  devices can be found by hardware. This generic one can be
+	  used for common power sequence control.
+
+endmenu
diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
new file mode 100644
index 0000000..ad82389
--- /dev/null
+++ b/drivers/power/pwrseq/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_POWER_SEQUENCE) += core.o
+obj-$(CONFIG_PWRSEQ_GENERIC) += pwrseq_generic.o
diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
new file mode 100644
index 0000000..60f1e4e
--- /dev/null
+++ b/drivers/power/pwrseq/core.c
@@ -0,0 +1,71 @@
+/*
+ * core.c	power sequence core file
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/power/pwrseq.h>
+
+static DEFINE_MUTEX(pwrseq_list_mutex);
+static LIST_HEAD(pwrseq_list);
+
+int pwrseq_get(struct device_node *np, struct pwrseq *p)
+{
+	if (p && p->get)
+		return p->get(np, p);
+
+	return -ENOTSUPP;
+}
+
+int pwrseq_on(struct device_node *np, struct pwrseq *p)
+{
+	if (p && p->on)
+		return p->on(np, p);
+
+	return -ENOTSUPP;
+}
+
+void pwrseq_off(struct pwrseq *p)
+{
+	if (p && p->off)
+		p->off(p);
+}
+
+void pwrseq_put(struct pwrseq *p)
+{
+	if (p && p->put)
+		p->put(p);
+}
+
+void pwrseq_free(struct pwrseq *p)
+{
+	if (p && p->free)
+		p->free(p);
+}
+
+void pwrseq_register(struct pwrseq *pwrseq)
+{
+	mutex_lock(&pwrseq_list_mutex);
+	list_add(&pwrseq->node, &pwrseq_list);
+	mutex_unlock(&pwrseq_list_mutex);
+}
+
+void pwrseq_unregister(struct pwrseq *pwrseq)
+{
+	mutex_lock(&pwrseq_list_mutex);
+	list_del(&pwrseq->node);
+	mutex_unlock(&pwrseq_list_mutex);
+}
diff --git a/drivers/power/pwrseq/pwrseq_generic.c b/drivers/power/pwrseq/pwrseq_generic.c
new file mode 100644
index 0000000..b50cea6
--- /dev/null
+++ b/drivers/power/pwrseq/pwrseq_generic.c
@@ -0,0 +1,151 @@
+/*
+ * pwrseq_generic.c	Generic power sequence handling
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/slab.h>
+
+#include <linux/power/pwrseq.h>
+
+struct pwrseq_generic {
+	struct pwrseq pwrseq;
+	struct gpio_desc *gpiod_reset;
+	struct clk *clk;
+};
+
+#define to_generic_pwrseq(p) container_of(p, struct pwrseq_generic, pwrseq)
+
+static void pwrseq_generic_free(struct pwrseq *pwrseq)
+{
+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
+
+	pwrseq_unregister(pwrseq);
+	kfree(pwrseq_gen);
+}
+
+static void pwrseq_generic_put(struct pwrseq *pwrseq)
+{
+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
+
+	if (pwrseq_gen->gpiod_reset)
+		gpiod_put(pwrseq_gen->gpiod_reset);
+
+	clk_put(pwrseq_gen->clk);
+}
+
+static void pwrseq_generic_off(struct pwrseq *pwrseq)
+{
+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
+
+	clk_disable_unprepare(pwrseq_gen->clk);
+}
+
+static int pwrseq_generic_on(struct device_node *np, struct pwrseq *pwrseq)
+{
+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
+	int ret = 0;
+	struct gpio_desc *gpiod_reset = pwrseq_gen->gpiod_reset;
+
+	if (pwrseq_gen->clk) {
+		ret = clk_prepare_enable(pwrseq_gen->clk);
+		if (ret) {
+			pr_err("Can't enable clock on %s: %d\n",
+				np->full_name, ret);
+			return ret;
+		}
+	}
+
+	if (gpiod_reset) {
+		u32 duration_us = 50;
+
+		of_property_read_u32(np, "reset-duration-us",
+				&duration_us);
+		usleep_range(duration_us, duration_us + 10);
+		gpiod_set_value(gpiod_reset, 0);
+	}
+
+	return ret;
+}
+
+static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
+{
+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
+	enum of_gpio_flags flags;
+	int reset_gpio, ret = 0;
+
+	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(pwrseq_gen->clk)) {
+		pr_debug("Can't get clock on %s: %ld\n",
+			np->name, PTR_ERR(pwrseq_gen->clk));
+		pwrseq_gen->clk = NULL;
+	}
+
+	reset_gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);
+	if (gpio_is_valid(reset_gpio)) {
+		unsigned long gpio_flags;
+
+		if (flags & OF_GPIO_ACTIVE_LOW)
+			gpio_flags = GPIOF_ACTIVE_LOW | GPIOF_OUT_INIT_LOW;
+		else
+			gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+		ret = gpio_request_one(reset_gpio, gpio_flags,
+				"pwrseq-reset-gpios");
+		if (ret)
+			goto err;
+
+		pwrseq_gen->gpiod_reset = gpio_to_desc(reset_gpio);
+	} else {
+		if (reset_gpio == -ENOENT)
+			return 0;
+
+		ret = reset_gpio;
+		pr_err("Failed to get reset gpio on %s, err = %d\n",
+				np->full_name, reset_gpio);
+		goto err;
+	}
+
+	return ret;
+err:
+	clk_put(pwrseq_gen->clk);
+	return ret;
+}
+
+struct pwrseq *pwrseq_alloc_generic(void)
+{
+	struct pwrseq_generic *pwrseq_gen;
+
+	pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
+	if (!pwrseq_gen)
+		return ERR_PTR(-ENOMEM);
+
+	pwrseq_gen->pwrseq.get = pwrseq_generic_get;
+	pwrseq_gen->pwrseq.on = pwrseq_generic_on;
+	pwrseq_gen->pwrseq.off = pwrseq_generic_off;
+	pwrseq_gen->pwrseq.put = pwrseq_generic_put;
+	pwrseq_gen->pwrseq.free = pwrseq_generic_free;
+
+	pwrseq_register(&pwrseq_gen->pwrseq);
+	return &pwrseq_gen->pwrseq;
+}
+EXPORT_SYMBOL_GPL(pwrseq_alloc_generic);
diff --git a/include/linux/power/pwrseq.h b/include/linux/power/pwrseq.h
new file mode 100644
index 0000000..6c4b9a0
--- /dev/null
+++ b/include/linux/power/pwrseq.h
@@ -0,0 +1,50 @@
+#ifndef __LINUX_PWRSEQ_H
+#define __LINUX_PWRSEQ_H
+
+#include <linux/of.h>
+
+struct pwrseq {
+	char *name;
+	struct list_head node;
+	int (*get)(struct device_node *np, struct pwrseq *p);
+	int (*on)(struct device_node *np, struct pwrseq *p);
+	void (*off)(struct pwrseq *p);
+	void (*put)(struct pwrseq *p);
+	void (*free)(struct pwrseq *p);
+};
+
+#if IS_ENABLED(CONFIG_POWER_SEQUENCE)
+int pwrseq_get(struct device_node *np, struct pwrseq *p);
+int pwrseq_on(struct device_node *np, struct pwrseq *p);
+void pwrseq_off(struct pwrseq *p);
+void pwrseq_put(struct pwrseq *p);
+void pwrseq_free(struct pwrseq *p);
+void pwrseq_register(struct pwrseq *pwrseq);
+void pwrseq_unregister(struct pwrseq *pwrseq);
+
+#else
+static inline int pwrseq_get(struct device_node *np, struct pwrseq *p)
+{
+	return 0;
+}
+static inline int pwrseq_on(struct device_node *np, struct pwrseq *p)
+{
+	return 0;
+}
+static inline void pwrseq_off(struct pwrseq *p) {}
+static inline void pwrseq_put(struct pwrseq *p) {}
+static inline void pwrseq_free(struct pwrseq *p) {}
+static inline void pwrseq_register(struct pwrseq *pwrseq) {}
+static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
+#endif /* CONFIG_POWER_SEQUENCE */
+
+#if IS_ENABLED(CONFIG_PWRSEQ_GENERIC)
+struct pwrseq *pwrseq_alloc_generic(void);
+#else
+static inline struct pwrseq *pwrseq_alloc_generic(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_PWRSEQ_GENERIC */
+
+#endif  /* __LINUX_PWRSEQ_H */
-- 
1.9.1

