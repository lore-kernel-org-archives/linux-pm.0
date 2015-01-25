From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd/axp20x: change battery cell name to fuel gauge
Date: Sun, 25 Jan 2015 13:57:38 +0100
Message-ID: <20150125125738.GA2719@earth.universe>
References: <cover.1421957474.git.todd.e.brandt@linux.intel.com>
 <b7c6d711c78eb85fc0c7d5904da4e4c930be0ca9.1421957474.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b7c6d711c78eb85fc0c7d5904da4e4c930be0ca9.1421957474.git.todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Todd Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 12:52:05PM -0800, Todd Brandt wrote:
> Name changes to the battery cell structure to a
> more generic cell type: fuel gauge.
>=20
> Signed-off-by: Todd Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/mfd/axp20x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> v1: 01/07/14
> v2: 01/22/14
> - replaced the const in axp20x_acpi_match declaration
>=20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index b1b580a..0acbe52 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -87,7 +87,7 @@ static struct resource axp20x_pek_resources[] =3D {
>  	},
>  };
> =20
> -static struct resource axp288_battery_resources[] =3D {
> +static struct resource axp288_fuel_gauge_resources[] =3D {
>  	{
>  		.start =3D AXP288_IRQ_QWBTU,
>  		.end   =3D AXP288_IRQ_QWBTU,
> @@ -350,9 +350,9 @@ static struct mfd_cell axp288_cells[] =3D {
>  		.resources =3D axp288_charger_resources,
>  	},
>  	{
> -		.name =3D "axp288_battery",
> -		.num_resources =3D ARRAY_SIZE(axp288_battery_resources),
> -		.resources =3D axp288_battery_resources,
> +		.name =3D "axp288_fuel_gauge",
> +		.num_resources =3D ARRAY_SIZE(axp288_fuel_gauge_resources),
> +		.resources =3D axp288_fuel_gauge_resources,
>  	},
>  	{
>  		.name =3D "axp288_pmic_acpi",

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxOg/AAoJENju1/PIO/qaYigP/2LWEifF5zgADJj4OGJNQZRR
S8X6xClxPe4sE5AJ/itgn0OBjK/QgcGP0B1Ozwr+FBuWAT1avV7C8JY8xAGlhjmH
y/bv697Rbk9N/qrnnv2RtkNuSsYpAOVsQlNx79O4blSy5BmXCKluvBdzqVq31u8Y
RVAgihpa0iAlrgKMEeG1RBbtdvWimPitGkXnUWHTs2ojcVe9lPSYmapH31OsFoPL
GTQK6vXKykzpEjDIaJZPPcnii/4lf8UB3QMvAFUYQMGX+j/6Ji63UASbsowqCJg3
iKob8p3C+oajiwrxu/uwjhYPKw/ODtAw0xhad0p9Lup5X5PigrLGyikrUD8RNGs4
Cj9xlr9+T/F9XPvkBSuqVtZiiCF47Z5z0KVrzBaNPGk9aq1o7UCFVWnO3GJmYbDj
EpfFFhugpTt7ZkqRKhbtEEKwcaGFcPcO6AveEGAJfwmk6L49ZracfwoN54sWq3JR
WhsvKTY0Hcd1sXX2KBb2L5MQAu+t4Lp3t6xlEhLdC1WQNGQo0m8gNJ6Cs8oJapeV
ZuuvJmonCcOXbrVsPjy5ZIa/paB0ZLqTD1kM/WjsVjq2VvOtc9yeHG7QPi1MmAjw
/T5GjE5xIlhteGnfriiw6eAaEXvs95tPlyCmGfjGmmHH+iDCISuw9Z3NMLvjEB2v
xpgz67HQ80uMOoguOQxD
=pPsV
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
