From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 02/21] thermal: of: Extend of-thermal.c to provide check
 if trip point is enabled
Date: Thu, 6 Nov 2014 21:37:29 -0400
Message-ID: <20141107013727.GC10180@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-3-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412872737-624-3-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lukasz,

On Thu, Oct 09, 2014 at 06:38:38PM +0200, Lukasz Majewski wrote:
> This patch extends the of-thermal.c to provide check if trip point is
> enabled.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/of-thermal.c   | 9 +++++++++
>  drivers/thermal/thermal_core.h | 5 +++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index b2390d9..23c8d6c 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -119,6 +119,15 @@ int of_thermal_get_ntrips(struct thermal_zone_device=
 *tz)
>  	return data->ntrips;
>  }
> =20
> +int of_thermal_is_trip_en(struct thermal_zone_device *tz, int trip)
> +{
> +	struct __thermal_zone *data =3D tz->devdata;
> +
> +	if (trip >=3D data->ntrips || trip < 0)
> +		return 0;
> +	return 1;

might be worth using 'true' and 'false', just for the sake of code
readability.

> +}
> +


I am not against this addition. I just request you to document it
accordingly.


>  static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 587ca5c..ed8ff05 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -82,6 +82,7 @@ static inline void thermal_gov_user_space_unregister(vo=
id) {}
>  int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
>  int of_thermal_get_ntrips(struct thermal_zone_device *);
> +int of_thermal_is_trip_en(struct thermal_zone_device *, int);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
>  static inline void of_thermal_destroy_zones(void) { }
> @@ -89,6 +90,10 @@ static inline int of_thermal_get_ntrips(struct thermal=
_zone_device *)
>  {
>  	return 0;
>  }
> +int of_thermal_is_trip_en(struct thermal_zone_device *, int)
this is supposed to be static inline.

> +{
> +	return 0;
> +}
>  #endif
> =20
>  #endif /* __THERMAL_CORE_H__ */
> --=20
> 2.0.0.rc2
>=20

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXCJOAAoJEMLUO4d9pOJWnY8H/2TV+jFX47rG5ffj8GWe9JCH
fxLrFmVHXJSepw4dbC/mpd35v6PL3s3fkZIn4+jTjJMTBM1EJGjZgOY23w9GwpzF
v/ArXo3IDrMWNRQefeRSJ6cXiNDoJmm/xoTFx4GI9p0fYU5PeWqrBHZDG4XDZBmc
eDmNaByROQ0QdPrfo7JnMD5rpM7X9qO5VyVheoeqxkvZWBElJGKVR9Cq4+b9V2Pr
Wf+jO6D7ypzCumcxnGFUGzwdiXj/DujQ+t0dWP5BQZpllzvu3ZB05K73nvacHvKm
9GWbIaCvZPYKAH5rJF5smc8dIOoufmVKXce9wvDoPhmXy+zOzlJuxJu15wjDC8I=
=34/2
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
