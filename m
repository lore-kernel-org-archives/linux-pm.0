From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v2 2/6] power: add power sequence library
Date: Wed, 13 Jul 2016 10:06:46 +0800
Message-ID: <1468375610-18625-3-git-send-email-peter.chen@nxp.com>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, Peter Chen <peter.chen@nxp.com>, p.zabel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
 drivers/power/Kconfig                 |   1 +
 drivers/power/Makefile                |   1 +
 drivers/power/pwrseq/Kconfig          |  20 +++++
 drivers/power/pwrseq/Makefile         |   2 +
 drivers/power/pwrseq/core.c           |  79 ++++++++++++++++++++
 drivers/power/pwrseq/pwrseq_generic.c | 134 ++++++++++++++++++++++++++++++++++
 include/linux/power/pwrseq.h          |  55 ++++++++++++++
 7 files changed, 292 insertions(+)
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/core.c
 create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
 create mode 100644 include/linux/power/pwrseq.h

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
index 0000000..e40315c
--- /dev/null
+++ b/drivers/power/pwrseq/core.c
@@ -0,0 +1,79 @@
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
+
+bool is_pwrseq_supported(struct device_node *np)
+{
+	if (of_find_property(np, "power-sequence", NULL))
+		return true;
+
+	return false;
+}
diff --git a/drivers/power/pwrseq/pwrseq_generic.c b/drivers/power/pwrseq/pwrseq_generic.c
new file mode 100644
index 0000000..20398aa
--- /dev/null
+++ b/drivers/power/pwrseq/pwrseq_generic.c
@@ -0,0 +1,134 @@
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
+	u32 duration_us = 50;
+	struct gpio_desc *gpiod_reset = pwrseq_gen->gpiod_reset;
+
+	if (pwrseq_gen->clk) {
+		ret = clk_prepare_enable(pwrseq_gen->clk);
+		if (ret) {
+			pr_err("Can't enable clock on %s: %d\n",
+				np->name, ret);
+			return ret;
+		}
+	}
+
+	if (gpiod_reset) {
+		of_property_read_u32(np, "reset-duration-us",
+				&duration_us);
+		gpiod_direction_output(gpiod_reset, 1);
+		gpiod_set_value(gpiod_reset, 1);
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
+	int gpio;
+
+	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(pwrseq_gen->clk)) {
+		pr_debug("Can't get clock on %s: %ld\n",
+			np->name, PTR_ERR(pwrseq_gen->clk));
+		pwrseq_gen->clk = NULL;
+	}
+
+	gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, NULL);
+	if (IS_ERR_VALUE(gpio) && (gpio != -ENODEV)) {
+		pr_err("Failed to get reset gpio on %s, err = %d\n",
+				np->name, gpio);
+		clk_put(pwrseq_gen->clk);
+		return gpio;
+	}
+
+	if (gpio != -ENODEV)
+		pwrseq_gen->gpiod_reset = gpio_to_desc(gpio);
+
+	return 0;
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
index 0000000..600f70c
--- /dev/null
+++ b/include/linux/power/pwrseq.h
@@ -0,0 +1,55 @@
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
+bool is_pwrseq_supported(struct device_node *np);
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
+static inline bool is_pwrseq_supported(struct device_node *np)
+{
+	return false;
+}
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
