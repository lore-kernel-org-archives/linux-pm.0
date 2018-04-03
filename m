From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / QoS: mark expected switch fall-throughs
Date: Tue, 3 Apr 2018 12:49:50 +0200
Message-ID: <20180403104950.GI6758@amd>
References: <20180330211844.GA23072@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330211844.GA23072@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 16:18:44, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXE4ACgkQMOfwapXb+vLkmgCbB80CiFmKMNG0Tmeor6hhbyLK
TcMAnji0LXVnZPoM7yx6f1vo8KQNh4Pe
=BzI7
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
