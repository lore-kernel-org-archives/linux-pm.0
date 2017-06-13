From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Tue, 13 Jun 2017 14:14:36 +0200
Message-ID: <20170613121436.fnsexiir6hsigt3k@earth>
References: <1496249719.1774.1.camel@paulk.fr>
 <20170531173207.GA10763@amd>
 <1496258936.2038.8.camel@paulk.fr>
 <1496819733.927.16.camel@paulk.fr>
 <20170607075218.GA6268@amd>
 <1496848839.5534.7.camel@paulk.fr>
 <20170607195023.GA4083@amd>
 <1496916532.12882.2.camel@paulk.fr>
 <20170608192733.pry6ydf5auyaepyw@earth>
 <1496988961.1319.1.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rma2ys3q2ufmzivb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496988961.1319.1.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--rma2ys3q2ufmzivb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2017 at 09:16:01AM +0300, Paul Kocialkowski wrote:
> Le jeudi 08 juin 2017 =E0 21:27 +0200, Sebastian Reichel a =E9crit :
> > Hi,
> >=20
> > On Thu, Jun 08, 2017 at 01:08:52PM +0300, Paul Kocialkowski wrote:
> > > > > On Wed, 2017-06-07 at 09:52 +0200, Pavel Machek wrote:
> > > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.
> > > > > > > git/
> > > > > > > comm
> > > > > > > it/?
> > > > > > > h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003
> > > > > >=20
> > > > > > Is there some documentation that explains what different power =
supply
> > > > > > statuses mean? Because without that, we can have long and usele=
ss
> > > > > > discussions.
> > > > >=20
> > > > > Well, I couldn't really find much except the following from
> > > > > Documentation/
> > > > > (which is not that helpful, and the BATTERY_STATUS_* don't seem t=
o exist
> > > > > anymore):
> > > > >=20
> > > > > " STATUS - this attribute represents operating status (charging, =
full,
> > > > > discharging (i.e. powering a load), etc.). This corresponds to
> > > > > BATTERY_STATUS_* values, as defined in battery.h. "
> > > > >=20
> > > > > Generally speaking, I think the question to be asked is what info=
rmation
> > > > > users
> > > > > will be interested in in each scenario we have to consider.
> > > >=20
> > > > Hmm. We really should add some documentation :-(.
> > >=20
> > > Maybe we should start a new thread about this to give it more visibil=
ity.
> > > That way, PM maintainers could weigh-in and share thoughts.
> > >=20
> > > I definitely agree there is a need to clarify what we want to report =
to
> > > userspace given the various scenarios we've been discussing.
> >=20
> > +1 for extension and update of documentation. If its known, that
> > the battery is trickle charged, it should report FULL. No need
> > to annoy people by constantly updating the status. Think of it
> > being mapped directly to a status LED. Of course the CURRENT/ENERGY
> > properties should still be updated, so that anyone interested in
> > the details can see them.
>=20
> Agreed. Do ou think there is a need to start a specific discussion about
> various scenarios and how to handle them or do shall we just use common s=
ense
> here?

I suggest to use common sense and if anything is unclear send a
documentation patch, so that we have a basis for discussion.

-- Sebastian

--rma2ys3q2ufmzivb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk/1ykACgkQ2O7X88g7
+pq+5A//Uv+5Rn29G3AQYe8uDLJYzpbDT1ypHqst4dmmEckunvHax4BpYDKjPY5L
ewLDpZ64UYMTx/g+zT3H8ga8YrIHjKLx4fXAZwQSLB2dQOFPPbRqsH8sqQsdXi4X
1k7UgLPjq0yirSOrIY8Hv2JNZjXN0IFztjV8dg/RBavJzmjGDmw/3Y2BC1neoNjI
SwLaofxn0UgexSYHwDGKXDXm6NY8pd9QJLzm2QTE3/a0Bhg66y6NdFOT6W6Je2qc
FiICns1inhNcbtrHagT0Nxq9gosXxgb6nPn9whhzwC/XFEwEmfQ+Ha0drEVWq2VK
tJtaQiO201CGRCOqCHA+vHIlXGkLXA0zO0aCuv0jt2u9Wwc+h0EQetDK8tWIRZZM
4+fByaV1E84cBfjI+GUh54EmULMUwQosv21Vt9EoFFKsO8tuhmQ6HMINo44121kq
yHFvSrbK3ugx606xbmoG5PDI4mTgWKoqN8n+pbuAd+L7+11aLr18H/AvSC7X3nA5
VrchIlMEY9CU4GmpOoI4sNbwCiDcm3NqYHRBaHIb6pJTjAnHwq5TiXok5E+b2ydu
iyf7T3KBFftmrN8ccvsUu4PG155lJ9egb9itZuFAQWdxhp0U8w4T2q4fnFSoH2SQ
g95ab2vRL8b5tTCESzY3Uc83juz0I60TDx+s7vObkE2qot6t3q8=
=2msj
-----END PGP SIGNATURE-----

--rma2ys3q2ufmzivb--
