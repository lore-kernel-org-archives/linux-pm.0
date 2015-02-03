From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Tue, 3 Feb 2015 15:19:55 -0400
Message-ID: <20150203191951.GA3486@developer.amazonguestwifi.org>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150202235120.GC4855@linaro.org>
 <20150203130336.GA2896@e104805>
 <20150203043102.GG17425@developer.hsd1.ca.comcast.net>
 <20150203173211.GD4855@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41664 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966015AbbBCTUB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 14:20:01 -0500
Content-Disposition: inline
In-Reply-To: <20150203173211.GD4855@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Javi Merino <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 10:32:11AM -0700, Lina Iyer wrote:

<big cut>

> >
> >Well, I am not convinced drivers really need to be aware of these trip
> >types. Which kind of drivers are we talking? Thermal zone drivers?
> >cooling device drivers?
>=20
> I am sorry, I am missing the point here. The Tz driver is requested to
> return the type of an enum and if the enum is not shared, then how is
> the driver expected to know what to return.

Yeah, however, the only requirement I see for this governor is to have
two passive trip points.

> >
> >Lina, do you have an existing driver (it can be yet to be posted) that
> >would required using these types? To my understanding, these are simply
> >for the governor internal control, drivers do not really need to underst=
and
> >the difference from one to another.
>=20
> I am currently prototyping Javi's patches on QCOM existing solution. So i=
ts all WIP.

I see.

> >
> >The purpose of the .bind_to_tz callback is exactly to verify if the
> >driver has added the required info into the thermal zone. Including the
> >trip setup.
>=20
> I may be completely off-base here and my understanding of trips is
> questionable. But it seems like even with this callback, the driver
> expected to know what the particular governor defines and needs from the
> TZ.  The definitions may overlap and may mean different things in
> different governros. To me a TZ driver should not care what the
> governors are, but define some common parameters that any governor can
> work with. Am I making sense here?


And that's is what I want to keep across the framework. Thermal zone
driver should not really be aware of governor details. Ideally, the
driver should provide a thermal zone that can be usable by different
governors. That is the ideal setup.

If we allow this new governor to have its own trip types, we will be
segregating thermal zones. And that should be avoid if possible.


>=20
> >
> >Besides, the existing exposed trip types are sufficient, given that this
> >series is in a working state. Unless we have a valid use case to change
> >/ add trip types and expose them to driver, I would prefer to keep this
> >simple.
> >
> >Side note, drivers/thermal/thermal_core.h has symbols that are not
> >exported. As drivers can be built as separated modules from thermal
> >core, I would not recommend include things in that header. The symbols
> >that are EXPORT_SYMBOL'ed are in thermal.h under include directory.
> >
> >>
> >> Cheers,
> >> Javi
> >>
> >> > I dont think anymore, this should be a enum thermal_trip_type, but i=
t has to be
> >> > generic across governors.
> >> >
> >> >
> >> > Thanks,
> >> > Lina
>=20
>=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0R9MAAoJEMLUO4d9pOJWL14H/0lg5brBh2iQEob1UpVUT0LE
owBLdCONSoFKLZaaw1Cx9qbXvQo1hECBWC9W0LdlRk30k1iIIfpB7coNPprHUZ2m
yf/lduEtWKonBA/vgZud3h0YzeV5Bh7IUKp9OfBow+olLqekLRWkMWZpGvWE9ZwK
apGFAOdrWQdnIjGk4akZzzR2mjNb6YBuM/2yHTTh0i6z2IAi8L6sGcDl+jj3dsxF
Q1Tww3ABgLgHyEoC5FJAgrBLu2DKpzw5w+k3tWicmex7R9IaZnVvREoI9yNaYxxU
lqUNT16/VaVBQ2cCDhD2xOsYVtzcrFfalAXPHT9VwKxLXZVRTr3j0GGbTfNaCLo=
=r///
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
