From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Mon, 19 Mar 2018 10:21:06 +0100
Message-ID: <20180319092106.GA5683@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Woody Suwalski <terraluna977@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >With recent linux-next, after resume networkmanager often claims that
> >"network is disabled". Sometimes suspend/resume clears that.
> >
> >Any ideas? Does it work for you?
> >									Pavel
> Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.

Thanks for testing... but yes, 4.16 should be ok. If not fixed,
problem will appear in 4.17-rc1.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqvgQIACgkQMOfwapXb+vIWDACbBChamJQ4Dj2h+S9X0mrWZEJ3
YHgAoII8QvqWob4gD3Gkkus2ahudfcKh
=faTm
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
