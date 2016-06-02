From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/4] mfd: axp20x: Add axp20x-usb-power-supply for axp22x pmics
Date: Thu,  2 Jun 2016 19:18:55 +0200
Message-ID: <1464887936-17020-3-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add axp20x-usb-power-supply for axp22x pmics.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Change compatible string for axp22x usb-power-supply cell to match v2 of:
 "power: axp20x_usb: Add support for usb power-supply on axp22x pmics"
---
 drivers/mfd/axp20x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ca04361..6364dab 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -160,6 +160,11 @@ static struct resource axp20x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
 };
 
+static struct resource axp22x_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+};
+
 static struct resource axp22x_pek_resources[] = {
 	{
 		.name   = "PEK_DBR",
@@ -527,6 +532,11 @@ static struct mfd_cell axp22x_cells[] = {
 		.resources		= axp22x_pek_resources,
 	}, {
 		.name			= "axp20x-regulator",
+	}, {
+		.name		= "axp20x-usb-power-supply",
+		.of_compatible	= "x-powers,axp221-usb-power-supply",
+		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
+		.resources	= axp22x_usb_power_supply_resources,
 	},
 };
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
