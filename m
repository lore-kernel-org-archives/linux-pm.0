From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: [regression] Please add bug 15788 and 15969,
	usb sound / radeon kms broken after snapshot cycle
Date: Mon, 31 May 2010 22:15:04 +0200
Message-ID: <201005312215.17793.Martin__19292.1674381525$1275336970$gmane$org@lichtvoll.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8556294127621980306=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============8556294127621980306==
Content-Type: multipart/signed;
  boundary="nextPart1372653.zhlqzsHAFM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1372653.zhlqzsHAFM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Rafael,

please add

Bug 15788 -  external usb sound card doesn't work after resume
https://bugzilla.kernel.org/show_bug.cgi?id=3D15788

to your regression list.

And

Bug 15969 -  radeon regression couldn't schedule IB on resume with 2.6.34-
rc7=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D15969

Thanks.

I find it irritating that a stable kernel is released with regressions like=
=20
this, but that seems to be what I can get for not waiting for 2.6.34.2 or=20
higher.

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1372653.zhlqzsHAFM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwEGMkACgkQmRvqrKWZhMdAgwCbBdJwVp317zPLsQJcr0+fsHzk
6+4AoIUVFZF5DOUVof0Ifj1AEp155JWn
=9kYJ
-----END PGP SIGNATURE-----

--nextPart1372653.zhlqzsHAFM--

--===============8556294127621980306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8556294127621980306==--
