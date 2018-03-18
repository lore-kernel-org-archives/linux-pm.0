From: Pavel Machek <pavel@ucw.cz>
Subject: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Sun, 18 Mar 2018 11:40:23 +0100
Message-ID: <20180318104023.GA10392@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With recent linux-next, after resume networkmanager often claims that
"network is disabled". Sometimes suspend/resume clears that.

Any ideas? Does it work for you?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlquQhcACgkQMOfwapXb+vL50wCeMsJykRLMDJ2eCf1pIKFtIgBp
uKcAoKRXiht1B4ehkcZr2/VndouIdkp8
=UqP1
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
