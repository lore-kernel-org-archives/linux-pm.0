From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 3/3] power: wm831x_power: Support USB charger current limit management
Date: Tue, 15 Aug 2017 19:07:55 +0800
Message-ID: <485f6d343945d0b075602456c9393f8e6c065e91.1502794832.git.baolin.wang@linaro.org>
References: <cover.1502794826.git.baolin.wang@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1502794826.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1502794826.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1502794826.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: jun.li-3arQi8VN3Tc@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, neilb-IBi9RG/b67k@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Integrate with the newly added USB charger interface to limit the current
we draw from the USB input based on the input device configuration
identified by the USB stack, allowing us to charge more quickly from high
current inputs without drawing more current than specified from others.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
 drivers/power/supply/wm831x_power.c              |   72 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/wm831x.txt b/Documentation/devicetree/bindings/mfd/wm831x.txt
index 9f8b743..5057094 100644
--- a/Documentation/devicetree/bindings/mfd/wm831x.txt
+++ b/Documentation/devicetree/bindings/mfd/wm831x.txt
@@ -31,6 +31,7 @@ Required properties:
     ../interrupt-controller/interrupts.txt
 
 Optional sub-nodes:
+  - phys : Contains a phandle to the USB PHY.
   - regulators : Contains sub-nodes for each of the regulators supplied by
     the device. The regulators are bound using their names listed below:
 
diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 7082301..927050d 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/usb/phy.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/auxadc.h>
@@ -31,6 +32,8 @@ struct wm831x_power {
 	char usb_name[20];
 	char battery_name[20];
 	bool have_battery;
+	struct usb_phy *usb_phy;
+	struct notifier_block usb_notify;
 };
 
 static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
@@ -125,6 +128,43 @@ static int wm831x_usb_get_prop(struct power_supply *psy,
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
@@ -607,6 +647,33 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		}
 	}
 
+	power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "phys", 0);
+	ret = PTR_ERR_OR_ZERO(power->usb_phy);
+
+	switch (ret) {
+	case 0:
+		power->usb_notify.notifier_call = wm831x_usb_limit_change;
+		ret = usb_register_notifier(power->usb_phy, &power->usb_notify);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register notifier: %d\n",
+				ret);
+			goto err_bat_irq;
+		}
+		break;
+	case -EINVAL:
+	case -ENODEV:
+		/* ignore missing usb-phy, it's optional */
+		power->usb_phy = NULL;
+		ret = 0;
+		break;
+	default:
+		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
+		/* fall-through */
+	case -EPROBE_DEFER:
+		goto err_bat_irq;
+		break;
+	}
+
 	return ret;
 
 err_bat_irq:
@@ -637,6 +704,11 @@ static int wm831x_power_remove(struct platform_device *pdev)
 	struct wm831x *wm831x = wm831x_power->wm831x;
 	int irq, i;
 
+	if (wm831x_power->usb_phy) {
+		usb_unregister_notifier(wm831x_power->usb_phy,
+					&wm831x_power->usb_notify);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
 		irq = wm831x_irq(wm831x, 
 				 platform_get_irq_byname(pdev,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
