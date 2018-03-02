From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 2 Mar 2018 10:05:46 +0100
Message-ID: <20180302090546.GB30267@amd>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-02 13:01:00, Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>=20
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

Can the rcu_read_unlock be delayed arbitrarily by userland code?

Is that ok with RCU?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZE+oACgkQMOfwapXb+vJ5bgCeM/co3MWj3kAQshb7/8RKlNG+
0tAAoJfEsFTH1kDbQDRBU/h31TIf6CQu
=Ts+6
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
