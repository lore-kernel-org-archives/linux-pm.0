From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] bq24735_charger: add status property to
 view/enable/disable charging
Date: Mon, 15 Feb 2016 05:58:26 +0100
Message-ID: <20160215045826.GA28626@earth>
References: <1452630659-4935-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41676 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbcBOE6b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Feb 2016 23:58:31 -0500
Content-Disposition: inline
In-Reply-To: <1452630659-4935-1-git-send-email-peda@lysator.liu.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-pm@vger.kernel.org, Peter Rosin <peda@axentia.se>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 12, 2016 at 09:30:59PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>=20
> Hi!
>=20
> The hw I have tested this on does not have the IRQ line of the
> charger connected, so I have not actually tested how setting the
> chargeing status interacts with the threaded interrupt handler.
>=20
> I hope it's ok to grab a mutex in a threaded interrupt handler?
>=20
> Cheers,
> Peter
>=20
>  drivers/power/bq24735-charger.c | 90 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)

Thanks, queued.

-- Sebastian

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwVrvAAoJENju1/PIO/qa/V0QAIT6XJWbPhwTHyMHYk1Pd78j
q1QOQ2D0cEWaD1//R0kiQQd4ZB/yvZuf9mqa1YF8gia2wWOyoOJa4uqrWwSaReuG
/1G1jcYOV6l4nmp2q+2Zb5qhEKO7Az03EQ6fkSGLB+UFSVApYN1bTMf4O2R+zq4K
r3h/m+IYrSLUACiDCYc5CXhjV8w8WzVyDcQWkuYFOStWY9yitLiyR+npaoG6jEE6
aFdnU6nGO0qiaxu9IIVPEL4ByoYvdGBr+sKu8fYjjUcyqMmmRS6onrQlfBRZ0Vaw
iy+JxqXyGxSVNlxjPL9CaFHZehSIWkuzRWnfvQ3eo3v3fKKxcdhfkSjR8Q5NE/CK
79Ms8kde0QPCAwddifg8Oa/EzNIMRwVhaD/ULYJEm7OdMXvmnFWCDV5lcOOzW45B
bfiOQbLdrYda7Ib+bbAAyZ4KxQJWxzJGk+xJiDIhyd8lrrG1iKCA5sZACfCMhL/V
JYpfFsJliftYkIcJKs0iFjdaFQE7xje1WZu6JlwlCpmtLRjVu8kU2mwHRyMHbwVE
8bfxBSBmWu17TZGVwyIJHeDUWECCPM/AD0iYU2wJDNQbl8Z/BDNVuBCQr0nCUYln
xM/QAnETeVYjyU+r6Efj4YEnMctkwwnh/80Gvg3y95N6bHR884+QEiJZAW4SdvI0
QfL30LjEYcFsChqHEMMx
=vrK1
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
