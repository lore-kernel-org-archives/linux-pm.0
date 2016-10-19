From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Wed, 19 Oct 2016 04:51:55 +0200
Message-ID: <20161019025154.rmw56aoh27wbrene@earth>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2q5xdcuobqbjdsq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbcJSCwA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 22:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20161005155112.13774-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--x2q5xdcuobqbjdsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 05, 2016 at 05:51:12PM +0200, Hans de Goede wrote:
> The i2c subsys does not load modules by compatible, only by
> i2c-id, with e.g. a modalias of: "i2c:axp209".
>=20
> Populate the axp20x_i2c_id[] table with supported ids, so that
> module auto-loading will work.
>=20
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x-i2c.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index b1b8658..d35a5fe 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
> =20
> -/*
> - * This is useless for OF-enabled devices, but it is needed by I2C subsy=
stem
> - */
>  static const struct i2c_device_id axp20x_i2c_id[] =3D {
> +	{ "axp152", 0 },
> +	{ "axp202", 0 },
> +	{ "axp209", 0 },
> +	{ "axp221", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);

Thanks, queued.

-- Sebastian

--x2q5xdcuobqbjdsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBt/HAAoJENju1/PIO/qalTYP/2lO8RLM4WjTIRm4heNIVhPl
UwfKkryenJaEFSbFDUE6XXNAbNFhP6BHfRHfcCriiAYsUM21CCGM8PAvwqYks/hf
u7MoDLXap3jHAubSMKFh7yjbc+8UuQTQnCWMnCX/cnHTlilYcZe2cbaxaV7DFTIM
txYXxtPZCIu8il0gf12QZluKSuhI5zzeSjhfAKRISLPjERLYjPI2LuZ1qV/DuLqc
pmXe6noVuOrLLCVJdV/eYPwxjF6CDJaK6/taRM5+hFnRXBEVmjaLZXGl/cTgzjT3
UaPSKvSN2LjxdN0gpuR3UkuKZr07oEgbCrNtTgo1GzJiXqaKUFvxFUrgDP9OiObN
FeJg3HDH231hxw3KmYs3wbmetlftI1oEjmKHLLpjFx2yBgtmPjrY75pHrCZgr7vv
/zrSZDXfOZvBToTbfKqNrpYckiqfA6jUkQ8rHCEIwn1LzTQT71lFYaFRnfnbO6AT
tleJMwXumGBTkCATeUDzsBjflNwZs5v6+z/qIbTRPhoQZkLBDIA/bcxlrFMjUjLP
WAXaf8hLl3CmjlysVuYsIVMKOAm8qQ0L9NKjoBloFe0CrWWF4YvCN8aSD8eyO7+d
cuP9yj6Ur5DTezLrthLYZsKA1vQ6ol5Y7G+d078rUHkEVJfHirK6n+Gh4u0NYWh+
OkEbPYhAOujvYCU14qUY
=id/V
-----END PGP SIGNATURE-----

--x2q5xdcuobqbjdsq--
