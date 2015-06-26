From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/4] mfd: axp20x: Add a cell for the usb power_supply part of the axp20x PMICs
Date: Fri, 26 Jun 2015 12:59:16 +0200
Message-ID: <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbFZK70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Jun 2015 06:59:26 -0400
In-Reply-To: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

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

Note this commit also makes some whitespace changes to the intializatio=
n
of existing cells in axp20x_cells, these are pure whitespace changes,
functionally nothing changes.

Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use DEFINE_RES_IRQ_NAMED
-Change indentation of axp20x_cells initializers to avoid line wrapping
Changes in v3:
-Improve commit message
-Add Bruno's S-o-b
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

