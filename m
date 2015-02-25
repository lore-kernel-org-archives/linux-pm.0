From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Wed, 25 Feb 2015 15:00:38 -0400
Message-ID: <20150225190037.GH2306@developer.amazonguestwifi.org>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150224182124.GB3448@developer.amazonguestwifi.org>
 <20150225144849.GA2904@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225144849.GA2904@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 02:48:49PM +0000, Javi Merino wrote:
> Hi Eduardo,
>=20
> On Tue, Feb 24, 2015 at 06:21:26PM +0000, Eduardo Valentin wrote:
> > On Wed, Jan 28, 2015 at 05:00:35PM +0000, Javi Merino wrote:
> > > +
> > > +k_d
> > > +---
> > > +
> > > +`k_d` configures the PID loop's derivative term constant.  It's
> > > +recommended to leave it as the default: 0.
> > > +
> >=20
> > I know we are considering K_d =3D 0. However, ...
> >=20
> > <yet another big cut>
> >=20
> > > +	/*
> > > +	 * Calculate the derivative term
> > > +	 *
> > > +	 * We do err - prev_err, so with a positive k_d, a decreasing
> > > +	 * error (i.e. driving closer to the line) results in less
> > > +	 * power being applied, slowing down the controller)
> > > +	 */
> > > +	d =3D mul_frac(tz->tzp->k_d, err - params->prev_err);
> >=20
> >=20
> > ... Shouldn't the above d component consider the rate of changes over t=
ime of the error?
> >=20
> > I would expect you should do:
> > d =3D k_d * (dE / dt)
> >=20
> > or
> >=20
> > d =3D K_d * ((err - params->prev_err) / sampling_period)
> >=20
> > in plain C:
> >=20
> > +	d =3D mul_frac(tz->tzp->k_d, err - params->prev_err);
> > +	d /=3D tz->passive_polling; /* might require fixed point division */
>=20
> Could do.  To be honest, both k_d and passive_polling are constants so

Yes, I agree that they are constants. But if you deploy the thermal zone
with different sampling period on different devices, then the behavior
will change.

> I don't think you get anything by doing this other than the added
> complexity of the fixed point division.  As you said, the default k_d
> is 0, so I'm not strongly against it.

OK. Then I would prefer to add the division, as it makes the code aligned
to the concept.

>=20
> Cheers,
> Javi

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hvMAAoJEMLUO4d9pOJWSbMH/jRTr2K7MlHAADtC45YwZz52
PXbB5cbcNrGG/nBab82wOhF8Z9xbNh4VlAbrTTQRmNSnVNEfjv2m5VpBBAkX/OVk
elxlZgF/1WCiEwFDWyWAetv9numxR8QV5JaoMOgQPqiWeBVbD32Cfv0tZXTT0DMi
fZPk7TFu4q5BS20kgyRW0yHZdrshBMKPqKXNztvbl2PBHiOognt9YzEPwbsDD9yN
6KwJareYzpptZx7iU8xKpeqhNBAUukQ10i11Qi8mOK1FJ3Wtd+pad96jHp7YPzD6
PMetq2hSE9gVN7X3G8tWtezRZM4D2yoZB/oywRwU9wsK/Es6KuqgijsK3/uglPI=
=z5ss
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
