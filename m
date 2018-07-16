From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/power/64: Remove VLA usage
Date: Mon, 16 Jul 2018 10:52:35 +0200
Message-ID: <20180716085235.GB3047@amd>
References: <20180716035657.GA32180@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716035657.GA32180@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-07-15 20:56:57, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
> shash directly and allocating the descriptor in heap memory (which should
> be fine: the tfm has already been allocated there too).
>=20
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXyd=
AacU1RqZWA@mail.gmail.com
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

, provided it was tested.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltMXNMACgkQMOfwapXb+vI+9wCfenj1oi0uIYHPJ4LnF7dw928B
9cwAnRgi+dMbNELIRRvVjqYJsnopTfR0
=D9UN
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
