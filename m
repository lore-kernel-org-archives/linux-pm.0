From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 06/13] power: reset: ltc2952: remove global variable poweroff_panic
Date: Wed, 22 Oct 2014 16:31:03 +0200
Message-ID: <1413988270-28092-7-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As per Documentation/CodingStyle ch.4, we should keep global variables
to a mininum. Move the panic state into the driver data, regardless of
whether panic is a system state or not.

This removes the need for the custom _init and _exit functions, so
replace them with a call to the module_platform_driver() macro.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 57 +++++++++++++-------------=
--------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/res=
et/ltc2952-poweroff.c
index 9d493b5..bc8d228 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -75,6 +75,9 @@ struct ltc2952_poweroff {
 	struct gpio_desc *gpio_trigger;
 	struct gpio_desc *gpio_watchdog;
 	struct gpio_desc *gpio_kill;
+
+	bool kernel_panic;
+	struct notifier_block panic_notifier;
 };
=20
 #define to_ltc2952(p, m) container_of(p, struct ltc2952_poweroff, m)
@@ -84,7 +87,6 @@ struct ltc2952_poweroff {
  * remove it entirely once we don't need the global state anymore.
  */
 static struct ltc2952_poweroff *ltc2952_data;
-static int ltc2952_poweroff_panic;
=20
 /**
  * ltc2952_poweroff_timer_wde - Timer callback
@@ -102,7 +104,7 @@ static enum hrtimer_restart ltc2952_poweroff_timer_=
wde(struct hrtimer *timer)
 	unsigned long overruns;
 	struct ltc2952_poweroff *data =3D to_ltc2952(timer, timer_wde);
=20
-	if (ltc2952_poweroff_panic)
+	if (data->kernel_panic)
 		return HRTIMER_NORESTART;
=20
 	state =3D gpiod_get_value(data->gpio_watchdog);
@@ -154,7 +156,7 @@ static irqreturn_t ltc2952_poweroff_handler(int irq=
, void *dev_id)
 	int ret;
 	struct ltc2952_poweroff *data =3D dev_id;
=20
-	if (ltc2952_poweroff_panic)
+	if (data->kernel_panic)
 		goto irq_ok;
=20
 	if (hrtimer_active(&data->timer_wde)) {
@@ -255,6 +257,15 @@ static int ltc2952_poweroff_init(struct platform_d=
evice *pdev)
 	return 0;
 }
=20
+static int ltc2952_poweroff_notify_panic(struct notifier_block *nb,
+					 unsigned long code, void *unused)
+{
+	struct ltc2952_poweroff *data =3D to_ltc2952(nb, panic_notifier);
+
+	data->kernel_panic =3D true;
+	return NOTIFY_DONE;
+}
+
 static int ltc2952_poweroff_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -280,6 +291,9 @@ static int ltc2952_poweroff_probe(struct platform_d=
evice *pdev)
 	ltc2952_data =3D data;
 	pm_power_off =3D &ltc2952_poweroff_kill;
=20
+	data->panic_notifier.notifier_call =3D ltc2952_poweroff_notify_panic;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &data->panic_notifier);
 	dev_info(&pdev->dev, "probe successful\n");
=20
 	return 0;
@@ -287,8 +301,11 @@ static int ltc2952_poweroff_probe(struct platform_=
device *pdev)
=20
 static int ltc2952_poweroff_remove(struct platform_device *pdev)
 {
-	pm_power_off =3D NULL;
+	struct ltc2952_poweroff *data =3D platform_get_drvdata(pdev);
=20
+	pm_power_off =3D NULL;
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &data->panic_notifier);
 	return 0;
 }
=20
@@ -310,37 +327,7 @@ static struct platform_driver ltc2952_poweroff_dri=
ver =3D {
 	.resume =3D ltc2952_poweroff_resume,
 };
=20
-static int ltc2952_poweroff_notify_panic(struct notifier_block *nb,
-	unsigned long code, void *unused)
-{
-	ltc2952_poweroff_panic =3D 1;
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block ltc2952_poweroff_panic_nb =3D {
-	.notifier_call =3D ltc2952_poweroff_notify_panic,
-};
-
-static int __init ltc2952_poweroff_platform_init(void)
-{
-	ltc2952_poweroff_panic =3D 0;
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-		&ltc2952_poweroff_panic_nb);
-
-	return platform_driver_register(&ltc2952_poweroff_driver);
-}
-
-static void __exit ltc2952_poweroff_platform_exit(void)
-{
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-		&ltc2952_poweroff_panic_nb);
-
-	platform_driver_unregister(&ltc2952_poweroff_driver);
-}
-
-module_init(ltc2952_poweroff_platform_init);
-module_exit(ltc2952_poweroff_platform_exit);
+module_platform_driver(ltc2952_poweroff_driver);
=20
 MODULE_AUTHOR("Ren=E9 Moll <rene.moll@xsens.com>");
 MODULE_DESCRIPTION("LTC PowerPath power-off driver");
--=20
2.1.0
