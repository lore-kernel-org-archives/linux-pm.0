From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: of: Remove bogus type qualifier for
 of_thermal_get_trip_points()
Date: Mon, 5 Jan 2015 16:28:04 -0400
Message-ID: <20150105202802.GA31247@developer>
References: <1420322216-13863-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420322216-13863-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2015 at 10:56:56PM +0100, Geert Uytterhoeven wrote:
> With gcc 4.1.2, 4.2, and 4.2.4 (4.4 and later are OK):
>=20
> drivers/thermal/thermal_core.h:110: warning: type qualifiers ignored on f=
unction return type
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: ce8be7785922de0e ("thermal: of: Extend of-thermal to export table =
of trip points")

Applied to my -fixes queue. Thanks Geert.

> ---
>  drivers/thermal/of-thermal.c   | 2 +-
>  drivers/thermal/thermal_core.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index e145b66df444e65b..d717f3dab6f1410f 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
>   *
>   * Return: pointer to trip points table, NULL otherwise
>   */
> -const struct thermal_trip * const
> +const struct thermal_trip *
>  of_thermal_get_trip_points(struct thermal_zone_device *tz)
>  {
>  	struct __thermal_zone *data =3D tz->devdata;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 9083e75206236c19..0531c752fbbb6680 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -91,7 +91,7 @@ int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
>  int of_thermal_get_ntrips(struct thermal_zone_device *);
>  bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
> -const struct thermal_trip * const
> +const struct thermal_trip *
>  of_thermal_get_trip_points(struct thermal_zone_device *);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
> @@ -105,7 +105,7 @@ static inline bool of_thermal_is_trip_valid(struct th=
ermal_zone_device *tz,
>  {
>  	return 0;
>  }
> -static inline const struct thermal_trip * const
> +static inline const struct thermal_trip *
>  of_thermal_get_trip_points(struct thermal_zone_device *tz)
>  {
>  	return NULL;
> --=20
> 1.9.1
>=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvO1AAoJEMLUO4d9pOJWf7gH/itLo+apYenyo090TpCsQ9nL
yGTZ/V+uwzJCLuOK+dwHNMEEhIensx1R5uMoz01Yq39g3Wq+jpmLsh5xRGfXH4NN
gwRt5YZaDfK1x3BeSPxJzxya4ppKQjemZoKeoICAMWgH0A7rVGy4R27jypwqFYIK
rMOIvIKn6TYDLvzeYG9bJuSuv7zpRG7mmp2LHg8n4OYBP62xnh63I6RUtshMX+eB
WHz8UwvQBdcShP9DQr19fgpJ+3/Is4nzDhOdMDXbe8wSNp0akdd1TUhBlfmKQhOA
M+xulUgslc6NU6u476IFK7KySo94EPWKYMobY5JGD2T9h7w7nwbelWeYHkzS0GQ=
=0dBL
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
