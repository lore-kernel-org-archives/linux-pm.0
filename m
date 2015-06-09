From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/8] phy-sun4i-usb: Add support for monitoring vbus via a power-supply
Date: Tue,  9 Jun 2015 23:37:58 +0200
Message-ID: <1433885881-19809-6-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On some boards there is no vbus_det gpio pin, instead vbus-detection for
otg can be done via the pmic.

This commit adds support for monitoring vbus_det via the power_supply
exported by the pmic, enabling support for otg on these boards.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 drivers/phy/phy-sun4i-usb.c                        | 68 +++++++++++++++++++---
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 5f48979..0cebf74 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -29,6 +29,7 @@ Required properties:
 Optional properties:
 - usb0_id_det-gpios : gpio phandle for reading the otg id pin value
 - usb0_vbus_det-gpios : gpio phandle for detecting the presence of usb0 vbus
+- usb0_vbus_power-supply: power-supply phandle for usb0 vbus presence detect
 - usb0_vbus-supply : regulator phandle for controller usb0 vbus
 - usb1_vbus-supply : regulator phandle for controller usb1 vbus
 - usb2_vbus-supply : regulator phandle for controller usb2 vbus
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 4981041..85bb215 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-sun4i-usb.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/workqueue.h>
@@ -111,6 +112,8 @@ struct sun4i_usb_phy_data {
 	bool phy0_poll;
 	struct gpio_desc *id_det_gpio;
 	struct gpio_desc *vbus_det_gpio;
+	struct power_supply *vbus_power_supply;
+	struct notifier_block vbus_power_nb;
 	int id_det_irq;
 	int vbus_det_irq;
 	int id_det;
@@ -355,6 +358,30 @@ static struct phy_ops sun4i_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int sun4i_usb_phy0_get_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	if (data->vbus_det_gpio)
+		return gpiod_get_value_cansleep(data->vbus_det_gpio);
+
+	if (data->vbus_power_supply) {
+		union power_supply_propval val;
+		int r;
+
+		r = power_supply_get_property(data->vbus_power_supply,
+					      POWER_SUPPLY_PROP_PRESENT, &val);
+		if (r == 0)
+			return val.intval;
+	}
+
+	/* Fallback: report vbus as high */
+	return 1;
+}
+
+static bool sun4i_usb_phy0_have_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	return data->vbus_det_gpio || data->vbus_power_supply;
+}
+
 static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 {
 	struct sun4i_usb_phy_data *data =
@@ -363,10 +390,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	int id_det, vbus_det, id_notify = 0, vbus_notify = 0;
 
 	id_det = gpiod_get_value_cansleep(data->id_det_gpio);
-	if (data->vbus_det_gpio)
-		vbus_det = gpiod_get_value_cansleep(data->vbus_det_gpio);
-	else
-		vbus_det = 1; /* Report vbus as high */
+	vbus_det = sun4i_usb_phy0_get_vbus_det(data);
 
 	mutex_lock(&phy0->mutex);
 
@@ -381,7 +405,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough for
 		 * the musb-ip to end the current device session.
 		 */
-		if (!data->vbus_det_gpio && id_det == 0) {
+		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 0) {
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(200);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 1);
@@ -408,7 +432,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough to
 		 * the musb-ip to end the current host session.
 		 */
-		if (!data->vbus_det_gpio && id_det == 1) {
+		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 1) {
 			mutex_lock(&phy0->mutex);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(1000);
@@ -436,6 +460,20 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
+				      unsigned long val, void *v)
+{
+	struct sun4i_usb_phy_data *data = 
+		container_of(nb, struct sun4i_usb_phy_data, vbus_power_nb);
+	struct power_supply *psy = v;
+
+	/* Properties on the vbus_power_supply changed, scan vbus_det */
+	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
+		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+
+	return NOTIFY_OK;
+}
+
 static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 					struct of_phandle_args *args)
 {
@@ -512,8 +550,24 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		data->vbus_det_gpio = NULL;
 	}
 
+	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
+		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
+						     "usb0_vbus_power-supply");
+		if (IS_ERR(data->vbus_power_supply))
+			return PTR_ERR(data->vbus_power_supply);
+
+		if (!data->vbus_power_supply)
+			return -EPROBE_DEFER;
+
+		data->vbus_power_nb.notifier_call = sun4i_usb_phy0_vbus_notify;
+		data->vbus_power_nb.priority = 0;
+		ret = power_supply_reg_notifier(&data->vbus_power_nb);
+		if (ret)
+			return ret;
+	}
+
 	/* vbus_det without id_det makes no sense, and is not supported */
-	if (data->vbus_det_gpio && !data->id_det_gpio) {
+	if (sun4i_usb_phy0_have_vbus_det(data) && !data->id_det_gpio) {
 		dev_err(dev, "usb0_id_det missing or invalid\n");
 		return -ENODEV;
 	}
-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
