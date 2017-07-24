From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: constify attribute_group structures.
Date: Mon, 24 Jul 2017 20:54:33 +0200
Message-ID: <20170724185433.aj4hvsqqarazgg2s@earth>
References: <cee17fda23a2dd44e9b0f7bb575282c4dd1e5f8e.1499859597.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yb3irozsxndmllin"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754758AbdGXSyh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jul 2017 14:54:37 -0400
Content-Disposition: inline
In-Reply-To: <cee17fda23a2dd44e9b0f7bb575282c4dd1e5f8e.1499859597.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--yb3irozsxndmllin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 12, 2017 at 05:13:22PM +0530, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
>=20
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    2673	    400	      0	   3073	    c01	power/supply/pcf50633-charger.o
>=20
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    2737	    336	      0	   3073	    bed	power/supply/pcf50633-charger.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Thanks, applied to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/pcf50633-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supp=
ly/pcf50633-charger.c
> index b3c1873..1ad7ccc 100644
> --- a/drivers/power/supply/pcf50633-charger.c
> +++ b/drivers/power/supply/pcf50633-charger.c
> @@ -254,7 +254,7 @@ static ssize_t set_chglim(struct device *dev,
>  	NULL,
>  };
> =20
> -static struct attribute_group mbc_attr_group =3D {
> +static const struct attribute_group mbc_attr_group =3D {
>  	.name	=3D NULL,			/* put in device directory */
>  	.attrs	=3D pcf50633_mbc_sysfs_entries,
>  };
> --=20
> 1.9.1
>=20

--yb3irozsxndmllin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2QmkACgkQ2O7X88g7
+po80Q//aPUaPmfmYpQUlAZDj7Sz7c4nYxoU0ly9XPHY2f15xxymWUdyRRJ4EKcJ
+jCaGPS+eFez3GAr+omLK7eUYDtI0ybDohqg2dH2wELFDUJxo2d9bmKfpgVKZgsk
tDJBsngDkaJZKiCNwujHZo5VWGxKnTMhRhX+RmlKO7djb4dSpIlGPMxMmrEWl8yM
GAgpcydN+hdFkopPzHdTs5tpJ2u/Jm1o/lkUEPO1v9EO1v9E8Z7yRPA8rQUZMCTU
7a2UlPrU+x8OI3olHBtFm1sQcujE7G4B0diJIKY2peUtPN35ACZlgH7LUhByCaQA
vbRxbIBVxwnyfLeuua82ijC2nNNImTNfNzDcJsBLN7x9FpzrmizHGXawCyqyThQg
V+bF7L+zXEcoy2FPFVFWMva80K1tSAWFdmrLXdNA8tHkwKi705mpI7yNp18nBlA3
xyQDUmBych6HorPfiHpWxW1J20il6QPwyhnV+x3J11s8wRdwVzQPGFvWD5s+FeJ0
tnNPr3ql+VC23dbJKWj/6OqK+N7Q31rDOMwHRKyWK5zRQul8k6mCozxLtA9APNa7
T4tvRL1rB5qXOyZguZPQBR6qGuRVQqjKE/oUZlMPeaG6aGRrNVy7LpT44aUhHb9J
FvngE6pmxjsRCcu1EeWvDpHns58o8syuxyr+Xns0oV+/M5wq+Qs=
=YklO
-----END PGP SIGNATURE-----

--yb3irozsxndmllin--
