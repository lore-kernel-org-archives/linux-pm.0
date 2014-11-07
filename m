From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide number
 of non critical trip points
Date: Thu, 6 Nov 2014 21:41:55 -0400
Message-ID: <20141107014152.GD10180@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-4-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412872737-624-4-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 06:38:39PM +0200, Lukasz Majewski wrote:
> This patch extends the of-thermal.c to provide information about number of
> available non critical (i.e. non HW) trip points in the system.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/of-thermal.c   | 12 ++++++++++++
>  drivers/thermal/thermal_core.h |  5 +++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 23c8d6c..cd74e64 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct thermal_zone_device=
 *tz, int trip)
>  	return 1;
>  }
> =20
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *tz)
> +{
> +	struct __thermal_zone *data =3D tz->devdata;
> +	int i;
> +
> +	for (i =3D 0; i < data->ntrips; i++)
> +		if (data->trips[i].type !=3D THERMAL_TRIP_CRITICAL)
> +			continue;
> +
> +	return --i;
> +}
> +



I am not against this addition. But looks like we start to spread some
specific APIs that may not be used to other drivers. Maybe having a
single API to provide a read-only copy the list / array of trips might
be a better approach. I will think of a better way.

I also request you to document it accordingly.


>  static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index ed8ff05..334a7be 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -83,6 +83,7 @@ int of_parse_thermal_zones(void);
>  void of_thermal_destroy_zones(void);
>  int of_thermal_get_ntrips(struct thermal_zone_device *);
>  int of_thermal_is_trip_en(struct thermal_zone_device *, int);
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *);
>  #else
>  static inline int of_parse_thermal_zones(void) { return 0; }
>  static inline void of_thermal_destroy_zones(void) { }
> @@ -94,6 +95,10 @@ int of_thermal_is_trip_en(struct thermal_zone_device *=
, int)
>  {
>  	return 0;
>  }
> +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *)
here, it is supposed to be static inline.

> +{
> +	return 0;
> +}
>  #endif
> =20
>  #endif /* __THERMAL_CORE_H__ */
> --=20
> 2.0.0.rc2
>=20

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXCNXAAoJEMLUO4d9pOJWxPQH/1u/wBxvV5fp3q1lZbK1tF7B
IXs0L3+GqhXMZhnqtvHly18fP1NEq3q/LeYsOKIo6WlvBj9ZRez5L5g2P1tatR43
iFc8odMu4N2f7HPKpMKeYr8qtbfpUZGK7OqtC95Gt1UVzea7OxGX2ghFC1cV6KSh
nXTJD8PSSKaH8QzaqrEbO3aCaP+HX5ck1LlH5W7wrSK70Mdnr6kSHw7l78Pf5SZZ
ChyH0Z4V2xh5XCaQj+vdVdMNCKdke39aV+UUtUayTtxFkOQjt61oU0Fg0RLTjbyR
oEDPvJE8hgmUu4qfmIAv4qN5iewUnCFVOhyp/MPkePFQauAoKXD3OXC+V/KD/b0=
=B51x
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
