From: Pavel Machek <pavel@ucw.cz>
Subject: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 09:50:47 +0200
Message-ID: <20180404075047.GB9342@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404165559.4cd0c12c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Please do not add any v4.18 destined stuff to your linux-next included
> trees until after v4.17-rc1 has been released.

On thinkpad x60, suspend does not suspend at all with this -next
version. Previous versions suspended/resumed fine but broke networking.

Any ideas? I guess bisecting on next would not be easy?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrEg9cACgkQMOfwapXb+vIqTQCgkKTm03QvrJlJu/vS1Hv4PrmE
mdQAnjOF4HybehpJqY0cFnYQuogd8PJu
=yUi4
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
