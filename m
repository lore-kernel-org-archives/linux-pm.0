From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: bq27x00_battery: add bq27510 support
Date: Sat, 28 Feb 2015 17:09:42 +0100
Message-ID: <20150228160941.GA886@earth>
References: <1425129492-25053-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60674 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbbB1QJz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 28 Feb 2015 11:09:55 -0500
Content-Disposition: inline
In-Reply-To: <1425129492-25053-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sat, Feb 28, 2015 at 02:18:12PM +0100, Alexandre Belloni wrote:
> Add support for bq27510 to the bq27x00 driver.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Changes in v2:
>  - corrected the bq27x00_battery_read_cyct changes

patch looks fine, but does not apply. Please rebase on top of:

git://git.infradead.org/battery-2.6.git branch/master

-- Sebastian

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU8ehCAAoJENju1/PIO/qayWAQAJARyGn0EnVTtwKqJkxCv2lz
mYcxNwDjfVHZBZ8HOHyPrXmLFRwW37uuBDoKmNRFUx8IjsGiQA4Qdk56E1SFi/Bw
k+80NjkQiNu25Qc3vRh+JDSqRwsLic33JKfsqTLAvAT8KYziiByZav2U57XZ3IsN
dvPt6AU5nqK3Cp9Vy0EwIu7Sq+m1fjWz+Kxtpp1UjFFolmIBwx2lSXYzhKQzNrWZ
If4voqRAXnJp0YWkPYLoCC1lsHhfLfMz9LGGjtDh4tEudiR5Ce14C1D+cORsgeKn
/8xyzGvUvcoRlxdLDhZ0X+LA2oagcrRn2suVwpT2BOn2PI9iTmVk1z6P/uzugscf
X7vYGP1NCBhOUDbpPcR+1uWqzlt/wnTA7nqudPiTFNEuTvZWJWyXqXFh0wvpnPyB
6WMnwYY0qjfRfot67/dz98Rh0sNlER+kmYDsTzUup13Pqx8kuthXSHs//fL+Zg3g
r3WbVxvyJDu+/BdhbmiFKFqWTQqakEGLm7Iu4XXWmuMGCskvZa0qCEgtg0XzkuEA
YHMU1ZvCkW7C4jJQSyRIsJjYt5jVUbz1lI2xGZ2Uaz4WLmHnW4Feid33VnXoDzP2
gJLzz4HJyxc+an4m7Mcm+8JQrR5wsZnC1zTbdJVUVKqtgd9+JJv8cT4dsiqcVsVx
WZOmJoG/bfwhWEnBXQGf
=2kza
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
