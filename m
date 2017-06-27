From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/3] power: wm831x_power: Support USB charger current limit management
Date: Tue, 27 Jun 2017 15:49:35 +0800
Message-ID: <86f990c6212d1d90a36e937736c01a7b131f6fcb.1498548022.git.baolin.wang@linaro.org>
References: <54d4a3ae584900a74e04b5cd27157dced44fdfef.1498548022.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54d4a3ae584900a74e04b5cd27157dced44fdfef.1498548022.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1498548022.git.baolin.wang@linaro.org>
References: <cover.1498548022.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Integrate with the newly added USB charger interface to limit the current
we draw from the USB input based on the input device configuration
identified by the USB stack, allowing us to charge more quickly from high
current inputs without drawing more current than specified from others.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/wm831x_power.c |   61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 7082301..3e3480708 100644
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
@@ -607,6 +647,22 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		}
 	}
 
+	power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev,
+						     "usb-phy", 0);
+	if (IS_ERR(power->usb_phy)) {
+		ret = PTR_ERR(power->usb_phy);
+		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
+		goto err_bat_irq;
+	}
+
+	power->usb_notify.notifier_call = wm831x_usb_limit_change;
+	ret = usb_register_notifier(power->usb_phy,
+				    &power->usb_notify);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		goto err_bat_irq;
+	}
+
 	return ret;
 
 err_bat_irq:
@@ -637,6 +693,11 @@ static int wm831x_power_remove(struct platform_device *pdev)
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
