From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: max17040: Change register transaction length from
 8 bits to 16 bits
Date: Wed, 19 Oct 2016 05:02:03 +0200
Message-ID: <20161019030202.4djh4lzbthjlm6wj@earth>
References: <1474467454-4958-1-git-send-email-liuxiang_1999@126.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="no2fmvcejkjsv6ql"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbcJSDCL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 23:02:11 -0400
Content-Disposition: inline
In-Reply-To: <1474467454-4958-1-git-send-email-liuxiang_1999@126.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liu Xiang <liuxiang_1999@126.com>
Cc: linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, Liu Xiang <liu.xiang6@zte.com.cn>


--no2fmvcejkjsv6ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 21, 2016 at 10:17:34PM +0800, Liu Xiang wrote:
> According to the datasheet, MAX17040 has six 16-bit registers.
> Register reads and writes are only valid if all 16 bits are transferred.
> Any write command that is terminated early is ignored.
> So it's better to change register transacton length from 8 bits to 16 bit=
s.
>=20
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/power/max17040_battery.c | 52 ++++++++++++++++------------------=
------
>  1 file changed, 20 insertions(+), 32 deletions(-)

Thanks, queued to for-next.

-- Sebastian

--no2fmvcejkjsv6ql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBuIqAAoJENju1/PIO/qa/lgP/RrluJT5YWjbnAdQraQfYNGi
ZHGpzDJ4JNWkzxSCBecIwcCfvImDbqC5Rxw51Y7jrjI3Vvoi9waUnZOPHYVW5nTH
kH8/hWJrNw3WEgmSw8AGdnJ3kXwhl7zzzBhWbTo8cgB10IrSyCbSrSNDZlOwG4DH
vXartN+t0sYrJaiI5n2o4nkrUo0TjwziuhNHFvEcaDu/fUB5fVojBHwP5ynLmdzM
PXpNiA4whO84sZK+iHzq/kno6JRKG5lnOdSXtKb6uGE7iqKE865nEESkwvfLkCP/
VTgF1Ya1qwDcc5PmLT21CJ5d54nbNV3OzS+zt7/T36h+IKdyfQbV9MuWWOP+ppF5
xcW79iaw5079TGUfWNR9fPZPi5G5wqXykT3puscEm9QYEOVwQjgSr8y7tQI8zzY5
vaUQqu6Fvbr8gmPOKtdrP+3+b7kgoAYuuj4wyLq7RbLRHbYRIZPwSj0Sb11/MXnq
aYOmHor3bwrRR8QZmbZ+eA0gQpF3jN6hsQfc7BoYcgRTIRKh5Urmp9bG7Thgb1+2
FN75D+6VDlO7ccAPRF25bkMarLS7cFO2Q9nhEk1uyhZP05P0YJncOEFxFHysgFON
skHa7quhlh0UeVDn7e6UMk2uttmzzZhzYcjcC+kbnyGC7kElSKZKzpPAEBu62P2E
0yVFjWcr3G3tBJRk/z0k
=Grf+
-----END PGP SIGNATURE-----

--no2fmvcejkjsv6ql--
