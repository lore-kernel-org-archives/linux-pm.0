From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Wed, 25 Feb 2015 14:52:24 -0400
Message-ID: <20150225185223.GG2306@developer.amazonguestwifi.org>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
 <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
 <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
 <20150224195201.GB353@developer.amazonguestwifi.org>
 <1424881442.7759.22.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:44793 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbBYSw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 13:52:28 -0500
Received: by pdbnh10 with SMTP id nh10so6774304pdb.11
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 10:52:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424881442.7759.22.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas,

> >=20
> > I am copying Srinivas here too. Srinivas, do you think that option (1)
> > above will break things in userspace on your side?
> I am not sure distros like ubuntu starts Linux Thermal Daemon on ARM
> systems. This has option to take over thermal control from kernel by
> changing governor to user space. I take writable trips as a way to get
> threshold temp notification for users space governor by setting offset
> from a read only passive/active/critical trips. This way we get notified
> before, to monitor an do proactive control. For example if there is a
> critical trip at X, take action at X-a to avoid shutdown.

Let me ask differently. If the trip points are read only, would the
daemon still work?

If not, the change needs to make writable in x86 builds, right?

BR,

> Thanks,
> Srinivas=20
> >=20
> > >=20
> > > Cheers,
> > > Punit
> > >=20
> > > >
> > > >
> > > > BR,
> > > >
> > > > Eduardo Valentin
> > > >
> > > >>=20
> > > >> Comments welcome.
> > > >>=20
> > > >> Cheers,
> > > >> Punit
> > > >>=20
> > > >>  drivers/thermal/of-thermal.c | 6 +++++-
> > > >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >>=20
> > > >> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-the=
rmal.c
> > > >> index 668fb1b..b7ad5c0 100644
> > > >> --- a/drivers/thermal/of-thermal.c
> > > >> +++ b/drivers/thermal/of-thermal.c
> > > >> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
> > > >>  	for_each_child_of_node(np, child) {
> > > >>  		struct thermal_zone_device *zone;
> > > >>  		struct thermal_zone_params *tzp;
> > > >> +		int i, mask =3D 0;
> > > >> =20
> > > >>  		/* Check whether child is enabled or not */
> > > >>  		if (!of_device_is_available(child))
> > > >> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
> > > >>  		/* No hwmon because there might be hwmon drivers registering */
> > > >>  		tzp->no_hwmon =3D true;
> > > >> =20
> > > >> +		for (i =3D 0; i < tz->ntrips; i++)
> > > >> +			mask |=3D 1 << i;
> > > >> +
> > > >>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
> > > >> -						    0, tz,
> > > >> +						    mask, tz,
> > > >>  						    ops, tzp,
> > > >>  						    tz->passive_delay,
> > > >>  						    tz->polling_delay);
> > > >> --=20
> > > >> 2.1.4
> > > >>=20
>=20
>=20

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hnbAAoJEMLUO4d9pOJWjeYIAI72xfcAKKCbnlBWM1EgpaeF
gqPMi36VF3SL6OTOs5Qgz1xU8LxrzdxVTV9TLhKqPTn0h83NlZYgyG8zo8bFrAIl
ZU5EB4zUI+KXoj/l9THqsjoGt8t8hUiNf017DC1zZ4k+p4Ue3AUwDw+Rd0gF1BtL
T+OrojTA/KFOp8jE4e8k9sVLRUogQ48i2GHHAkqlFXGdVbHnR/XynpuyWLj9iEda
Ke7xJGhbXcmezDDbXYndWquSGX2fDAk0LemHeVIK6mp9/p2z8eh7NkD1eHzcywLU
7nPO3K4nx6OBp+qNUN/JrGRNmSw1vTsxwkHFP/NLDP8peKifZPL2bJPQz/rUKR4=
=QNhG
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
