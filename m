From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v15 4/4] power: wm831x_power: Support USB charger current limit management
Date: Fri,  1 Jul 2016 14:05:48 +0800
Message-ID: <8d4738ad034a340a5c4e2ead4c09d49585c06ac7.1467352530.git.baolin.wang@linaro.org>
References: <cover.1467352530.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1467352530.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1467352530.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1467352530.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Integrate with the newly added USB charger interface to limit the current
we draw from the USB input based on the input device configuration
identified by the USB stack, allowing us to charge more quickly from high
current inputs without drawing more current than specified from others.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/power/wm831x_power.c     |   69 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/wm831x/pdata.h |    3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index 7082301..cef1812 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/usb/charger.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/auxadc.h>
@@ -31,6 +32,8 @@ struct wm831x_power {
 	char usb_name[20];
 	char battery_name[20];
 	bool have_battery;
+	struct usb_charger *usb_charger;
+	struct notifier_block usb_notify;
 };
 
 static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
@@ -125,6 +128,43 @@ static enum power_supply_property wm831x_usb_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
+/* In milliamps */
+static const unsigned int wm831x_usb_limits[] = {
+	0,
+	2,
+	100,
+	500,
+	900,
+	1500,
+	1800,
+	550,
+};
+
+static int wm831x_usb_limit_change(struct notifier_block *nb,
+				   unsigned long limit, void *data)
+{
+	struct wm831x_power *wm831x_power = container_of(nb,
+							 struct wm831x_power,
+							 usb_notify);
+	unsigned int i, best;
+
+	/* Find the highest supported limit */
+	best = 0;
+	for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
+		if (limit >= wm831x_usb_limits[i] &&
+		    wm831x_usb_limits[best] < wm831x_usb_limits[i])
+			best = i;
+	}
+
+	dev_dbg(wm831x_power->wm831x->dev,
+		"Limiting USB current to %umA", wm831x_usb_limits[best]);
+
+	wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
+		        WM831X_USB_ILIM_MASK, best);
+
+	return 0;
+}
+
 /*********************************************************************
  *		Battery properties
  *********************************************************************/
@@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
+		power->usb_charger =
+			usb_charger_find_by_name(wm831x_pdata->usb_gadget);
+		if (IS_ERR(power->usb_charger)) {
+			ret = PTR_ERR(power->usb_charger);
+			dev_err(&pdev->dev,
+				"Failed to find USB gadget: %d\n", ret);
+			goto err_bat_irq;
+		}
+
+		power->usb_notify.notifier_call = wm831x_usb_limit_change;
+
+		ret = usb_charger_register_notify(power->usb_charger,
+						  &power->usb_notify);
+		if (ret != 0) {
+			dev_err(&pdev->dev,
+				"Failed to register notifier: %d\n", ret);
+			goto err_usb_charger;
+		}
+	}
+
 	return ret;
 
+err_usb_charger:
+	/* put_device on charger */
 err_bat_irq:
 	--i;
 	for (; i >= 0; i--) {
@@ -637,6 +700,12 @@ static int wm831x_power_remove(struct platform_device *pdev)
 	struct wm831x *wm831x = wm831x_power->wm831x;
 	int irq, i;
 
+	if (wm831x_power->usb_charger) {
+		usb_charger_unregister_notify(wm831x_power->usb_charger,
+					      &wm831x_power->usb_notify);
+		/* Free charger */
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
 		irq = wm831x_irq(wm831x, 
 				 platform_get_irq_byname(pdev,
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index dcc9631..5af8399 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -126,6 +126,9 @@ struct wm831x_pdata {
 	/** The driver should initiate a power off sequence during shutdown */
 	bool soft_shutdown;
 
+	/** dev_name of USB charger gadget to integrate with */
+	const char *usb_gadget;
+
 	int irq_base;
 	int gpio_base;
 	int gpio_defaults[WM831X_GPIO_NUM];
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
