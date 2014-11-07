From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 01/21] thermal: of: Extend of-thermal.c to provide number
 of trip points
Date: Thu, 6 Nov 2014 21:34:07 -0400
Message-ID: <20141107013405.GB10180@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-2-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412872737-624-2-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lukasz,

On Thu, Oct 09, 2014 at 06:38:37PM +0200, Lukasz Majewski wrote:
> This patch extends the of-thermal.c to provide information about number of
> available trip points.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/of-thermal.c   | 6 ++++++
>  drivers/thermal/thermal_core.h | 5 +++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index f8eb625..b2390d9 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -113,6 +113,12 @@ static int of_thermal_get_temp(struct thermal_zone_d=
evice *tz,
>  	return data->get_temp(data->sensor_data, temp);
>  }
> =20
> +int of_thermal_get_ntrips(struct thermal_zone_device *tz)
> +{
> +	struct __thermal_zone *data =3D tz->devdata;
> +	return data->ntrips;
> +}

I am not against this addition. I just request you to document it
accordingly.

> +
>  static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 3db339f..587ca5c 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -81,9 +81,14 @@ static inline void thermal_gov_user_space_unregister(v=
oid) {}
>  #ifdef CONFIG_THERMAL_OF
>  int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
> +int of_thermal_get_ntrips(struct thermal_zone_device *);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
>  static inline void of_thermal_destroy_zones(void) { }
> +static inline int of_thermal_get_ntrips(struct thermal_zone_device *)
> +{
> +	return 0;
> +}
>  #endif
> =20
>  #endif /* __THERMAL_CORE_H__ */
> --=20
> 2.0.0.rc2
>=20

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXCGFAAoJEMLUO4d9pOJWvWgH/0wTXCMz5Dz1Cghr9LauQ9iF
X7I0n7+vZdpj/d6LmHFZEan+fRpSpvrlFbbc6mQXZz8sYEvWVqUSlRgcPJ8zjUB0
wNROGNzI2Gxi6CSWWgat/rElsedXYSPb0K5EXGCI2cSmZBzYrAYI1N6hQWyyFl/k
j8qJB8mZS94nK+ToXPlr6TmU6ovQU+gWPUxtqWa86NGhMEGcG0iQkO6XVVk3vjjy
FLT1vBwR3ZRzdS/aI7WXlNwQMUEo624PvqcGIsaTlDoVWaW8QYT9T4LP9+C2tUPO
UiK82Il/dIRt10eRzfAWof4jS9Vzm43Z4di/8FKjsDT3xp6dlxzPBfFWrpH+OQw=
=hqwO
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
