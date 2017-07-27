From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v4 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Thu, 27 Jul 2017 10:34:15 +0200
Message-ID: <20170727083415.a5mlbtaunwiw2y2v@earth>
References: <cover.1501132171.git.baolin.wang@linaro.org>
 <b25c3a5e595716c701091d848188585dbd95bb20.1501132173.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qvyycoq7qizcmpjm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38395 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdG0IeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 04:34:20 -0400
Content-Disposition: inline
In-Reply-To: <b25c3a5e595716c701091d848188585dbd95bb20.1501132173.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--qvyycoq7qizcmpjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 27, 2017 at 01:14:38PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---

Looks ok now.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
>  drivers/power/supply/wm831x_power.c              |   72 ++++++++++++++++=
++++++
>  2 files changed, 73 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/wm831x.txt b/Documenta=
tion/devicetree/bindings/mfd/wm831x.txt
> index 9f8b743..4e3bc07 100644
> --- a/Documentation/devicetree/bindings/mfd/wm831x.txt
> +++ b/Documentation/devicetree/bindings/mfd/wm831x.txt
> @@ -31,6 +31,7 @@ Required properties:
>      ../interrupt-controller/interrupts.txt
> =20
>  Optional sub-nodes:
> +  - usb-phy : Contains a phandle to the USB PHY.
>    - regulators : Contains sub-nodes for each of the regulators supplied =
by
>      the device. The regulators are bound using their names listed below:
> =20
> diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/w=
m831x_power.c
> index 7082301..dff6473 100644
> --- a/drivers/power/supply/wm831x_power.c
> +++ b/drivers/power/supply/wm831x_power.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/usb/phy.h>
> =20
>  #include <linux/mfd/wm831x/core.h>
>  #include <linux/mfd/wm831x/auxadc.h>
> @@ -31,6 +32,8 @@ struct wm831x_power {
>  	char usb_name[20];
>  	char battery_name[20];
>  	bool have_battery;
> +	struct usb_phy *usb_phy;
> +	struct notifier_block usb_notify;
>  };
> =20
>  static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
> @@ -125,6 +128,43 @@ static int wm831x_usb_get_prop(struct power_supply *=
psy,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> =20
> +/* In milliamps */
> +static const unsigned int wm831x_usb_limits[] =3D {
> +	0,
> +	2,
> +	100,
> +	500,
> +	900,
> +	1500,
> +	1800,
> +	550,
> +};
> +
> +static int wm831x_usb_limit_change(struct notifier_block *nb,
> +				   unsigned long limit, void *data)
> +{
> +	struct wm831x_power *wm831x_power =3D container_of(nb,
> +							 struct wm831x_power,
> +							 usb_notify);
> +	unsigned int i, best;
> +
> +	/* Find the highest supported limit */
> +	best =3D 0;
> +	for (i =3D 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> +		if (limit >=3D wm831x_usb_limits[i] &&
> +		    wm831x_usb_limits[best] < wm831x_usb_limits[i])
> +			best =3D i;
> +	}
> +
> +	dev_dbg(wm831x_power->wm831x->dev,
> +		"Limiting USB current to %umA", wm831x_usb_limits[best]);
> +
> +	wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
> +		        WM831X_USB_ILIM_MASK, best);
> +
> +	return 0;
> +}
> +
>  /*********************************************************************
>   *		Battery properties
>   *********************************************************************/
> @@ -607,6 +647,33 @@ static int wm831x_power_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> +	power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0=
);
> +	ret =3D PTR_ERR_OR_ZERO(power->usb_phy);
> +
> +	switch (ret) {
> +	case 0:
> +		power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
> +		ret =3D usb_register_notifier(power->usb_phy, &power->usb_notify);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register notifier: %d\n",
> +				ret);
> +			goto err_bat_irq;
> +		}
> +		break;
> +	case -EINVAL:
> +	case -ENODEV:
> +		/* ignore missing usb-phy, it's optional */
> +		power->usb_phy =3D NULL;
> +		ret =3D 0;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
> +		/* fall-through */
> +	case -EPROBE_DEFER:
> +		goto err_bat_irq;
> +		break;
> +	}
> +
>  	return ret;
> =20
>  err_bat_irq:
> @@ -637,6 +704,11 @@ static int wm831x_power_remove(struct platform_devic=
e *pdev)
>  	struct wm831x *wm831x =3D wm831x_power->wm831x;
>  	int irq, i;
> =20
> +	if (wm831x_power->usb_phy) {
> +		usb_unregister_notifier(wm831x_power->usb_phy,
> +					&wm831x_power->usb_notify);
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
>  		irq =3D wm831x_irq(wm831x,=20
>  				 platform_get_irq_byname(pdev,
> --=20
> 1.7.9.5
>=20

--qvyycoq7qizcmpjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll5pYEACgkQ2O7X88g7
+ppdTQ//WoZZFOeFsPmg6Izv9oDhV/FSIbl8W5kQmcZjHxVda0umN+LgFDZPrWf5
qVIWGL6zcOBcTLIl/FZ79AUE3hloOEFuFgSn8iVs2u+d64x6GPUtLDvU8s6LCva8
jd0hMUVwBgSpeKrPKNK738ibMeoTJmj2utBgRYJutMJa4hmqBDVFg20E9sZf+iEx
2ilcMHtGi5wlaZfZL7TN0Dyr9lU8J+IxSXF3IsY9Kka7BbmssMRdLM1EYJq/zFd6
9Ip38JGxBT/Rd0janRQLD4DrzTucT+aTvZLghlsy52nQp9KhCcGcbGCtVPLkb/XA
WwkCpuvlkoU452UtbOvNa/DEUF34YHUf5xnHJjYU5F2Ou067Tb+a5oEko7kU61FI
Apd3s9JKC0YSDLuVJy6Ac0/9MrJCrb3oBVIbSVsSHi82rn8+Eekg34q/thkx9vmv
ERqRITeMZYxJyLZCrNM14UY+G/o+ni0OOf/pf1HuJUR1END/ddwoufxttD2wiZzZ
wdJxKBppfPJ3/yMGl2L5iRYsO7vZ+c+ZOOmZ/7yRgWGepJT8BO5m9QH2iJavPiH4
753a+2ZiQEh5UOaZOGlc0eUDoqRfa41nX3r4/GUGXHZoyASkJlukBmLO3NO4Zi9n
mMMIsEX5y58uciFrY9rv1pJLzAui/mibCrNj6SBANZZ1kVnztNs=
=2uKU
-----END PGP SIGNATURE-----

--qvyycoq7qizcmpjm--
