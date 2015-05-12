From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: support slope and offset coefficients
Date: Mon, 11 May 2015 20:25:10 -0700
Message-ID: <20150512032509.GI4810@localhost.localdomain>
References: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
 <1431399857-13943-2-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431399857-13943-2-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, hongtao.jia@freescale.com, kong.kongxinwei@hisilicon.com, nrajan@codeaurora.org
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Copying Narendran.

On Mon, May 11, 2015 at 08:04:16PM -0700, Eduardo Valentin wrote:
> It is common to have a linear extrapolation from
> the current sensor readings and the actual temperature
> value. This is specially the case when the sensor
> is in use to extrapolate hotspots.
>=20
> This patch adds slope and offset constants for
> single sensor linear extrapolation equation. Because
> the same sensor can be use in different locations,
> from board to board, these constants are added
> as part of thermal_zone_params.
>=20
> The constants are available through sysfs.
>=20
> It is up to the device driver to determine
> the usage of these values.


>=20
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  Documentation/thermal/sysfs-api.txt | 16 ++++++++++++++++
>  drivers/thermal/thermal_core.c      |  4 ++++
>  include/linux/thermal.h             | 11 +++++++++++
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index 7d44d7f..c1f6864 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -190,6 +190,8 @@ Thermal zone device sys I/F, created once it's regist=
ered:
>      |---k_i:                    PID's integral term in the power allocat=
or gov
>      |---k_d:                    PID's derivative term in the power alloc=
ator
>      |---integral_cutoff:        Offset above which errors are accumulated
> +    |---slope:                  Slope constant applied as linear extrapo=
lation
> +    |---offset:                 Offset constant applied as linear extrap=
olation
> =20
>  Thermal cooling device sys I/F, created once it's registered:
>  /sys/class/thermal/cooling_device[0-*]:
> @@ -359,6 +361,20 @@ integral_cutoff
>  	Documentation/thermal/power_allocator.txt
>  	RW, Optional
> =20
> +slope
> +	The slope constant used in a linear extrapolation model
> +	to determine a hotspot temperature based off the sensor's
> +	raw readings. It is up to the device driver to determine
> +	the usage of these values.
> +	RW, Optional
> +
> +offset
> +	The offset constant used in a linear extrapolation model
> +	to determine a hotspot temperature based off the sensor's
> +	raw readings. It is up to the device driver to determine
> +	the usage of these values.
> +	RW, Optional
> +
>  *****************************
>  * Cooling device attributes *
>  *****************************
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 962de18..04659bf 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -944,6 +944,8 @@ create_s32_tzp_attr(k_pu);
>  create_s32_tzp_attr(k_i);
>  create_s32_tzp_attr(k_d);
>  create_s32_tzp_attr(integral_cutoff);
> +create_s32_tzp_attr(slope);
> +create_s32_tzp_attr(offset);
>  #undef create_s32_tzp_attr
> =20
>  static struct device_attribute *dev_tzp_attrs[] =3D {
> @@ -953,6 +955,8 @@ static struct device_attribute *dev_tzp_attrs[] =3D {
>  	&dev_attr_k_i,
>  	&dev_attr_k_d,
>  	&dev_attr_integral_cutoff,
> +	&dev_attr_slope,
> +	&dev_attr_offset,
>  };
> =20
>  static int create_tzp_attrs(struct device *dev)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 6bbe11c..037e9df 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -302,6 +302,17 @@ struct thermal_zone_params {
> =20
>  	/* threshold below which the error is no longer accumulated */
>  	s32 integral_cutoff;
> +
> +	/*
> +	 * @slope:	slope of a linear temperature adjustment curve.
> +	 * 		Used by thermal zone drivers.
> +	 */
> +	int slope;
> +	/*
> +	 * @offset:	offset of a linear temperature adjustment curve.
> +	 * 		Used by thermal zone drivers (default 0).
> +	 */
> +	int offset;
>  };
> =20
>  struct thermal_genl_event {
> --=20
> 2.3.4
>=20

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVUXKSAAoJEMLUO4d9pOJWD+4H/AgZnWQLx6rd8bTAaHF1mZBP
cMx4aPw4B5QLQs3tmdlVahcJ3VvCZVuhFOshp5UD8eXOq/ckZQR4F4KWzk7Y8yK7
dg//7CNibziMT8FTWHb0QZp753JDezR92xEPo0KGtLaHwXTp0hR0Z1fT+/hwxdaE
9cmZO5AZ2zlwY4PUz7YxLqMBBVGsh8YFvQRBPJNXWm3xahfeN4CHhtJd6R5ePAPk
Q6e+jHPaqeGkwP8XlycCuyIHDLRM2vUgqV1V0eCTHYvv6b7sHJC17jWwCQj3pfFP
w+ILoaYsksUpdbevd445czWJd1xMslrASnt6cwCoCguWkpzwQ73wuzynvgJ7ppQ=
=BiyG
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--
