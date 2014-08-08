From: =?iso-8859-1?Q?Ren=E9_Moll?= <Rene.Moll@xsens.com>
Subject: [PATCH 1/2] power: reset: add LTC2952 poweroff support
Date: Fri, 8 Aug 2014 13:12:17 +0000
Message-ID: <8B68774BB69A844693005BA12A50F1146D4B86@XSMBXSVR01.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:53042 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641AbaHHNMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 09:12:21 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <Frans.Klaver@xsens.com>


Signed-off-by: Ren=E9 Moll <rene.moll@xsens.com>

---
 drivers/power/reset/Kconfig            |   7 +
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/ltc2952-poweroff.c | 387 +++++++++++++++++++++++++=
++++++++
 3 files changed, 395 insertions(+)
 create mode 100644 drivers/power/reset/ltc2952-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6d452a7..24c1bfd 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -26,6 +26,13 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
=20
+config POWER_RESET_LTC2952
+	bool "LTC2952 PowerPath power-off driver"
+	depends on OF_GPIO && POWER_RESET
+	help
+	  This driver supports an external powerdown trigger and board power
+	  down via the LTC2952. Bindings are made in the device tree.
+
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
 	depends on OF_GPIO && POWER_RESET && PLAT_ORION
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
index a5b4a77..c3e88e6 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_POWER_RESET_AS3722) +=3D as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) +=3D vexpress-poweroff.o
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/res=
et/ltc2952-poweroff.c
new file mode 100644
index 0000000..6577361
--- /dev/null
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -0,0 +1,387 @@
+/*
+ * LTC2952 (PowerPath) driver
+ *
+ * Copyright (C) 2014, Xsens Technologies BV <info@xsens.com>
+ * Maintainer: Ren=E9 Moll <linux@r-moll.nl>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ----------------------------------------
+ * - Description
+ * ----------------------------------------
+ *
+ * This driver is to be used with an external PowerPath Controller (LT=
C2952).
+ * Its function is to determine when a external shut down is triggered
+ * and react by properly shutting down the system.
+ *
+ * This driver expects a device tree with a ltc2952 entry for pin mapp=
ing.
+ *
+ * ----------------------------------------
+ * - GPIO
+ * ----------------------------------------
+ *
+ * The following GPIOs are used:
+ * - trigger (input)
+ *     A level change indicates the shut-down trigger. If it's state r=
everts
+ *     within the time-out defined by trigger_delay, the shut down is =
not
+ *     executed.
+ *
+ * - watchdog (output)
+ *     Once a shut down is triggered, the driver will toggle this sign=
al,
+ *     with an internal (wde_interval) to stall the hardware shut down=
=2E
+ *
+ * - kill (output)
+ *     The last action during shut down is triggering this signalling,=
 such
+ *     that the PowerPath Control will power down the hardware.
+ *
+ * ----------------------------------------
+ * - Interrupts
+ * ----------------------------------------
+ *
+ * The driver requires a non-shared, edge-triggered interrupt on the t=
rigger
+ * GPIO.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/reboot.h>
+
+struct ltc2952_poweroff_data {
+	struct hrtimer timer_trigger;
+	struct hrtimer timer_wde;
+
+	ktime_t trigger_delay;
+	ktime_t wde_interval;
+
+	struct device *dev;
+
+	unsigned int virq;
+
+	/**
+	 * 0: trigger
+	 * 1: watchdog
+	 * 2: kill
+	 */
+	struct gpio_desc *gpio[3];
+};
+
+static int ltc2952_poweroff_panic;
+static struct ltc2952_poweroff_data *ltc2952_data;
+
+#define POWERPATH_IO_TRIGGER	0
+#define POWERPATH_IO_WATCHDOG	1
+#define POWERPATH_IO_KILL	2
+
+/**
+ * ltc2952_poweroff_timer_wde - Timer callback
+ * Toggles the watchdog reset signal each wde_interval
+ *
+ * @timer: corresponding timer
+ *
+ * Returns HRTIMER_RESTART for an infinite loop which will only stop w=
hen the
+ * machine actually shuts down
+ */
+static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer =
*timer)
+{
+	ktime_t now;
+	int state;
+	unsigned long overruns;
+
+	if (ltc2952_poweroff_panic)
+		return HRTIMER_NORESTART;
+
+	state =3D gpiod_get_value(ltc2952_data->gpio[POWERPATH_IO_WATCHDOG]);
+	gpiod_set_value(ltc2952_data->gpio[POWERPATH_IO_WATCHDOG], !state);
+
+	now =3D hrtimer_cb_get_time(timer);
+	overruns =3D hrtimer_forward(timer, now, ltc2952_data->wde_interval);
+
+	return HRTIMER_RESTART;
+}
+
+static enum hrtimer_restart ltc2952_poweroff_timer_trigger(
+	struct hrtimer *timer)
+{
+	int ret;
+
+	ret =3D hrtimer_start(&ltc2952_data->timer_wde,
+		ltc2952_data->wde_interval, HRTIMER_MODE_REL);
+
+	if (ret) {
+		dev_err(ltc2952_data->dev, "unable to start the timer\n");
+		/*
+		 * The device will not toggle the watchdog reset,
+		 * thus shut down is only safe if the PowerPath controller
+		 * has a long enough time-off before triggering a hardware
+		 * power-off.
+		 *
+		 * Only sending a warning as the system will power-off anyway
+		 */
+	}
+
+	dev_info(ltc2952_data->dev, "executing shutdown\n");
+
+	orderly_poweroff(true);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * ltc2952_poweroff_handler - Interrupt handler
+ * Triggered each time the trigger signal changes state and (de)activa=
tes a
+ * time-out (timer_trigger). Once the time-out is actually reached the=
 shut
+ * down is executed.
+ *
+ * @irq: IRQ number
+ * @dev_id: pointer to the main data structure
+ */
+static irqreturn_t ltc2952_poweroff_handler(int irq, void *dev_id)
+{
+	int ret;
+	struct ltc2952_poweroff_data *data =3D dev_id;
+
+	if (ltc2952_poweroff_panic)
+		goto irq_ok;
+
+	if (hrtimer_active(&data->timer_wde)) {
+		/* shutdown is already triggered, nothing to do any more */
+		goto irq_ok;
+	}
+
+	if (!hrtimer_active(&data->timer_trigger)) {
+		ret =3D hrtimer_start(&data->timer_trigger, data->trigger_delay,
+			HRTIMER_MODE_REL);
+
+		if (ret)
+			dev_err(data->dev, "unable to start the wait timer\n");
+	} else {
+		ret =3D hrtimer_cancel(&data->timer_trigger);
+		/* omitting return value check, timer should have been valid */
+	}
+
+irq_ok:
+	return IRQ_HANDLED;
+}
+
+static void ltc2952_poweroff_kill(void)
+{
+	gpiod_set_value(ltc2952_data->gpio[POWERPATH_IO_KILL], 1);
+}
+
+static int ltc2952_poweroff_suspend(struct platform_device *pdev,
+	pm_message_t state)
+{
+	return -ENOSYS;
+}
+
+static int ltc2952_poweroff_resume(struct platform_device *pdev)
+{
+	return -ENOSYS;
+}
+
+static void ltc2952_poweroff_default(struct ltc2952_poweroff_data *dat=
a)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++)
+		data->gpio[i] =3D NULL;
+
+	data->wde_interval =3D ktime_set(0, 300L*1E6L);
+	data->trigger_delay =3D ktime_set(2, 500L*1E6L);
+
+	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL)=
;
+	data->timer_trigger.function =3D &ltc2952_poweroff_timer_trigger;
+
+	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->timer_wde.function =3D &ltc2952_poweroff_timer_wde;
+}
+
+static int ltc2952_poweroff_init(struct platform_device *pdev)
+{
+	int ret, virq;
+	unsigned int i;
+	struct ltc2952_poweroff_data *data;
+
+	static char *name[] =3D {
+		"trigger",
+		"watchdog",
+		"kill",
+		NULL
+	};
+
+	data =3D ltc2952_data;
+	ltc2952_poweroff_default(ltc2952_data);
+
+	for (i =3D 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++) {
+		ltc2952_data->gpio[i] =3D gpiod_get(&pdev->dev, name[i]);
+
+		if (IS_ERR(ltc2952_data->gpio[i])) {
+			ret =3D PTR_ERR(ltc2952_data->gpio[i]);
+			dev_err(&pdev->dev,
+				"unable to claim the following gpio: %s\n",
+				name[i]);
+			goto err_io;
+		}
+	}
+
+	ret =3D gpiod_direction_output(
+		ltc2952_data->gpio[POWERPATH_IO_WATCHDOG], 0);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to use watchdog-gpio as output\n");
+		goto err_io;
+	}
+
+	ret =3D gpiod_direction_output(ltc2952_data->gpio[POWERPATH_IO_KILL],=
 0);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to use kill-gpio as output\n");
+		goto err_io;
+	}
+
+	virq =3D gpiod_to_irq(ltc2952_data->gpio[POWERPATH_IO_TRIGGER]);
+	if (virq < 0) {
+		dev_err(&pdev->dev, "cannot map GPIO as interrupt");
+		goto err_io;
+	}
+
+	ltc2952_data->virq =3D virq;
+	ret =3D request_irq(virq,
+		ltc2952_poweroff_handler,
+		(IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+		"ltc2952-poweroff",
+		ltc2952_data
+	);
+
+	if (ret) {
+		dev_err(&pdev->dev, "cannot configure an interrupt handler\n");
+		goto err_io;
+	}
+
+	return 0;
+
+err_io:
+	for (i =3D 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
+		if (ltc2952_data->gpio[i])
+			gpiod_put(ltc2952_data->gpio[i]);
+
+	return ret;
+}
+
+static int ltc2952_poweroff_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (pm_power_off) {
+		dev_err(&pdev->dev, "pm_power_off already registered");
+		return -EBUSY;
+	}
+
+	ltc2952_data =3D kzalloc(sizeof(*ltc2952_data), GFP_KERNEL);
+	if (!ltc2952_data)
+		return -ENOMEM;
+
+	ltc2952_data->dev =3D &pdev->dev;
+
+	ret =3D ltc2952_poweroff_init(pdev);
+	if (ret)
+		goto err;
+
+	pm_power_off =3D &ltc2952_poweroff_kill;
+
+	dev_info(&pdev->dev, "probe successful\n");
+
+	return 0;
+
+err:
+	kfree(ltc2952_data);
+	return ret;
+}
+
+static int ltc2952_poweroff_remove(struct platform_device *pdev)
+{
+	unsigned int i;
+
+	pm_power_off =3D NULL;
+
+	if (ltc2952_data) {
+		free_irq(ltc2952_data->virq, ltc2952_data);
+
+		for (i =3D 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
+			gpiod_put(ltc2952_data->gpio[i]);
+
+		kfree(ltc2952_data);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_ltc2952_poweroff_match[] =3D {
+	{ .compatible =3D "lltc,ltc2952"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_ltc2952_poweroff_match);
+
+static struct platform_driver ltc2952_poweroff_driver =3D {
+	.probe =3D ltc2952_poweroff_probe,
+	.remove =3D ltc2952_poweroff_remove,
+	.driver =3D {
+		.name =3D "ltc2952-poweroff",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_ltc2952_poweroff_match,
+	},
+	.suspend =3D ltc2952_poweroff_suspend,
+	.resume =3D ltc2952_poweroff_resume,
+};
+
+static int ltc2952_poweroff_notify_panic(struct notifier_block *nb,
+	unsigned long code, void *unused)
+{
+	ltc2952_poweroff_panic =3D 1;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ltc2952_poweroff_panic_nb =3D {
+	.notifier_call =3D ltc2952_poweroff_notify_panic,
+};
+
+static int __init ltc2952_poweroff_platform_init(void)
+{
+	ltc2952_poweroff_panic =3D 0;
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+		&ltc2952_poweroff_panic_nb);
+
+	return platform_driver_register(&ltc2952_poweroff_driver);
+}
+
+static void __exit ltc2952_poweroff_platform_exit(void)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+		&ltc2952_poweroff_panic_nb);
+
+	platform_driver_unregister(&ltc2952_poweroff_driver);
+}
+
+module_init(ltc2952_poweroff_platform_init);
+module_exit(ltc2952_poweroff_platform_exit);
+
+MODULE_AUTHOR("Ren=E9 Moll <rene.moll@xsens.com>");
+MODULE_DESCRIPTION("LTC PowerPath power-off driver");
+MODULE_LICENSE("GPL v2");
+
--=20
1.9.1

