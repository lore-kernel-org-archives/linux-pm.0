From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/4] mfd: axp20x: Add axp20x-usb-power-supply for
 axp22x pmics
Date: Fri, 10 Jun 2016 15:56:22 +0100
Message-ID: <20160610145622.GB7351@dell>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <1464887936-17020-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34830 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcFJOzr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 10:55:47 -0400
Received: by mail-wm0-f49.google.com with SMTP id v199so152275668wmv.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 07:55:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464887936-17020-3-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Thu, 02 Jun 2016, Hans de Goede wrote:

> Add axp20x-usb-power-supply for axp22x pmics.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Change compatible string for axp22x usb-power-supply cell to match v=
2 of:
>  "power: axp20x_usb: Add support for usb power-supply on axp22x pmics=
"
> ---
>  drivers/mfd/axp20x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ca04361..6364dab 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -160,6 +160,11 @@ static struct resource axp20x_usb_power_supply_r=
esources[] =3D {
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>  };
> =20
> +static struct resource axp22x_usb_power_supply_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static struct resource axp22x_pek_resources[] =3D {
>  	{
>  		.name   =3D "PEK_DBR",
> @@ -527,6 +532,11 @@ static struct mfd_cell axp22x_cells[] =3D {
>  		.resources		=3D axp22x_pek_resources,
>  	}, {
>  		.name			=3D "axp20x-regulator",
> +	}, {
> +		.name		=3D "axp20x-usb-power-supply",
> +		.of_compatible	=3D "x-powers,axp221-usb-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp22x_usb_power_supply_resources),
> +		.resources	=3D axp22x_usb_power_supply_resources,
>  	},
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
