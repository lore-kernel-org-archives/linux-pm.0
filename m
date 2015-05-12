From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] thermal: of-thermal: add support for reading
 coefficients property  33 O   May 11 Antoine Tenart  ( 15K) [PATCH v4 1/3]
 iio: adc: add support for Berlin
Date: Mon, 11 May 2015 20:27:52 -0700
Message-ID: <20150512032751.GJ4810@localhost.localdomain>
References: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
 <1431399857-13943-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431399857-13943-3-git-send-email-edubezval@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, hongtao.jia@freescale.com, kong.kongxinwei@hisilicon.com, nrajan@codeaurora.org
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Copying Narendran.

On Mon, May 11, 2015 at 08:04:17PM -0700, Eduardo Valentin wrote:
> In order to avoid having each driver adding their own
> specific DT property to specify slope and offset,
> this patch adds a basic coefficient reading from
> DT thermal zone node. Right now, as the thermal
> framework does not support multiple sensors,
> the current coefficients apply only to the only
> sensor in the thermal zone.
>=20
> The supported equation is a simple linear model:
> 	slope * <sensor reading> + offset.
>=20
> slope and offset are read from the coefficients
> DT property. In the same way as it is described in
> the DT thermal binding.
>=20
> So, as of today, the thermal framework will support
> only cases like:
>                 /* hotspot =3D 1 * adc + 6000 */
> 		coefficients =3D          <1      6000>;
>=20
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/of-thermal.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 9e8c614..b295b2b 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -58,6 +58,8 @@ struct __thermal_bind_params {
>   * @mode: current thermal zone device mode (enabled/disabled)
>   * @passive_delay: polling interval while passive cooling is activated
>   * @polling_delay: zone polling interval
> + * @slope: slope of the temperature adjustment curve
> + * @offset: offset of the temperature adjustment curve
>   * @ntrips: number of trip points
>   * @trips: an array of trip points (0..ntrips - 1)
>   * @num_tbps: number of thermal bind params
> @@ -70,6 +72,8 @@ struct __thermal_zone {
>  	enum thermal_device_mode mode;
>  	int passive_delay;
>  	int polling_delay;
> +	int slope;
> +	int offset;
> =20
>  	/* trip data */
>  	int ntrips;
> @@ -716,7 +720,7 @@ static int thermal_of_populate_trip(struct device_nod=
e *np,
>   * @np parameter and fills the read data into a __thermal_zone data stru=
cture
>   * and return this pointer.
>   *
> - * TODO: Missing properties to parse: thermal-sensor-names and coefficie=
nts
> + * TODO: Missing properties to parse: thermal-sensor-names
>   *
>   * Return: On success returns a valid struct __thermal_zone,
>   * otherwise, it returns a corresponding ERR_PTR(). Caller must
> @@ -728,7 +732,7 @@ thermal_of_build_thermal_zone(struct device_node *np)
>  	struct device_node *child =3D NULL, *gchild;
>  	struct __thermal_zone *tz;
>  	int ret, i;
> -	u32 prop;
> +	u32 prop, coef[2];
> =20
>  	if (!np) {
>  		pr_err("no thermal zone np\n");
> @@ -753,6 +757,20 @@ thermal_of_build_thermal_zone(struct device_node *np)
>  	}
>  	tz->polling_delay =3D prop;
> =20
> +	/*
> +	 * REVIST: for now, the thermal framework supports only
> +	 * one sensor per thermal zone. Thus, we are considering
> +	 * only the first two values as slope and offset.
> +	 */
> +	ret =3D of_property_read_u32_array(np, "coefficients", coef, 2);
> +	if (ret =3D=3D 0) {
> +		tz->slope =3D coef[0];
> +		tz->offset =3D coef[1];
> +	} else {
> +		tz->slope =3D 1;
> +		tz->offset =3D 0;
> +	}
> +
>  	/* trips */
>  	child =3D of_get_child_by_name(np, "trips");
> =20
> @@ -900,6 +918,10 @@ int __init of_parse_thermal_zones(void)
>  		for (i =3D 0; i < tz->ntrips; i++)
>  			mask |=3D 1 << i;
> =20
> +		/* these two are left for temperature drivers to use */
> +		tzp->slope =3D tz->slope;
> +		tzp->offset =3D tz->offset;
> +
>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
>  						    mask, tz,
>  						    ops, tzp,
> --=20
> 2.3.4
>=20

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVUXK8AAoJEMLUO4d9pOJWXo0H/1EjTVqvNjam1HX48I2Hhprp
x/tRfTbLxlbKzX4AGHwuPjBZkGXkrJFXqbrkOzwjbFeLQ+Z5TMhyBZJsFS6A8SFe
q+wF52hnBE6QhLNXUgoBqG4UjE/CFj5IplsjqJveAoq6WQpeIGyB6WijYUw3zq3l
ztCKHCXaL2c4mWjCxaGDBaeTGAb6884ys5fo5JVBYVvgJfLPXuLD0jNzoDfLEUxs
xGpcxmLUyMq2iw2IymtIizbjRo4Nrh3vSOxBL662lRpO6gVdxD89C3YtRbvpEFtV
lWy9YGI8qEZNF/fQMvIEzeVOytLTNMIwzTiX4neEpF5wuPmGfCMB1Y68dsc63zQ=
=/wZr
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
