From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] mfd: axp20x: Add a cell for the usb power_supply
 part of the axp20x PMICs
Date: Wed, 12 Aug 2015 10:29:00 +0100
Message-ID: <20150812092900.GC18282@x1>
References: <1439049521-30766-1-git-send-email-hdegoede@redhat.com>
 <1439049521-30766-2-git-send-email-hdegoede@redhat.com>
 <20150811141811.GM18282@x1>
 <55CB05AD.1030707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38409 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932752AbbHLJ3G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 05:29:06 -0400
Received: by wicja10 with SMTP id ja10so19458981wic.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 02:29:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55CB05AD.1030707@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Wed, 12 Aug 2015, Hans de Goede wrote:

> Hi,
>=20
> On 11-08-15 16:18, Lee Jones wrote:
> >On Sat, 08 Aug 2015, Hans de Goede wrote:
> >
> >>Add a cell for the usb power_supply part of the axp20x PMICs.
> >>
> >>Note that this cell is only for the usb power_supply part and not t=
he
> >>ac-power / battery-charger / rtc-backup-bat-charger bits.
> >>
> >>Depending on the board each of those must be enabled / disabled sep=
arately
> >>in devicetree as most boards do not use all 4. So in dt each one ne=
eds its
> >>own child-node of the axp20x node. Another reason for using separat=
e child
> >>nodes for each is so that other devicetree nodes can have a power-s=
upply
> >>property with a phandle referencing a node representing a single
> >>power-supply.
> >>
> >>The decision to use a separate devicetree node for each is reflecte=
d on
> >>the kernel side by each getting its own mfd-cell / platform_device =
and
> >>platform-driver.
> >>
> >>Note this commit also makes some whitespace changes to the intializ=
ation
> >>of existing cells in axp20x_cells, these are pure whitespace change=
s,
> >>functionally nothing changes.
> >>
> >>Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> >>Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>Acked-by: Lee Jones <lee.jones@linaro.org>
> >>---
> >>Changes in v2:
> >>-Use DEFINE_RES_IRQ_NAMED
> >>-Change indentation of axp20x_cells initializers to avoid line wrap=
ping
> >>Changes in v3:
> >>-Improve commit message
> >>-Add Bruno's S-o-b
> >>---
> >>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> >Applied, thanks.
>=20
> Great, but I'm not seeing this in:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=3Dfor=
-mfd-next

Well it does usually take me a day or two push my local branch out,
however in this case I had actually dropped a ball somewhere.  I've
been through my backlog of 'applied' patches and these two are the
only ones I failed to pick.  I have now, re-picked, re-applied and
pushed the branch out.  Let me know if something is still not right.

Sorry for the inconvenience.

> >>diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >>index d9f2f96..3f576b7 100644
> >>--- a/drivers/mfd/axp20x.c
> >>+++ b/drivers/mfd/axp20x.c
> >>@@ -140,6 +140,13 @@ static struct resource axp20x_pek_resources[] =
=3D {
> >>  	},
> >>  };
> >>
> >>+static struct resource axp20x_usb_power_supply_resources[] =3D {
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
> >>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID")=
,
> >>+};
> >>+
> >>  static struct resource axp22x_pek_resources[] =3D {
> >>  	{
> >>  		.name   =3D "PEK_DBR",
> >>@@ -432,11 +439,16 @@ static const struct regmap_irq_chip axp288_re=
gmap_irq_chip =3D {
> >>
> >>  static struct mfd_cell axp20x_cells[] =3D {
> >>  	{
> >>-		.name			=3D "axp20x-pek",
> >>-		.num_resources		=3D ARRAY_SIZE(axp20x_pek_resources),
> >>-		.resources		=3D axp20x_pek_resources,
> >>+		.name		=3D "axp20x-pek",
> >>+		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> >>+		.resources	=3D axp20x_pek_resources,
> >>  	}, {
> >>-		.name			=3D "axp20x-regulator",
> >>+		.name		=3D "axp20x-regulator",
> >>+	}, {
> >>+		.name		=3D "axp20x-usb-power-supply",
> >>+		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
> >>+		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resources)=
,
> >>+		.resources	=3D axp20x_usb_power_supply_resources,
> >>  	},
> >>  };
> >>
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
