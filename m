From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v3 1/2] power: reset: add LTC2952 poweroff support
Date: Mon, 6 Oct 2014 10:40:35 +0200
Message-ID: <1412584836-27677-2-git-send-email-frans.klaver@xsens.com>
References: <1412584836-27677-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:46877 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaJFIlm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 04:41:42 -0400
In-Reply-To: <1412584836-27677-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

=46rom: Ren=C3=A9 Moll <linux@r-moll.nl>

The LTC2952 allows control over system power using a push button. It al=
so
supports powering down the board from a controller on the board.

If the power button is pushed, the ltc2952 starts a 400ms window to
properly shut down the software. This window can be stretched by
toggling a watchdog line. This driver always uses this watchdog line.
The power button input is optional. This allows the system to use a
custom shutdown sequence on the push button.

On software shutdown the driver sets the kill signal, starting the same
sequence as if the push button was used.

Signed-off-by: Ren=E9 Moll <linux@r-moll.nl>
Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>
Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/Kconfig            |  10 +
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/ltc2952-poweroff.c | 381 +++++++++++++++++++++++++=
++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 drivers/power/reset/ltc2952-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca41523..a0f68da 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -45,6 +45,16 @@ config POWER_RESET_HISI
 	help
 	  Reboot support for Hisilicon boards.
=20
+config POWER_RESET_LTC2952
+	bool "LTC2952 PowerPath power-off driver"
+	depends on OF_GPIO && POWER_RESET
+	help
+	  This driver supports an external powerdown trigger and board
+	  power down via the LTC2952.
+
+	  If your board uses an LTC2952, say  Y and create a binding
+	  in the device tree.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on POWER_RESET && ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
index a42e70e..3cbb7c3 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AXXIA) +=3D axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) +=3D brcmstb-reboot.o
 obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
+obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/res=
et/ltc2952-poweroff.c
new file mode 100644
index 0000000..2cf146a
--- /dev/null
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -0,0 +1,381 @@
+/*
+ * LTC2952 PowerPath TM driver
+ *
+ * Copyright (C) 2014, Xsens Technologies BV <info@xsens.com>
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
+ * This driver is to be used with an external LTC2952 PowerPath Contro=
ller.
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
+ * - trigger (input, optional)
+ *     A level change indicates the shut-down trigger. If it's state r=
everts
+ *     within the time-out defined by trigger_delay, the shut down is =
not
+ *     executed. If no pin is assigned to this input the driver will s=
tart
+ *     the watchdog immediately and only a power off event will kill t=
he ltc2952
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
+	struct gpio_desc *gpio_trigger;
+	struct gpio_desc *gpio_watchdog;
+	struct gpio_desc *gpio_kill;
+};
+
+static bool ltc2952_poweroff_panic;
+static struct ltc2952_poweroff_data *ltc2952_data;
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
+	state =3D gpiod_get_value(ltc2952_data->gpio_watchdog);
+	gpiod_set_value(ltc2952_data->gpio_watchdog, !state);
+
+	now =3D hrtimer_cb_get_time(timer);
+	overruns =3D hrtimer_forward(timer, now, ltc2952_data->wde_interval);
+
+	return HRTIMER_RESTART;
+}
+
+static void ltc2952_poweroff_start_wde(void)
+{
+	int ret;
+
+	ret =3D hrtimer_start(&ltc2952_data->timer_wde,
+			    ltc2952_data->wde_interval, HRTIMER_MODE_REL);
+
+	if (ret) {
+		dev_err(ltc2952_data->dev,
+			"unable to start the watchdog timer\n");
+		/*
+		 * The device will not toggle the watchdog reset,
+		 * thus shut down is only safe if the PowerPath controller
+		 * has a long enough time-off before triggering a hardware
+		 * power-off.
+		 *
+		 * Only sending a warning as the system will power-off anyway
+		 */
+	}
+}
+
+static enum hrtimer_restart ltc2952_poweroff_timer_trigger(struct hrti=
mer *t)
+{
+	ltc2952_poweroff_start_wde();
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
+	struct ltc2952_poweroff_data *data =3D dev_id;
+
+	if (ltc2952_poweroff_panic || hrtimer_active(&data->timer_wde))
+		/* we're either panicking, or already shutting down */
+		goto irq_ok;
+
+	if (hrtimer_active(&data->timer_trigger)) {
+		hrtimer_cancel(&data->timer_trigger);
+		goto irq_ok;
+	}
+
+	if (hrtimer_start(&data->timer_trigger, data->trigger_delay,
+			  HRTIMER_MODE_REL))
+		dev_err(data->dev, "unable to start the wait timer\n");
+
+irq_ok:
+	return IRQ_HANDLED;
+}
+
+static void ltc2952_poweroff_kill(void)
+{
+	gpiod_set_value(ltc2952_data->gpio_kill, 1);
+}
+
+static int ltc2952_poweroff_suspend(struct platform_device *pdev,
+				    pm_message_t state)
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
+	int ret;
+
+	ltc2952_poweroff_default(ltc2952_data);
+
+	ltc2952_data->gpio_watchdog =3D gpiod_get(&pdev->dev, "watchdog");
+	if (IS_ERR(ltc2952_data->gpio_watchdog)) {
+		ret =3D PTR_ERR(ltc2952_data->gpio_watchdog);
+		dev_err(&pdev->dev, "unable to claim watchdog-gpio\n");
+		goto err;
+	}
+
+	ret =3D gpiod_direction_output(ltc2952_data->gpio_watchdog, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to use watchdog-gpio as output\n");
+		goto err_watchdog;
+	}
+
+	ltc2952_data->gpio_kill =3D gpiod_get(&pdev->dev, "kill");
+	if (IS_ERR(ltc2952_data->gpio_kill)) {
+		ret =3D PTR_ERR(ltc2952_data->gpio_kill);
+		dev_err(&pdev->dev, "unable to claim kill-gpio\n");
+		goto err_watchdog;
+	}
+
+	ret =3D gpiod_direction_output(ltc2952_data->gpio_kill, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to use kill-gpio as output\n");
+		goto err_kill;
+	}
+
+	ltc2952_data->gpio_trigger =3D gpiod_get(&pdev->dev, "trigger");
+	if (IS_ERR(ltc2952_data->gpio_trigger)) {
+		ret =3D PTR_ERR(ltc2952_data->gpio_trigger);
+
+		if (ret !=3D -ENOENT) {
+			dev_err(&pdev->dev, "unable to claim trigger-gpio\n");
+			goto err_kill;
+		}
+
+		dev_info(&pdev->dev, "No trigger input defined\n");
+		ltc2952_data->gpio_trigger =3D NULL;
+		ltc2952_poweroff_start_wde();
+		return 0;
+	}
+
+	ltc2952_data->virq =3D gpiod_to_irq(ltc2952_data->gpio_trigger);
+	if (ltc2952_data->virq < 0) {
+		dev_err(&pdev->dev, "cannot map GPIO as interrupt");
+		goto err_trigger;
+	}
+
+	ret =3D request_irq(ltc2952_data->virq,
+			  ltc2952_poweroff_handler,
+			  (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+			  "ltc2952-poweroff",
+			  ltc2952_data);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot configure an interrupt handler\n");
+		goto err_trigger;
+	}
+	return 0;
+
+err_trigger:
+	gpiod_put(ltc2952_data->gpio_trigger);
+err_kill:
+	gpiod_put(ltc2952_data->gpio_kill);
+err_watchdog:
+	gpiod_put(ltc2952_data->gpio_watchdog);
+err:
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
+	pm_power_off =3D NULL;
+
+	if (ltc2952_data) {
+		if (ltc2952_data->gpio_trigger !=3D NULL)
+			free_irq(ltc2952_data->virq, ltc2952_data);
+
+		if (hrtimer_active(&ltc2952_data->timer_wde))
+			hrtimer_cancel(&ltc2952_data->timer_wde);
+
+		gpiod_put(ltc2952_data->gpio_watchdog);
+		gpiod_put(ltc2952_data->gpio_kill);
+		gpiod_put(ltc2952_data->gpio_trigger);
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
+					 unsigned long code,
+					 void *unused)
+{
+	ltc2952_poweroff_panic =3D true;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ltc2952_poweroff_panic_nb =3D {
+	.notifier_call =3D ltc2952_poweroff_notify_panic,
+};
+
+static int __init ltc2952_poweroff_platform_init(void)
+{
+	ltc2952_poweroff_panic =3D false;
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
+MODULE_AUTHOR("Ren=E9 Moll <linux@r-moll.nl>");
+MODULE_AUTHOR("Frans KLaver <frans.klaver@xsens.com>");
+MODULE_AUTHOR("Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>");
+MODULE_DESCRIPTION("LTC PowerPath power-off driver");
+MODULE_LICENSE("GPL v2");
--=20
2.1.0

