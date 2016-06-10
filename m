From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power/reset: make syscon_poweroff() static
Date: Fri, 10 Jun 2016 03:54:54 +0200
Message-ID: <20160610015453.GD5848@earth>
References: <1465410534-29694-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45528 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbcFJBy6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jun 2016 21:54:58 -0400
Content-Disposition: inline
In-Reply-To: <1465410534-29694-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 08, 2016 at 07:28:54PM +0100, Ben Dooks wrote:
> The syscon_poweroff() function is not exported or declared for
> usage elsewhere, so make it static to avoid the folloiwing warning:
>=20
> drivers/power/reset/syscon-poweroff.c:33:6: warning: symbol 'syscon_power=
off' was not declared. Should it be static?
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks, queued.

-- Sebastian

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWh3tAAoJENju1/PIO/qa67kP/jXld50ky0qOP2xUTk6dgLTV
qyztrN+AKd3X6Sp1pwJmNl2t2j9uwb/YY6jiN44Ptd1xZZ6G8g8p9iIqRr7RHVEP
IY6xUrNOw/sCDnvfuuL+SZWUJIYYIvDGo6u7NBZesf+qimljuyAgGQEHwsP8SQt8
eCTf906Sz7f3piuPnwDHyBFV2nR7YhI8lYWPdPmqzjwOu2TN03I7GrQdqsNCynfF
GvBzawoxw5U9D/dvMFOIr6B9iXIVIWdV9FEXtZaodjKCQ1HgcBWdCRkuZPG6xr47
mmqJvj7yHtSGQyMB699QPFJf2vThUkxqge+cQbCFkvKFcj3zEogUYiRAyUK9Gr0/
Iwm0ecfS4eqy66tfc/4i+ke6n1K7vrl0LDTKHk9c6U02ZnLECqdyAju/W3isLKnV
iLA7xjwvHXixKvy135JXa0UVNeIY/LcaUQY2lpGrYSBviHVgdcxuX4+O/sANsoon
10C+IhAZbmFLLqqNLlo3GvdhsTNZwDJ6bSUjf2vqs6OAqBsWYYOr3vfcz0f5FZwj
JcA6uTD3164aFo9MOFi3oIDpMd7oHYAH54W3huR/cqpJ3NXMJDL26D9A9kvMJ6CG
1aybu+bWE3NZmsFoNfNbg4NMpTl5jYroGORkxUsFQxNO1w8lq7RFpobH1Th2VmHM
V9vZfSJOsEs79l5zh789
=4O8H
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
