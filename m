From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC PATCH 2/5] power: generic-adc-battery: Parse more
 properties from DT
Date: Tue, 29 Aug 2017 11:45:52 +0200
Message-ID: <20170829094552.5tywehtwq374b7hw@earth>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfnk7tht56soaopo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org


--nfnk7tht56soaopo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2017 at 10:55:23PM +0200, Marek Belisko wrote:
> From: Marek Belisko <marek.belisko@gmail.com>
>=20
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>

This should use the infrastructure described here:

Documentation/devicetree/bindings/power/supply/battery.txt

-- Sebastian

> ---
>  drivers/power/supply/generic-adc-battery.c | 68 ++++++++++++++++++++++++=
++++++
>  1 file changed, 68 insertions(+)
>=20
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/s=
upply/generic-adc-battery.c
> index b5e9208..d4daa6a 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -23,6 +23,7 @@
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/types.h>
>  #include <linux/power/generic-adc-battery.h>
> +#include <linux/of_gpio.h>
> =20
>  #define JITTER_DEFAULT 10 /* hope 10ms is enough */
> =20
> @@ -241,6 +242,69 @@ static irqreturn_t gab_charged(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +#ifdef CONFIG_OF
> +static struct gab_platform_data *gab_dt_probe(struct platform_device *pd=
ev)
> +{
> +	struct gab_platform_data *pdata;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	const char *name;
> +	u32 val;
> +	int err;
> +
> +	pdata =3D devm_kzalloc(&pdev->dev,
> +			sizeof(struct gab_platform_data),
> +			GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->gpio_charge_finished  =3D of_get_gpio(np, 0);
> +
> +	/* parse and fill power_supply_info struct */
> +	err =3D of_property_read_u32(np, "technology", &val);
> +	if (err) {
> +		dev_info(&pdev->dev, "Battery technology unknown\n");
> +		val =3D 0;
> +	}
> +	pdata->battery_info.technology =3D val;
> +
> +	err =3D of_property_read_string(np, "battery-name", &name);
> +	if (err) {
> +		dev_info(&pdev->dev, "Battery name empty, setting default\n");
> +	}
> +	pdata->battery_info.name =3D name;
> +
> +	val =3D 0;
> +	err =3D of_property_read_u32(np, "charge_empty_design", &val);
> +	pdata->battery_info.charge_empty_design =3D val;
> +
> +	val =3D 0;
> +	err =3D of_property_read_u32(np, "charge_full_design", &val);
> +	pdata->battery_info.charge_full_design =3D val;
> +
> +	val =3D 0;
> +	err =3D of_property_read_u32(np, "voltage_min_design", &val);
> +	pdata->battery_info.voltage_min_design =3D val;
> +
> +	val =3D 0;
> +	err =3D of_property_read_u32(np, "voltage_max-design", &val);
> +	pdata->battery_info.voltage_max_design =3D val;
> +
> +	return pdata;
> +}
> +
> +static const struct of_device_id of_gab_match[] =3D {
> +	{ .compatible =3D "linux,generic-adc-battery", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_gab_match);
> +
> +#else
> +static struct gab_platform_data gab_dt_probe(struct platform_device *pde=
v)
> +{
> +	ERR_PTR(-ENODEV);
> +}
> +#endif
> +
>  static int gab_probe(struct platform_device *pdev)
>  {
>  	struct gab *adc_bat;
> @@ -258,6 +322,9 @@ static int gab_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
> =20
> +	if (pdata =3D=3D NULL)
> +		pdata =3D gab_dt_probe(pdev);
> +
>  	psy_cfg.drv_data =3D adc_bat;
>  	psy_desc =3D &adc_bat->psy_desc;
>  	psy_desc->name =3D "generic-adc-batt";//pdata->battery_info.name;
> @@ -418,6 +485,7 @@ static struct platform_driver gab_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "generic-adc-battery",
>  		.pm	=3D &gab_pm_ops,
> +		.of_match_table =3D of_gab_match,
>  	},
>  	.probe		=3D gab_probe,
>  	.remove		=3D gab_remove,
> --=20
> 2.7.4
>=20

--nfnk7tht56soaopo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlN80ACgkQ2O7X88g7
+ppQBg//cevsupxeqe9BXROK1caLg/nMqNl9YuwoCoV0Kt/NVnO6rGtNwW54mYUD
laqtQymr4nFOcPvx9AszOVKabKhSxHyt7kfLuJCeI7Xabo74lLR7qhlwZqjGAdQI
fk/6hD/4m9kub5QZ/mlpUm8+1lM1iE8gwU25kgLHhx/pH1iTgUr0ggigUfIVw4jc
spXdPwPXAXIFwE4bIis+1+44x8/o4V4ANGYCXsdwmJqIbDYf0lHnW+CDejNqPMUT
MyY7in4ChUmzpTSAKyHFg/sq2a2KmE6bg4IbCJMXqt1VOeJuXrBOV2HzzuNVj3At
OUEPhTirGW3XKNoNu6h5Ph05xcC4VNbaigDcu5zTzajMNcs1GDTDVtzdeVM5CM/f
gwtbq8iDkRo7rMqPEY5+n2XaXT9oIrLwdWyCSwFfi8pEOo7QrNrPqSI6X6Oqutw/
Kuz45GUXbODFe6nEnO/9Ix0mHykaLQFXKHyBbxk9TRGLzTvq7duW6bGc0zqK4qVh
Wbh3Pj73Bftv2ViRD0iaQMLQ71znGVj/PrGselIAaVQlFR6hnWxBEYGSK+UR+qbA
GMVmFNgFyID8vla5EE96mdy0pk6M7maEbvRqTjj967OQZW7g1BAKOh7xB0zYlXhX
ZM2iWoJXa7peyMd/9oKmzlwnfwzLlTYC2TAoX/gdJXujzuZCm6E=
=Dnce
-----END PGP SIGNATURE-----

--nfnk7tht56soaopo--
