From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide number
 of non critical trip points
Date: Fri, 7 Nov 2014 12:06:32 -0400
Message-ID: <20141107160630.GA23549@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-4-git-send-email-l.majewski@samsung.com>
 <20141107014152.GD10180@developer>
 <20141107110551.5316836f@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141107110551.5316836f@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Lukasz,

On Fri, Nov 07, 2014 at 11:05:51AM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > On Thu, Oct 09, 2014 at 06:38:39PM +0200, Lukasz Majewski wrote:
> > > This patch extends the of-thermal.c to provide information about
> > > number of available non critical (i.e. non HW) trip points in the
> > > system.
> > >=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > ---
> > >  drivers/thermal/of-thermal.c   | 12 ++++++++++++
> > >  drivers/thermal/thermal_core.h |  5 +++++
> > >  2 files changed, 17 insertions(+)
> > >=20
> > > diff --git a/drivers/thermal/of-thermal.c
> > > b/drivers/thermal/of-thermal.c index 23c8d6c..cd74e64 100644
> > > --- a/drivers/thermal/of-thermal.c
> > > +++ b/drivers/thermal/of-thermal.c
> > > @@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct
> > > thermal_zone_device *tz, int trip) return 1;
> > >  }
> > > =20
> > > +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *tz)
> > > +{
> > > +	struct __thermal_zone *data =3D tz->devdata;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < data->ntrips; i++)
> > > +		if (data->trips[i].type !=3D THERMAL_TRIP_CRITICAL)
> > > +			continue;
> > > +
> > > +	return --i;
> > > +}
> > > +
> >=20
> >=20
> >=20
> > I am not against this addition. But looks like we start to spread some
> > specific APIs that may not be used to other drivers.
>=20
> Why do you think that this is a specific API? In the thermal OF we can
> define trip point as "active", "passive", "hot" and "critical".
>=20
> With the first three we can handle them and properly react. For the last
> one SoC's PMU will power down the board.
>=20
> Do you know if any board (e.g. from TI) is NOT supposed to shut down
> when "critical" temperature is passed?
>=20

So, my point is not really about the usage of trip points. It is just
that the of-thermal  API will grow with in a wide way with specific
functions to check some property on the trip point array. And not all
drivers may be using these function, e.g. the above proposal.

> The real problem here is the accessibility to __thermal_trip and
> __thermal_bind arrays.
>=20
> Use case:
> In the Exynos driver we do need to initialize TMU registers with
> threshold temperatures.
> The temperature is read via tz->ops->get_trip_temp() [1] (from
> of-thermal.c).
> Unfortunately, the current API is not exporting the number of
> non-critical trip points to know how many times call [1].
> Of course we could by hand instantiate [1] n times, but this looks for
> me a bit clumsy.


I understand your use case. My point was simply that this use case may
be specific to your driver (or few drivers).
>=20
> Additionally, we now have implicit assumption about the order of defined
> temperatures for trip points, but I think this is not a big issue.
>=20
> > Maybe having a
> > single API to provide a read-only copy the list / array of trips might
> > be a better approach. I will think of a better way.
>=20
> Definitely. Exporting available trip points is crucial.
>=20

Yeah, I think it is the best thing to do. Share a read-only array / copy
of the needed data, and then drivers would check what ever property they
need from the array. Just make sure you document that this is a
read-only array (i.e. any possible change they do, won't affect the
original array).

> >=20
> > I also request you to document it accordingly.
>=20
> Ok, I will do that.

Cool!



>=20
> >=20
> >=20
> > >  static int of_thermal_get_trend(struct thermal_zone_device *tz,
> > > int trip, enum thermal_trend *trend)
> > >  {
> > > diff --git a/drivers/thermal/thermal_core.h
> > > b/drivers/thermal/thermal_core.h index ed8ff05..334a7be 100644
> > > --- a/drivers/thermal/thermal_core.h
> > > +++ b/drivers/thermal/thermal_core.h
> > > @@ -83,6 +83,7 @@ int of_parse_thermal_zones(void);
> > >  void of_thermal_destroy_zones(void);
> > >  int of_thermal_get_ntrips(struct thermal_zone_device *);
> > >  int of_thermal_is_trip_en(struct thermal_zone_device *, int);
> > > +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *);
> > >  #else
> > >  static inline int of_parse_thermal_zones(void) { return 0; }
> > >  static inline void of_thermal_destroy_zones(void) { }
> > > @@ -94,6 +95,10 @@ int of_thermal_is_trip_en(struct
> > > thermal_zone_device *, int) {
> > >  	return 0;
> > >  }
> > > +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *)
> > here, it is supposed to be static inline.
> >=20
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif
> > > =20
> > >  #endif /* __THERMAL_CORE_H__ */
> > > --=20
> > > 2.0.0.rc2
> > >=20
>=20
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXO38AAoJEMLUO4d9pOJW340IAJ3XdZUVp2QIKN73ATrMMJc7
UAU+KVyYuw8G+STErnnbOp0l8zrMs19PrGplwqAWqJWO3PL9J1VtkrI7tePzQBkO
Sv6A48TqkdnHtFbUD2ox7hodQNEPTssNVywmRGL1rNhlirmQqTl09EyNMazcI9kS
iFJWdv/i9HW4cZXBOVfdPNPGHd77L1rT6CzpkaP1I9+GV5dpzc5yRPjiqL8dMs6G
IsY8m+NiC95FzwJOn4MgtbxwamAdwaip8F/uED8eEs4QRpW+JSZGdpWWCO5cQxY2
pIoxB5ht7OXEL/tQPA8A2JHcMor3gKV9uRCIof7QrQii3IvCpgaTbZ5GpjvFDQg=
=hdQa
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
