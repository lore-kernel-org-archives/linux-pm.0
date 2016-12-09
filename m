From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 01/11] power: supply: axp20x_usb_power: use of_device_id
 data field instead of device_is_compatible
Date: Fri,  9 Dec 2016 12:04:09 +0100
Message-ID: <20161209110419.28981-2-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This replaces calls to of_device_is_compatible to check data field of
of_device_id matched when probing the driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/power/supply/axp20x_usb_power.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 6af6feb..8985646 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
@@ -45,6 +46,7 @@ struct axp20x_usb_power {
 	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
+	int axp20x_id;
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -86,8 +88,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
 		case AXP20X_VBUC_CLIMIT_100mA:
-			if (of_device_is_compatible(power->np,
-					"x-powers,axp202-usb-power-supply")) {
+			if (power->axp20x_id == AXP202_ID) {
 				val->intval = 100000;
 			} else {
 				val->intval = -1; /* No 100mA limit */
@@ -130,8 +131,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (of_device_is_compatible(power->np,
-				"x-powers,axp202-usb-power-supply")) {
+		if (power->axp20x_id == AXP202_ID) {
 			ret = regmap_read(power->regmap,
 					  AXP20X_USB_OTG_STATUS, &v);
 			if (ret)
@@ -214,11 +214,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
+	power->axp20x_id = (int)of_device_get_match_data(&pdev->dev);
+
 	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
 
-	if (of_device_is_compatible(power->np,
-			"x-powers,axp202-usb-power-supply")) {
+	if (power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
@@ -235,8 +236,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
-	} else if (of_device_is_compatible(power->np,
-			"x-powers,axp221-usb-power-supply")) {
+	} else if (power->axp20x_id == AXP221_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
 	} else {
@@ -273,9 +273,13 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id axp20x_usb_power_match[] = {
-	{ .compatible = "x-powers,axp202-usb-power-supply" },
-	{ .compatible = "x-powers,axp221-usb-power-supply" },
-	{ }
+	{
+		.compatible = "x-powers,axp202-usb-power-supply",
+		.data = (void *)AXP202_ID,
+	}, {
+		.compatible = "x-powers,axp221-usb-power-supply",
+		.data = (void *)AXP221_ID,
+	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
 
-- 
2.9.3
