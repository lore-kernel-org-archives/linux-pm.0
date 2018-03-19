From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Mon, 19 Mar 2018 18:33:56 +0100
Message-ID: <20180319173356.GA28462@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <1521474008.20208.2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521474008.20208.2.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Woody Suwalski <terraluna977@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-03-19 10:40:08, Dan Williams wrote:
> On Mon, 2018-03-19 at 10:21 +0100, Pavel Machek wrote:
> > On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> > > Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > With recent linux-next, after resume networkmanager often claims
> > > > that
> > > > "network is disabled". Sometimes suspend/resume clears that.
> > > >=20
> > > > Any ideas? Does it work for you?
> > > > 								=09
> > > > Pavel
> > >=20
> > > Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> >=20
> > Thanks for testing... but yes, 4.16 should be ok. If not fixed,
> > problem will appear in 4.17-rc1.
>=20
> Where does the complaint occur?  In the GUI, or with nmcli, or
> somewhere else?  Also, what's the output of "nmcli dev" after resume?

In the GUI. I click in place where I'd select access point, and menu
does not show up, telling me that "network is disabled".
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqv9IQACgkQMOfwapXb+vKLVQCdHKSfD6Gendp0RBGYXYn0dU+A
WVgAnjd2MOtv/s8FpKJ0M96ZaHllzsuY
=w98g
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
