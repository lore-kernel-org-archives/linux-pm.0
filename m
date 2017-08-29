From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: supply: max17042_battery: Add support for
 ACPI enumeration
Date: Tue, 29 Aug 2017 10:42:33 +0200
Message-ID: <20170829084233.ybgwmovegkjwe5dz@earth>
References: <20170814201811.21110-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5rl4yglm7p5p2wto"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdH2Imm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 04:42:42 -0400
Content-Disposition: inline
In-Reply-To: <20170814201811.21110-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org


--5rl4yglm7p5p2wto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 14, 2017 at 10:18:10PM +0200, Hans de Goede wrote:
> Some x86 devices enumerate a max17047 fuel-gauge through a MAX17047
> ACPI firmware-node, add support for this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index aecaaa2b0586..b2ddb7eb69c6 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -22,6 +22,7 @@
>   * This driver is based on max17040_battery.c
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -982,6 +983,8 @@ static int max17042_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
>  	const struct power_supply_desc *max17042_desc =3D &max17042_psy_desc;
>  	struct power_supply_config psy_cfg =3D {};
> +	const struct acpi_device_id *acpi_id;
> +	struct device *dev =3D &client->dev;
>  	struct max17042_chip *chip;
>  	int ret;
>  	int i;
> @@ -995,7 +998,15 @@ static int max17042_probe(struct i2c_client *client,
>  		return -ENOMEM;
> =20
>  	chip->client =3D client;
> -	chip->chip_type =3D id->driver_data;
> +	if (id) {
> +		chip->chip_type =3D id->driver_data;
> +	} else {
> +		acpi_id =3D acpi_match_device(dev->driver->acpi_match_table, dev);
> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		chip->chip_type =3D acpi_id->driver_data;
> +	}
>  	chip->regmap =3D devm_regmap_init_i2c(client, &max17042_regmap_config);
>  	if (IS_ERR(chip->regmap)) {
>  		dev_err(&client->dev, "Failed to initialize regmap\n");
> @@ -1104,6 +1115,14 @@ static int max17042_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_suspend,
>  			max17042_resume);
> =20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id max17042_acpi_match[] =3D {
> +	{ "MAX17047", MAXIM_DEVICE_TYPE_MAX17047 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max17042_acpi_match);
> +#endif
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id max17042_dt_match[] =3D {
>  	{ .compatible =3D "maxim,max17042" },
> @@ -1125,6 +1144,7 @@ MODULE_DEVICE_TABLE(i2c, max17042_id);
>  static struct i2c_driver max17042_i2c_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "max17042",
> +		.acpi_match_table =3D ACPI_PTR(max17042_acpi_match),
>  		.of_match_table =3D of_match_ptr(max17042_dt_match),
>  		.pm	=3D &max17042_pm_ops,
>  	},
> --=20
> 2.13.4
>=20

--5rl4yglm7p5p2wto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlKPUACgkQ2O7X88g7
+prKag//bhdSac6lLjynyxlAJk44tHr5YTHKOQYaUHuKhWNl6wUl1D5HDF20W/ha
gbnzY0kgi1euG/LgbXA4/jfcFP5LdL99HxKMYY23Av0M7nI/pGUu3LscsfcpUomg
oa3ou2FF2Vsm4m0+xUX+Nk2LijyHFFpRRx0p38fTyFLBb5l1x7rVMWcxW9w8CSMc
dH8WYr83+voiGi/64i2r4/xtpdYqIruueh+23bXxkWHNx6We2+0HkA7X5Kdz1DMK
20QiTyznsJCQUUajBFr6klDWW54C+bVGWa3bUXl7RXMq2R1hV3/7uaHyrK1vZviV
TTcW3iPvnQm3bRVCUczJQGh5yx97stboFDUr/Di+VSFX7Sl/rmQYPxcvtpZ3BB/l
w+4FSDa4a2s+y9qJ/iR1qSZo01f4fCNmoDkT/aXypNPi+4AkM+JDWBtwEQ85aLwz
jRkMlIL8HEGJ8M0YnrL8EkYrKysCxYzCedORKC3g6njzo0vJaHFrF2LhpKFQ+gKp
qdrmK9esImYkXZG7EYfMc22xA0uYyiAHTZBvx+cfN1IbSQ+8E1lljmAJKL2eKK16
bAgbxfY3zMaX7i2v/mmS+ac3KuChBq5lCXZw+YQ+NCNvOhJ7W0XZF7U67PqcQvU0
QIekbIEPevUa3DsOG6f0Ni6rM91LCQ5e0DqOIJaej+EKOLE1u44=
=ly33
-----END PGP SIGNATURE-----

--5rl4yglm7p5p2wto--
