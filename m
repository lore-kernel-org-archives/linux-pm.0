From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 7 Jun 2017 21:50:23 +0200
Message-ID: <20170607195023.GA4083@amd>
References: <20170430182727.24412-1-contact@paulk.fr>
 <20170430182727.24412-5-contact@paulk.fr>
 <20170528191619.GA20159@xo-6d-61-c0.localdomain>
 <1496249719.1774.1.camel@paulk.fr>
 <20170531173207.GA10763@amd>
 <1496258936.2038.8.camel@paulk.fr>
 <1496819733.927.16.camel@paulk.fr>
 <20170607075218.GA6268@amd>
 <1496848839.5534.7.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496848839.5534.7.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, 2017-06-07 at 09:52 +0200, Pavel Machek wrote:
> > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/comm
> > > it/?
> > > h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003
> >=20
> > Is there some documentation that explains what different power supply
> > statuses mean? Because without that, we can have long and useless
> > discussions.
>=20
> Well, I couldn't really find much except the following from Documentation/
> (which is not that helpful, and the BATTERY_STATUS_* don't seem to exist
> anymore):
>=20
> " STATUS - this attribute represents operating status (charging, full,
> discharging (i.e. powering a load), etc.). This corresponds to
> BATTERY_STATUS_* values, as defined in battery.h. "
>=20
> Generally speaking, I think the question to be asked is what information =
users
> will be interested in in each scenario we have to consider.

Hmm. We really should add some documentation :-(.

> > If you have 40Wh battery, and you are charging it with 1mW, I don't
> > believe you should be indicating "charging". That battery is
> > full. Yes, even full batteries are sometimes charged with very low
> > currents to keep them full.
>=20
> That makes sense. Note that this patch was however designed to solve the =
problem
> the other way round: my device will report full battery when the PSU was
> disconnected and that it is, in fact, drawing significant current.

That is documented / correct behaviour sometimes. Thinkpad batteries
have thresholds -- lets say 100% and 95%. They charge battery to full
(as expected), but then they won't start charging battery again unless
it drops below 95%. So you can have "battery full, charger
disconnected" state.

[Design like this prolongs longevity of li-ion batteries.]

> > And I'm not sure what this is supposed to do, but its quite strange
> > code.
>=20
> Could you comment on what is strange about it? This function corrects the=
 status
> based on the current flow as explained through this thread.
>=20
> > +static int sbs_status_correct(struct i2c_client *client, int *intval)
> > +{
> > +	int ret;
> > +
> > +	ret =3D sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
> > +	if (ret < 0)
> > +	   return ret;
> > +
> > +	ret =3D (s16)ret;

The last line ... is strange.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlk4WP8ACgkQMOfwapXb+vKMxACfZLPTnqVxmPswDhknxfT5rQgL
9YgAnj1oRLWKaDQw8ai5uhj1OdfNkEvg
=oHTe
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
