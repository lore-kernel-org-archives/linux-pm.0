From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 18:46:26 +0200
Message-ID: <20170715164626.GA1373@amd>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <2497538.J9F6XFeBfd@aspire.rjw.lan>
 <20170715062838.GA20741@amd>
 <5864280.u6UQBsuXnA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5864280.u6UQBsuXnA@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I had an idea of using an enum type encompassing all of the power sta=
tes
> > > defined for various platforms and serving both as a registry (to ensu=
re the
> > > uniqueness of the values assigned to the states) and a common ground
> > > between platforms and drivers.
> > >=20
> > > Something like:
> > >=20
> > > enum platform_target_state {
> > > 	PLATFORM_STATE_UNKNOWN =3D -1,
> > > 	PLATFORM_STATE_WORKING =3D 0,
> > > 	PLATFORM_STATE_ACPI_S1,
> > > 	PLATFORM_STATE_ACPI_S2,
> > > 	PLATFORM_STATE_ACPI_S3,
> > > 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> > > 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> > > 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> > > 	...
> > > };
> > >=20
> > > and define ->target_state to return a value of this type.
> > >=20
> > > Then, if a driver sees one of these and recognizes that value, it sho=
uld
> > > know exactly what to do.
> >=20
> > Remind me why this is good idea?
>=20
> Because there are drivers that need to do specific things during
> suspend on a specific board when it goes into a specific state as a
> whole.

We have seen driver that cares about voltage to his device being
lost. That's reasonable.

Inquiring what the platform target state is... is not.

> > If board wants to know if certain regulator stays online during
> > suspend, it should invent an API for _that_.
>=20
> Ideally, yes.  However, that may be problematic for multiplatform kernels,
> because they would need to have all of those APIs built in and the driver
> code to figure out which API to use would be rather nasty.

Lets do it the right way. Big enum is wrong.

We already have

struct regulator_state {
       int uV; /* suspend voltage */
       unsigned int mode; /* suspend regulator operating mode */
       int enabled; /* is regulator enabled in this suspend state */
       int disabled; /* is the regulator disabled in this suspend state */
};

 * struct regulation_constraints - regulator operating constraints.
  * @state_disk: State for regulator when system is suspended in disk
  * mode.
  * @state_mem: State for regulator when system is suspended in mem
  * mode.
  * @state_standby: State for regulator when system is suspended in
  * standby
  *                 mode.
  =20
=2E So it seems that maybe we should tell the drivers if we are entering
"state_mem" or "state_standby" (something I may have opposed, sorry),
then the driver can get neccessary information from regulator
framework.

I don't think it should cause problems with multiplatform kernels.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllqRuEACgkQMOfwapXb+vJyjQCff/ikow5ZnJKpH/6a9boy9YoY
eJMAniFJspQNCEePCb57GkI3D34o2tk/
=nvfD
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
