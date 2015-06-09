From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Tue,  9 Jun 2015 23:37:55 +0200
Message-ID: <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBT5Z3WVQKGQEWGS2DSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a cell for the usb power_supply part of the axp20x PMICs.

Note that this cell is only for the usb power_supply part and not the
ac-power / battery-charger / rtc-backup-bat-charger bits.

Depending on the board each of those must be enabled / disabled separately
in devicetree as most boards do not use all 4. So in dt each one needs its
own child-node of the axp20x node. Another reason for using separate child
nodes for each is so that other devicetree nodes can have a power-supply
property with a phandle referencing a node representing a single
power-supply.

The decision to use a separate devicetree node for each is reflected on
the kernel side by each getting its own mfd-cell / platform_device and
platform-driver.

Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/axp20x.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6ffbc11..47ce233 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -113,6 +113,30 @@ static struct resource axp20x_pek_resources[] =3D {
 	},
 };
=20
+static struct resource axp20x_usb_power_supply_resources[] =3D {
+	{
+		.name	=3D "VBUS_PLUGIN",
+		.start	=3D AXP20X_IRQ_VBUS_PLUGIN,
+		.end	=3D AXP20X_IRQ_VBUS_PLUGIN,
+		.flags	=3D IORESOURCE_IRQ,
+	}, {
+		.name	=3D "VBUS_REMOVAL",
+		.start	=3D AXP20X_IRQ_VBUS_REMOVAL,
+		.end	=3D AXP20X_IRQ_VBUS_REMOVAL,
+		.flags	=3D IORESOURCE_IRQ,
+	}, {
+		.name	=3D "VBUS_VALID",
+		.start	=3D AXP20X_IRQ_VBUS_VALID,
+		.end	=3D AXP20X_IRQ_VBUS_VALID,
+		.flags	=3D IORESOURCE_IRQ,
+	}, {
+		.name	=3D "VBUS_NOT_VALID",
+		.start	=3D AXP20X_IRQ_VBUS_NOT_VALID,
+		.end	=3D AXP20X_IRQ_VBUS_NOT_VALID,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
 static struct resource axp22x_pek_resources[] =3D {
 	{
 		.name   =3D "PEK_DBR",
@@ -165,7 +189,7 @@ static const struct regmap_config axp20x_regmap_config =
=3D {
 	.val_bits	=3D 8,
 	.wr_table	=3D &axp20x_writeable_table,
 	.volatile_table	=3D &axp20x_volatile_table,
-	.max_register	=3D AXP20X_FG_RES,
+	.max_register	=3D AXP20X_OCV(15),
 	.cache_type	=3D REGCACHE_RBTREE,
 };
=20
@@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] =3D {
 		.resources		=3D axp20x_pek_resources,
 	}, {
 		.name			=3D "axp20x-regulator",
+	}, {
+		.name			=3D "axp20x-usb-power-supply",
+		.of_compatible		=3D "x-powers,axp202-usb-power-supply",
+		.num_resources		=3D
+				ARRAY_SIZE(axp20x_usb_power_supply_resources),
+		.resources		=3D axp20x_usb_power_supply_resources,
 	},
 };
=20
--=20
2.3.6

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
