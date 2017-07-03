From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 3 Jul 2017 17:50:34 +0200
Message-ID: <20170703155034.mygcebphsyskzhhw@earth>
References: <cover.1499061617.git.baolin.wang@linaro.org>
 <dc4200357a69f0c0bca5404b9e1da8b486452731.1499061617.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="in6sjsnbcwlefzhg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52851 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdGCPuj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 11:50:39 -0400
Content-Disposition: inline
In-Reply-To: <dc4200357a69f0c0bca5404b9e1da8b486452731.1499061617.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org


--in6sjsnbcwlefzhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 03, 2017 at 02:07:15PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Missing DT binding documentation, otherwise fine with me.
Would be nice to convert existing drivers:

$ git grep -l extcon -- drivers/power/supply
drivers/power/supply/axp288_charger.c
drivers/power/supply/bq24190_charger.c
drivers/power/supply/charger-manager.c
drivers/power/supply/qcom_smbb.c

-- Sebastian

> ---
>  drivers/power/supply/wm831x_power.c |   61 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/w=
m831x_power.c
> index 7082301..3e3480708 100644
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
> @@ -607,6 +647,22 @@ static int wm831x_power_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> +	power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev,
> +						     "usb-phy", 0);
> +	if (IS_ERR(power->usb_phy)) {
> +		ret =3D PTR_ERR(power->usb_phy);
> +		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
> +		goto err_bat_irq;
> +	}
> +
> +	power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
> +	ret =3D usb_register_notifier(power->usb_phy,
> +				    &power->usb_notify);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> +		goto err_bat_irq;
> +	}
> +
>  	return ret;
> =20
>  err_bat_irq:
> @@ -637,6 +693,11 @@ static int wm831x_power_remove(struct platform_devic=
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

--in6sjsnbcwlefzhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaZ8cACgkQ2O7X88g7
+prdfg//fvehSNNoRtbrevyoca1x6CDU5x5qtXBSpTg112D9fQpYBoSIRM2ehKtU
xxfFHjiRezxLezUznaivjqSpsmg27Tpv5Ynw2G49RsPbtWRiGuh83qarK7EWmhnF
MVGEgIWBMRKINleeKZrEbRcRb3Dp5MjSdhneKiBso+mSzaaE1DFQy5zed5QJBmRx
GZZ89hDmGAuQsFuZ8UNGGZc+fnxr8SEXZzf3bYnixF0QoWPiJ7nbRwoJBbZ+412A
pO/q6g1eQPJMD6OZ1LpNQ4qiOl70cbGkYMQNuk8kd4DhXsq6QHlUSSw+NBooGGaj
xQ9EobP98yZoenTpfzgTzOPJIW3I70jqXCPqhjdwT4x6hy8mTER/YLHtnLariPRl
SxHjSyze4jLicUksOCyfcfPzuDfx5HGUrUV/p3cIc+SKxaGkgRbY7+x5TDVEvzwL
IcLzXrYwrV0fzAcAHryBvNyRiN9e3QYh+HshYiRelwF/2jGd13RttpdWmWHgDHah
z8bmlXSYBIY2A2SZBYNnjabHrLiynFS+qf2nU5h0K3qdC5NhgisPhl4r/c2XooN6
k1Ll1py+HE6gJ3gwbrxquqCyN4Ys1mgSevdd8FNKfet3hlDQWVC5z5g7SeD6dK4c
Tg28zBlkDu5t10H/meTtypP+zUeMpbUMu19HGPUSMHhSI1vInrY=
=sczM
-----END PGP SIGNATURE-----

--in6sjsnbcwlefzhg--
