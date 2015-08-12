From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] mfd: axp20x: Add a cell for the usb power_supply
 part of the axp20x PMICs
Date: Wed, 12 Aug 2015 11:26:25 +0100
Message-ID: <20150812102625.GE18282@x1>
References: <1439049521-30766-1-git-send-email-hdegoede@redhat.com>
 <1439049521-30766-2-git-send-email-hdegoede@redhat.com>
 <20150811141811.GM18282@x1>
 <55CB05AD.1030707@redhat.com>
 <20150812092900.GC18282@x1>
 <55CB1DDF.7000201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55CB1DDF.7000201-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Aug 2015, Hans de Goede wrote:

> Hi,
>=20
> On 12-08-15 11:29, Lee Jones wrote:
> >On Wed, 12 Aug 2015, Hans de Goede wrote:
> >
> >>Hi,
> >>
> >>On 11-08-15 16:18, Lee Jones wrote:
> >>>On Sat, 08 Aug 2015, Hans de Goede wrote:
> >>>
> >>>>Add a cell for the usb power_supply part of the axp20x PMICs.
> >>>>
> >>>>Note that this cell is only for the usb power_supply part and not=
 the
> >>>>ac-power / battery-charger / rtc-backup-bat-charger bits.
> >>>>
> >>>>Depending on the board each of those must be enabled / disabled s=
eparately
> >>>>in devicetree as most boards do not use all 4. So in dt each one =
needs its
> >>>>own child-node of the axp20x node. Another reason for using separ=
ate child
> >>>>nodes for each is so that other devicetree nodes can have a power=
-supply
> >>>>property with a phandle referencing a node representing a single
> >>>>power-supply.
> >>>>
> >>>>The decision to use a separate devicetree node for each is reflec=
ted on
> >>>>the kernel side by each getting its own mfd-cell / platform_devic=
e and
> >>>>platform-driver.
> >>>>
> >>>>Note this commit also makes some whitespace changes to the intial=
ization
> >>>>of existing cells in axp20x_cells, these are pure whitespace chan=
ges,
> >>>>functionally nothing changes.
> >>>>
> >>>>Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> >>>>Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> >>>>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>>>Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>>>Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>>---
> >>>>Changes in v2:
> >>>>-Use DEFINE_RES_IRQ_NAMED
> >>>>-Change indentation of axp20x_cells initializers to avoid line wr=
apping
> >>>>Changes in v3:
> >>>>-Improve commit message
> >>>>-Add Bruno's S-o-b
> >>>>---
> >>>>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
> >>>>  1 file changed, 16 insertions(+), 4 deletions(-)
> >>>
> >>>Applied, thanks.
> >>
> >>Great, but I'm not seeing this in:
> >>
> >>https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=3Df=
or-mfd-next
> >
> >Well it does usually take me a day or two push my local branch out,
> >however in this case I had actually dropped a ball somewhere.  I've
> >been through my backlog of 'applied' patches and these two are the
> >only ones I failed to pick.  I have now, re-picked, re-applied and
> >pushed the branch out.  Let me know if something is still not right.
>=20
> Looks good now, thanks.

You're welcome.

> >Sorry for the inconvenience.
>=20
> No problem, thanks for all the great work you are doing on maintainin=
g
> the mfd subsys.

Thanks. :)

I should print and frame this, to look at when I think about not doing
it anymore.

> >>>>diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >>>>index d9f2f96..3f576b7 100644
> >>>>--- a/drivers/mfd/axp20x.c
> >>>>+++ b/drivers/mfd/axp20x.c
> >>>>@@ -140,6 +140,13 @@ static struct resource axp20x_pek_resources[=
] =3D {
> >>>>  	},
> >>>>  };
> >>>>
> >>>>+static struct resource axp20x_usb_power_supply_resources[] =3D {
> >>>>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> >>>>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >>>>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
> >>>>+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID=
"),
> >>>>+};
> >>>>+
> >>>>  static struct resource axp22x_pek_resources[] =3D {
> >>>>  	{
> >>>>  		.name   =3D "PEK_DBR",
> >>>>@@ -432,11 +439,16 @@ static const struct regmap_irq_chip axp288_=
regmap_irq_chip =3D {
> >>>>
> >>>>  static struct mfd_cell axp20x_cells[] =3D {
> >>>>  	{
> >>>>-		.name			=3D "axp20x-pek",
> >>>>-		.num_resources		=3D ARRAY_SIZE(axp20x_pek_resources),
> >>>>-		.resources		=3D axp20x_pek_resources,
> >>>>+		.name		=3D "axp20x-pek",
> >>>>+		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> >>>>+		.resources	=3D axp20x_pek_resources,
> >>>>  	}, {
> >>>>-		.name			=3D "axp20x-regulator",
> >>>>+		.name		=3D "axp20x-regulator",
> >>>>+	}, {
> >>>>+		.name		=3D "axp20x-usb-power-supply",
> >>>>+		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
> >>>>+		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resource=
s),
> >>>>+		.resources	=3D axp20x_usb_power_supply_resources,
> >>>>  	},
> >>>>  };
> >>>>
> >>>
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
