From: Pavel Machek <pavel@ucw.cz>
Subject: next-20190408: Suspend/resume problems on Thinkpad X60
Date: Mon, 8 Apr 2019 19:39:28 +0200
Message-ID: <20190408173928.GB13260@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It boots ok (unlike mainline -- I'm debugging that), and I can suspend
and resume... but then cursor in X is moving and I can talk to
applications cached in memory, but any access to disk hangs.

Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrh1AACgkQMOfwapXb+vK9kgCfWu7Sxwj52spkyQk5yiLtavag
Q4gAnju8ZnFVdGD6sMbXC4fzN8nOeLxl
=C0vm
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
