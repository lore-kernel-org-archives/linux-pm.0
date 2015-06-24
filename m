From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Wed, 24 Jun 2015 12:23:33 +0100
Message-ID: <20150624112333.GH15013@x1>
References: <1434211748-25572-1-git-send-email-hdegoede@redhat.com>
 <1434211748-25572-4-git-send-email-hdegoede@redhat.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBOVGVKWAKGQEE3ZMWIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434211748-25572-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

> Add a cell for the usb power_supply part of the axp20x PMICs.

Why are you duplicating the subject line?

> Note that this cell is only for the usb power_supply part and not the
> ac-power / battery-charger / rtc-backup-bat-charger bits.
>=20
> Depending on the board each of those must be enabled / disabled separatel=
y
> in devicetree as most boards do not use all 4. So in dt each one needs it=
s
> own child-node of the axp20x node. Another reason for using separate chil=
d
> nodes for each is so that other devicetree nodes can have a power-supply
> property with a phandle referencing a node representing a single
> power-supply.
>=20
> The decision to use a separate devicetree node for each is reflected on
> the kernel side by each getting its own mfd-cell / platform_device and
> platform-driver.

You don't really need to say any of this, as this is the 'norm'.

What you didn't mention however, is that you're taking the opportunity
to fix some formatting issues and that there are no functional changes
in these lines.

> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> -Use DEFINE_RES_IRQ_NAMED
> -Change indentation of axp20x_cells initializers to avoid line wrapping
> ---
>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Patch looks okay however:

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index f9a3c2d..ca4a604 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -113,6 +113,13 @@ static struct resource axp20x_pek_resources[] =3D {
>  	},
>  };
> =20
> +static struct resource axp20x_usb_power_supply_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_VALID, "VBUS_VALID"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
> +};
> +
>  static struct resource axp22x_pek_resources[] =3D {
>  	{
>  		.name   =3D "PEK_DBR",
> @@ -363,11 +370,16 @@ static const struct regmap_irq_chip axp288_regmap_i=
rq_chip =3D {
> =20
>  static struct mfd_cell axp20x_cells[] =3D {
>  	{
> -		.name			=3D "axp20x-pek",
> -		.num_resources		=3D ARRAY_SIZE(axp20x_pek_resources),
> -		.resources		=3D axp20x_pek_resources,
> +		.name		=3D "axp20x-pek",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	=3D axp20x_pek_resources,
>  	}, {
> -		.name			=3D "axp20x-regulator",
> +		.name		=3D "axp20x-regulator",
> +	}, {
> +		.name		=3D "axp20x-usb-power-supply",
> +		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resources),
> +		.resources	=3D axp20x_usb_power_supply_resources,
>  	},
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
