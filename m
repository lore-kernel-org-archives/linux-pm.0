From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 25 Jul 2017 11:59:31 +0200
Message-ID: <20170725095931.qmxtn766wam7vufe@earth>
References: <cover.1500968744.git.baolin.wang@linaro.org>
 <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyr77slj2fwquqrn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60834 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdGYJ7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 05:59:40 -0400
Content-Disposition: inline
In-Reply-To: <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--wyr77slj2fwquqrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 25, 2017 at 04:00:01PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
>  drivers/power/supply/wm831x_power.c              |   58 ++++++++++++++++=
++++++
>  2 files changed, 59 insertions(+)
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
> index 7082301..d3948ab 100644
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
> @@ -607,6 +647,19 @@ static int wm831x_power_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> +	power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev,
> +						     "usb-phy", 0);
> +	if (!IS_ERR(power->usb_phy)) {
> +		power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
> +		ret =3D usb_register_notifier(power->usb_phy,
> +					    &power->usb_notify);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register notifier: %d\n",
> +				ret);
> +			goto err_bat_irq;
> +		}
> +	}

No error handling for power->usb_phy? I think you should bail out
for all errors except for "not defined in DT". Especially I would
expect probe defer handling in case the power supply driver is
loaded before the phy driver.

>  	return ret;
> =20
>  err_bat_irq:
> @@ -637,6 +690,11 @@ static int wm831x_power_remove(struct platform_devic=
e *pdev)
>  	struct wm831x *wm831x =3D wm831x_power->wm831x;
>  	int irq, i;
> =20
> +	if (!IS_ERR(wm831x_power->usb_phy)) {
> +		usb_unregister_notifier(wm831x_power->usb_phy,
> +					&wm831x_power->usb_notify);
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
>  		irq =3D wm831x_irq(wm831x,=20
>  				 platform_get_irq_byname(pdev,

-- Sebastian

--wyr77slj2fwquqrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3FoAACgkQ2O7X88g7
+pqaEg/8C34OTp3Suxydxe9tJmPh0wz2K6FlIB9eQz4TKa25mateRFfS4jsTbDzt
Q3VpLSBE+Qcy5MHAF50XwNchxRTFiHKXJsb1VMohTyTPq/U0y0Q+p0BzDvdSxqsT
yduzXhlN1pkEYOHxIzl7PKxt/gia3+INXWloOb4bINlnHtuSHoOskI8Q00yTKijB
oSvigZH7W+4BFGvH1ljsqAX6mzwVCru8YVH7TdsByLHckJx3afvJ8acOhL57lEJP
jDGCTbayVh7N9bPveHtfQWtEy7HFpuvlOOvqSd+hHQf5bzWy0mVAN+ohFKXaqmb7
tTMtLjIr+LOOJqcTQ/EXG7R4QS36tPD4TZmTbAMhYCbNn4CUmxaqrYD0IymOfG3d
+Cb4HmlRmT6U3rVA6m9bFPWYJ78cwp63pnVmVLZbxd8nv+WFyRAHpJcePvNSJFyu
VdbSeV4VkqIFY56I7U36w4GGNfq5lLrPPQhb3QAMETVx5MkbODVxj7VC2L8T19VK
+aXtEy4i2YwnOgmQqDZf2G+Vv9WnMq+zpbKxZqihqGiRvFVvlQUxixIMtsYktFKJ
1HJJ6bEmjOnPZspCnJt4FiVIyfYJ8sMqO+IsCXNFBQwy2lL0papIg6vJFDkyK9C6
4nvTJCMC007XRAJe8+U+kUc1KvMNVd3YPNVGrAzyphOZsphgBzM=
=ax3C
-----END PGP SIGNATURE-----

--wyr77slj2fwquqrn--
