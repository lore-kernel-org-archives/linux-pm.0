From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Sun, 19 Jun 2016 19:12:21 +0200
Message-ID: <20160619171221.GD2933@tetsubishi>
References: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
 <CACRpkdbFvRKpzY82qWpt6CNLEe8GfgaSOJPaebaanOWbT7mC9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbFvRKpzY82qWpt6CNLEe8GfgaSOJPaebaanOWbT7mC9Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This is indeed a generic problem, as we don't have a way to describe
> > these kind of dependences between devices. In other words, we need to
> > control the order of how devices becomes suspended/resumed. If that
> > could be done, we could likely avoid runtime resuming devices
> > unnecessarily.
>=20
> Correct, keep me in the loop and I can test some patches.

So, this patch is discarded in favor of a generic solution?


--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtJ0AAoJEBQN5MwUoCm2wOwP/0T15Gnvw4jeGYtQNnR1ifvj
Gwm5aeJYfPyrLKdjj7EF9sNsOLHbgkg2/X5BNnH7E0wyr/vKBmKqkihphn1z8QJQ
VB4rA7rUUvh12NgtAjOkl1XNWwFZVxxciK6mEwCOH+vEDMvCAY1RRe3q6+Rrq7Bn
QwbKetsDayKo+dT5c9jQ/aPIA28SvsIzu3qKxoisBxRK08nDW5IixZjR9lzo4FoK
l0z3LhK+3KZ41yKoC8ngj7lCXOKKOgylxigD9/DQrlyv2TV916Ocpyh5aJ8ZHF5K
tcGBrBtQOzVqQEXyaXE8N8mCXxa4lmNfjJ5eR64bi6b1x2p+89lUxHFpdMxrJCVQ
7xBth/qKPk/r2Go7+TX1X6ARvonvw9IBMEJkjf/X0uMbgTHaLZov3UKIUkJKrhV6
qX0YtnyilVCHti9s7FDfbna3XPRPQr4WbIxZsDmPpnWA1mCqLB4dIgW6z2ajxOrd
VnVaK21EpxYqP+Qjob2Dytp56zYmBXHxbqAzceYhfphh+aetF7S9fVy8k3GkeSFo
hmxti6257y5ojdJk3KzPh221uwgynZXealWY7X0gP1734HwPJW3ptD9W7PszWYXk
kt8TZiuiWJCbeTbz4hBoIj1+RamKoMnWk+f9gsaocKRHNXnViDQOliK0UW7/8JGL
xIYNFw1VEyDXWjU2/eGd
=BB84
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
