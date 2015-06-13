From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/4] mfd: axp20x: Add a cell for the usb power_supply part of the axp20x PMICs
Date: Sat, 13 Jun 2015 18:09:07 +0200
Message-ID: <1434211748-25572-4-git-send-email-hdegoede@redhat.com>
References: <1434211748-25572-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434211748-25572-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a cell for the usb power_supply part of the axp20x PMICs.

Note that this cell is only for the usb power_supply part and not the
ac-power / battery-charger / rtc-backup-bat-charger bits.

Depending on the board each of those must be enabled / disabled separat=
ely
in devicetree as most boards do not use all 4. So in dt each one needs =
its
own child-node of the axp20x node. Another reason for using separate ch=
ild
nodes for each is so that other devicetree nodes can have a power-suppl=
y
property with a phandle referencing a node representing a single
power-supply.

The decision to use a separate devicetree node for each is reflected on
the kernel side by each getting its own mfd-cell / platform_device and
platform-driver.

Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Use DEFINE_RES_IRQ_NAMED
-Change indentation of axp20x_cells initializers to avoid line wrapping
---
 drivers/mfd/axp20x.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index f9a3c2d..ca4a604 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -113,6 +113,13 @@ static struct resource axp20x_pek_resources[] =3D =
{
 	},
 };
=20
+static struct resource axp20x_usb_power_supply_resources[] =3D {
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
+};
+
 static struct resource axp22x_pek_resources[] =3D {
 	{
 		.name   =3D "PEK_DBR",
@@ -363,11 +370,16 @@ static const struct regmap_irq_chip axp288_regmap=
_irq_chip =3D {
=20
 static struct mfd_cell axp20x_cells[] =3D {
 	{
-		.name			=3D "axp20x-pek",
-		.num_resources		=3D ARRAY_SIZE(axp20x_pek_resources),
-		.resources		=3D axp20x_pek_resources,
+		.name		=3D "axp20x-pek",
+		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
+		.resources	=3D axp20x_pek_resources,
 	}, {
-		.name			=3D "axp20x-regulator",
+		.name		=3D "axp20x-regulator",
+	}, {
+		.name		=3D "axp20x-usb-power-supply",
+		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
+		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resources),
+		.resources	=3D axp20x_usb_power_supply_resources,
 	},
 };
=20
--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
