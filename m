From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Thu, 8 Jun 2017 21:27:33 +0200
Message-ID: <20170608192733.pry6ydf5auyaepyw@earth>
References: <20170430182727.24412-5-contact@paulk.fr>
 <20170528191619.GA20159@xo-6d-61-c0.localdomain>
 <1496249719.1774.1.camel@paulk.fr>
 <20170531173207.GA10763@amd>
 <1496258936.2038.8.camel@paulk.fr>
 <1496819733.927.16.camel@paulk.fr>
 <20170607075218.GA6268@amd>
 <1496848839.5534.7.camel@paulk.fr>
 <20170607195023.GA4083@amd>
 <1496916532.12882.2.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52plozhyq7desfqz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496916532.12882.2.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--52plozhyq7desfqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 08, 2017 at 01:08:52PM +0300, Paul Kocialkowski wrote:
> > > On Wed, 2017-06-07 at 09:52 +0200, Pavel Machek wrote:
> > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/
> > > > > comm
> > > > > it/?
> > > > > h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003
> > > >=20
> > > > Is there some documentation that explains what different power supp=
ly
> > > > statuses mean? Because without that, we can have long and useless
> > > > discussions.
> > >=20
> > > Well, I couldn't really find much except the following from Documenta=
tion/
> > > (which is not that helpful, and the BATTERY_STATUS_* don't seem to ex=
ist
> > > anymore):
> > >=20
> > > " STATUS - this attribute represents operating status (charging, full,
> > > discharging (i.e. powering a load), etc.). This corresponds to
> > > BATTERY_STATUS_* values, as defined in battery.h. "
> > >=20
> > > Generally speaking, I think the question to be asked is what informat=
ion
> > > users
> > > will be interested in in each scenario we have to consider.
> >=20
> > Hmm. We really should add some documentation :-(.
>=20
> Maybe we should start a new thread about this to give it more visibility.
> That way, PM maintainers could weigh-in and share thoughts.
>=20
> I definitely agree there is a need to clarify what we want to report to
> userspace given the various scenarios we've been discussing.

+1 for extension and update of documentation. If its known, that
the battery is trickle charged, it should report FULL. No need
to annoy people by constantly updating the status. Think of it
being mapped directly to a status LED. Of course the CURRENT/ENERGY
properties should still be updated, so that anyone interested in
the details can see them.

-- Sebastian

--52plozhyq7desfqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5pSMACgkQ2O7X88g7
+pqJxw/+OMtY11qS8zKqNhxbLqYQyvlxgB5fj+2+mlFn1DyA1TH3dWO93pZhNU68
pTMwK3xuBALy7yGroFp9Y9IE8FXAsNSmVJppBc6+W9Sc6dT5E30Ba27PQm6NZux/
p5+DmPorhYBoEH0nUEZ053s+7c+F/g2knQQp2MtxPpL1gsDIqXXAzqpyglQO+ctm
dSBZtSE0yHA+/96iRdbp0ezK2QZ5Uczw+M//+VG46+HwaJv8cAgD+hbad1F/3k7w
Xv7LPilzP8uxYZsGky5qk7QaiLNrAyVmbv7R6fDWQtWcaTHiJMYYwodDqMBQjugJ
z5dICTfUofnKI7JQWsE/J+2ol5C/vmO7aRcfugCOc5ou7Qe9zWkXU9WfO+uTIskB
PZVrzsO/eEsYitYg58aWP3ZfdF5U55IJ8cH3ljQohIB0ARFUAL4eVC6Mn108vN0X
KrRrJB49UkHqHWWcuG+h18lslfjnyznt8G1Abe0+h44wNUO5dcHDajDl6MKLHxEp
7s1Cr7T0PnPmHqWcjvJvOzkxb1rh/TeVWUos6rBfUTWmaCtyqqMXo4pP88Fi2xLY
9Fj1Qkql+yMj4mAs9AsPDPIp1bqAmnMfl+0JHtMQT7XRwja0Llytj5DnrZ3Ys7KC
t0srWLDbCwnxLEYdI6htxyCxZezt8fV3GIC2qSlRI9WyIYOZ/tA=
=AqUb
-----END PGP SIGNATURE-----

--52plozhyq7desfqz--
