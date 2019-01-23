From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH -next] power: supply: core: remove duplicated include
 from power_supply_core.c
Date: Wed, 23 Jan 2019 19:31:06 +0100
Message-ID: <20190123183106.xs7ga7gqwhp5a55q@earth.universe>
References: <20190117071143.14652-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2rowui6hqeukn5r4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117071143.14652-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--2rowui6hqeukn5r4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 17, 2019 at 03:11:43PM +0800, YueHaibing wrote:
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Thanks, but I already merged the same patch from Yangtao Li (who
sent it a bit earlier).

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 569790e..07a85e1 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struc=
t work_struct *work)
>  }
> =20
>  #ifdef CONFIG_OF
> -#include <linux/of.h>
> -
>  static int __power_supply_populate_supplied_from(struct device *dev,
>  						 void *data)
>  {
> --=20
> 2.7.0
>=20
>=20

--2rowui6hqeukn5r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIsuoACgkQ2O7X88g7
+prU2RAAl4lM2vuRA0NKpqctn1kTLuY7tTn2y8N4BaHCdk9L9F/E0Ig9aOuNf4mn
V/IIJj73SCTZOFDzfDEdDAM96STNWmwIzmzoj3DDf8GEiHaqNFblhue6Ij/HyG0+
zQljKUW3ri6LIDvslq7iKWRZps1Z5metom3wljYpif6+VieaCncS7mROzKiIEBP9
q4TG7E6TWY+ogiM5Zhtywgds23OyK8+nffE1ek/4s1PSPUwIpcg/hZqUlkWHg/4l
bSr3j9A1Y4cWML0vmNVyzkubYuc8juA6gXAKKiH1P0GZqalM3fHnNHqcfcTpS9i2
TqkHrhsMofsztW5VbO53/sJjtEv0nikjXh7cuJEyLj3SFzVqe8N72QLAlg/viIy3
r2LwiRedNssU00dS6oYLnMX2kLVGrdivQj8F+14dD7dytlZHMisPdGbiw/Bx0975
9Jw9IJMVoyvywfm1fg4yv+hunHaJVQPAlc5hE2c20RKGresNtdbyUqz4bEvih6QZ
Y+bWlo1qawq9LJuZDskNAal2aoPwz+rpgzYFmdLQx8aN9BTqGF8yeNUktDi5NtVT
hWkYezk7PsWylEKBn/Awwy3fDXI0AuIgjLv46Rb62ig17e6nwqkgTiegHgjMvSiM
uK7Gr6HOG3Aw+whT4gZo4vYOikm6jCbeRA/nS6UM4uPeHe23PoQ=
=5cFx
-----END PGP SIGNATURE-----

--2rowui6hqeukn5r4--
