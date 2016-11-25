From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 04/10] power: supply: axp20x_usb_power: add 100mA max current limit for AXP223
Date: Fri, 25 Nov 2016 10:09:15 +0100
Message-ID: <20161125090921.23138-5-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP223 shares most of its behaviour with the AXP221 PMIC
but allows the VBUS power supply max current to be set to 100mA (like
the AXP209 PMIC).

This basically adds a new compatible to the VBUS power supply driver and
adds a check on the compatible when setting current max limit.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/power/supply/axp20x_usb_power.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 638cb52..6d5d451 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -88,11 +88,10 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
 		case AXP20X_VBUC_CLIMIT_100mA:
-			if (power->axp20x_id == AXP202_ID) {
-				val->intval = 100000;
-			} else {
+			if (power->axp20x_id == AXP221_ID)
 				val->intval = -1; /* No 100mA limit */
-			}
+			else
+				val->intval = 100000;
 			break;
 		case AXP20X_VBUC_CLIMIT_500mA:
 			val->intval = 500000;
@@ -268,6 +267,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp221-usb-power-supply",
 		.data = (void *)AXP221_ID,
+	}, {
+		.compatible = "x-powers,axp223-usb-power-supply",
+		.data = (void *)AXP223_ID,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
@@ -324,7 +326,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
-	} else if (power->axp20x_id == AXP221_ID) {
+	} else if (power->axp20x_id == AXP221_ID ||
+		   power->axp20x_id == AXP223_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
 	} else {
-- 
2.9.3
