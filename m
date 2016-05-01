From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: [PATCH v2 3/6] mfd: axp20x: Add a cell for the ac power_supply part of the axp20x PMICs
Date: Sun,  1 May 2016 10:57:24 +0200
Message-ID: <1462093047-7885-4-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462093047-7885-1-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: degoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

As a counterpart to the usb power_supply cell, this commit adds an AC
power_supply cell to the axp20x driver.

Still missing are the RTC backup battery and the main battery charger
cells.

Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
---
 drivers/mfd/axp20x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index a57d6e9..9351c0e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -178,6 +178,12 @@ static struct resource axp288_power_button_resources[] = {
 	},
 };
 
+static struct resource axp20x_ac_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
+};
+
 static struct resource axp288_fuel_gauge_resources[] = {
 	{
 		.start = AXP288_IRQ_QWBTU,
@@ -440,6 +446,11 @@ static struct mfd_cell axp20x_cells[] = {
 		.of_compatible	= "x-powers,axp202-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
 		.resources	= axp20x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp202-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 };
 
-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
