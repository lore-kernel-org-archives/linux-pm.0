From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v4 4/9] mfd: axp20x: add AC power
 supply cells for AXP22X PMICs
Date: Mon, 20 Mar 2017 10:43:58 +0000
Message-ID: <20170320104358.37h3tn2ikwpyhalj@dell>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-5-quentin.schulz@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBB4PEX3DAKGQEVKANZDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170320081653.8884-5-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Mar 2017, Quentin Schulz wrote:

> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
>=20
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mfd/axp20x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 46bdd23..37643b1 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -614,6 +614,11 @@ static struct mfd_cell axp221_cells[] =3D {
>  	}, {
>  		.name		=3D "axp22x-adc"
>  	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp221-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	=3D axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		=3D "axp20x-usb-power-supply",
>  		.of_compatible	=3D "x-powers,axp221-usb-power-supply",
>  		.num_resources	=3D ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -631,6 +636,11 @@ static struct mfd_cell axp223_cells[] =3D {
>  	}, {
>  		.name			=3D "axp20x-regulator",
>  	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp221-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	=3D axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		=3D "axp20x-usb-power-supply",
>  		.of_compatible	=3D "x-powers,axp223-usb-power-supply",
>  		.num_resources	=3D ARRAY_SIZE(axp22x_usb_power_supply_resources),

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
