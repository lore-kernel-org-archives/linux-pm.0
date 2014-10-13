From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v5 1/2] power: reset: add LTC2952 poweroff support
Date: Mon, 13 Oct 2014 10:05:12 +0200
Message-ID: <1413187513-11178-2-git-send-email-frans.klaver@xsens.com>
References: <1413187513-11178-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413187513-11178-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

Signed-off-by: Ren=C3=A9 Moll <linux@r-moll.nl>
Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>
Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/Kconfig            |  10 +
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/ltc2952-poweroff.c | 324 +++++++++++++++++++++++++=
++++++++
 3 files changed, 335 insertions(+)
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
index 0000000..d194312
--- /dev/null
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -0,0 +1,324 @@
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
+ * Its function is to determine when a external shutdown is triggered =
and react
+ * by properly shutting down the system.
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
+ *     Input active indicates the shutdown trigger. If its state rever=
ts to
+ *     inactive within the timeout defined by trigger_delay, the syste=
m won't
+ *     be shut down. If no pin is assigned to this input the driver wi=
ll start
+ *     the watchdog immediately and only a power off event will powero=
ff the
+ *     ltc2952
+ *
+ * - watchdog (output)
+ *     Once a shutdown is triggered, the driver will toggle this signa=
l, with
+ *     an internal (wde_interval) to stall the hardware shut down.
+ *
+ * - poweroff (output)
+ *     The last action during shutdown is triggering this signalling, =
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
+#include <linux/platform_device.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/reboot.h>
+
+#define WDE_TIMEOUT ktime_set(0, 300L*1E6L)
+#define TRIGGER_TIMEOUT ktime_set(2, 500L*1E6L)
+
+struct ltc2952_poweroff {
+	struct hrtimer timer_trigger;
+	struct hrtimer timer_wde;
+
+	ktime_t trigger_delay;
+	ktime_t wde_interval;
+
+	struct device *dev;
+
+	struct gpio_desc *gpio_trigger;
+	struct gpio_desc *gpio_watchdog;
+	struct gpio_desc *gpio_poweroff;
+
+	bool kernel_panic;
+	struct notifier_block panic_notifier;
+};
+#define to_ltc2952(p, m) container_of(p, struct ltc2952_poweroff, m)
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
+	struct ltc2952_poweroff *data =3D to_ltc2952(timer, timer_wde);
+
+	if (data->kernel_panic)
+		return HRTIMER_NORESTART;
+
+	state =3D gpiod_get_value(data->gpio_watchdog);
+	gpiod_set_value(data->gpio_watchdog, !state);
+
+	now =3D hrtimer_cb_get_time(timer);
+	hrtimer_forward(timer, now, data->wde_interval);
+
+	return HRTIMER_RESTART;
+}
+
+static void ltc2952_poweroff_start_wde(struct ltc2952_poweroff *data)
+{
+	if (hrtimer_start(&data->timer_wde,
+			  data->wde_interval, HRTIMER_MODE_REL)) {
+		/*
+		 * The device will not toggle the watchdog reset,
+		 * thus shut down is only safe if the PowerPath controller
+		 * has a long enough time-off before triggering a hardware
+		 * power-off.
+		 *
+		 * Only mention the error, as the system will power-off anyway
+		 */
+		dev_err(data->dev, "unable to start the watchdog timer\n");
+	}
+}
+
+static enum hrtimer_restart ltc2952_poweroff_timer_trigger(struct hrti=
mer *t)
+{
+	struct ltc2952_poweroff *data =3D to_ltc2952(t, timer_trigger);
+
+	dev_info(data->dev, "executing shutdown\n");
+	ltc2952_poweroff_start_wde(data);
+	orderly_poweroff(true);
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * ltc2952_poweroff_handler - Interrupt handler
+ *
+ * Activate or deactive the shutdown timeout, based on the value of th=
e trigger
+ * gpio. If the button is pressed for long enough, the shutdown timer =
fires and
+ * the system is actually shut down.
+ *
+ * @irq: IRQ number
+ * @dev_id: pointer to the main data structure
+ */
+static irqreturn_t ltc2952_poweroff_handler(int irq, void *dev_id)
+{
+	struct ltc2952_poweroff *data =3D dev_id;
+
+	if (data->kernel_panic || hrtimer_active(&data->timer_wde))
+		/* we're either panicking, or already shutting down */
+		return IRQ_HANDLED;
+
+	if (gpiod_get_value(data->gpio_trigger)) {
+		/* button pressed */
+		if (hrtimer_start(&data->timer_trigger, data->trigger_delay,
+				  HRTIMER_MODE_REL))
+			dev_err(data->dev, "unable to start the wait timer\n");
+	} else {
+		/* button released */
+		hrtimer_cancel(&data->timer_trigger);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ltc2952_poweroff_init(struct platform_device *pdev)
+{
+	struct ltc2952_poweroff *data =3D platform_get_drvdata(pdev);
+
+	data->wde_interval =3D WDE_TIMEOUT;
+	data->trigger_delay =3D TRIGGER_TIMEOUT;
+
+	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL)=
;
+	data->timer_trigger.function =3D ltc2952_poweroff_timer_trigger;
+
+	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->timer_wde.function =3D ltc2952_poweroff_timer_wde;
+
+	data->gpio_watchdog =3D devm_gpiod_get(&pdev->dev, "watchdog",
+					     GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpio_watchdog)) {
+		dev_err(&pdev->dev, "unable to claim watchdog-gpio\n");
+		return PTR_ERR(data->gpio_watchdog);
+	}
+
+	data->gpio_poweroff =3D devm_gpiod_get(&pdev->dev, "poweroff",
+					     GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpio_poweroff)) {
+		dev_err(&pdev->dev, "unable to claim poweroff-gpio\n");
+		return PTR_ERR(data->gpio_poweroff);
+	}
+
+	data->gpio_trigger =3D devm_gpiod_get(&pdev->dev, "trigger", GPIOD_IN=
);
+	if (IS_ERR(data->gpio_trigger)) {
+		/*
+		 * It's not a problem if the trigger gpio isn't available, but
+		 * it is worth a warning its use was defined in the device
+		 * tree.
+		 */
+		if (PTR_ERR(data->gpio_trigger) !=3D -ENOENT)
+			dev_warn(&pdev->dev, "unable to claim trigger-gpio\n");
+		data->gpio_trigger =3D NULL;
+	}
+
+	if (devm_request_irq(&pdev->dev,
+			     gpiod_to_irq(data->gpio_trigger),
+			     ltc2952_poweroff_handler,
+			     (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+			     KBUILD_MODNAME, data)) {
+		/*
+		 * No trigger input was defined, claiming the gpio failed, we
+		 * couldn't map to an irq, or we couldn't register the
+		 * interrupt handler. None of these should be a real problem,
+		 * but all of them disqualify the push button from controlling
+		 * the power.
+		 *
+		 * It is therefore important to note that if the ltc2952 detects
+		 * a button press for long enough, it will still start its own
+		 * powerdown window and cut the power on us if we don't start
+		 * the watchdog trigger.
+		 */
+		if (data->gpio_trigger) {
+			dev_warn(&pdev->dev,
+				 "unable to configure the trigger interrupt\n");
+			devm_gpiod_put(&pdev->dev, data->gpio_trigger);
+			data->gpio_trigger =3D NULL;
+		}
+
+		dev_info(&pdev->dev, "power down trigger input is not used\n");
+		ltc2952_poweroff_start_wde(data);
+	}
+
+	return 0;
+}
+
+static int ltc2952_poweroff_notify_panic(struct notifier_block *nb,
+					 unsigned long code,
+					 void *unused)
+{
+	struct ltc2952_poweroff *data =3D to_ltc2952(nb, panic_notifier);
+
+	data->kernel_panic =3D true;
+	return NOTIFY_DONE;
+}
+
+/* We need a global pointer here */
+static struct ltc2952_poweroff *ltc2952_data;
+
+static void ltc2952_poweroff_poweroff(void)
+{
+	gpiod_set_value(ltc2952_data->gpio_poweroff, 1);
+}
+
+static int ltc2952_poweroff_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct ltc2952_poweroff *data;
+
+	if (ltc2952_data) {
+		dev_err(&pdev->dev, "already probed");
+		return -ENODEV;
+	}
+
+	if (pm_power_off) {
+		dev_err(&pdev->dev, "pm_power_off already registered");
+		return -EBUSY;
+	}
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, data);
+
+	ret =3D ltc2952_poweroff_init(pdev);
+	if (ret)
+		return ret;
+
+	pm_power_off =3D ltc2952_poweroff_poweroff;
+	ltc2952_data =3D data;
+
+	data->panic_notifier.notifier_call =3D ltc2952_poweroff_notify_panic;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &data->panic_notifier);
+	dev_info(&pdev->dev, "probe successful\n");
+	return 0;
+}
+
+static int ltc2952_poweroff_remove(struct platform_device *pdev)
+{
+	struct ltc2952_poweroff *data =3D platform_get_drvdata(pdev);
+
+	pm_power_off =3D NULL;
+	hrtimer_cancel(&data->timer_wde);
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &data->panic_notifier);
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
+		.name =3D KBUILD_MODNAME,
+		.of_match_table =3D of_ltc2952_poweroff_match,
+	},
+};
+module_platform_driver(ltc2952_poweroff_driver);
+
+MODULE_AUTHOR("Ren=C3=A9 Moll <linux@r-moll.nl>");
+MODULE_AUTHOR("Frans Klaver <frans.klaver@xsens.com>");
+MODULE_AUTHOR("Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>");
+MODULE_DESCRIPTION("LTC PowerPath power-off driver");
--=20
2.1.0
