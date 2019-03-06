From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
Date: Thu, 7 Mar 2019 00:10:14 +0100
Message-ID: <20190306231014.GE7915@amd>
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
 <20190125135403.10228-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125135403.10228-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-25 14:54:03, Marek Szyprowski wrote:
> This way devfreq core ensures that all its devices will be set to safe
> operation points before reboot operation. There are board on which some
> aggressive power saving operation points are behind the capabilities of
> the bootloader to properly reset the hardware and boot the board. This
> way one can avoid board crash early after reboot.
>=20
> Similar pattern is used in CPUfreq subsystem.

This looks somehow dangerous to me. I guess this will break someone's
shutdown, and on battery-powered devices, that's quite bad thing to
do.

Could we explicitely do it only for devices that need it?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU1YACgkQMOfwapXb+vLpVgCgxNfYJNgv05kCYb+TXTPK9KxX
iY4An3feW6xYMNG8mtqu/hUR6pIuhtUY
=UcWr
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
