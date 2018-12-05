From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: add ability to specific
 active and inactive delays
Date: Wed, 5 Dec 2018 22:45:56 +0100
Message-ID: <20181205214556.vb2ssgkubdtgj5fx@earth.universe>
References: <20181111214538.32477-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqvzxmalnkykoqhl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181111214538.32477-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org


--qqvzxmalnkykoqhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 11, 2018 at 10:45:38PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
>=20
> Similar to gpio-reset allow to specify active and inactive delays
> while keeping the 100ms defaults that were used previously all the time.
>=20
> The dt-properties are named the same as in gpio-reset but get an "-ms"
> suffix as properties should contain such a suffix specifying its unit.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
>  drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.=
txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> index 6d8980c18c34..3e56c1b34a4c 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> @@ -27,6 +27,8 @@ Optional properties:
>    it to an output when the power-off handler is called. If this optional
>    property is not specified, the GPIO is initialized as an output in its
>    inactive state.
> +- active-delay-ms: Delay (default 100) to wait after driving gpio active
> +- inactive-delay-ms: Delay (default 100) to wait after driving gpio inac=
tive
>  - timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
>                specified, 3000 ms is used.
> =20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index 38206c39b3bf..52525b6c18db 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -26,6 +26,8 @@
>   */
>  static struct gpio_desc *reset_gpio;
>  static u32 timeout =3D DEFAULT_TIMEOUT_MS;
> +static u32 active_delay =3D 100;
> +static u32 inactive_delay =3D 100;
> =20
>  static void gpio_poweroff_do_poweroff(void)
>  {
> @@ -33,10 +35,11 @@ static void gpio_poweroff_do_poweroff(void)
> =20
>  	/* drive it active, also inactive->active edge */
>  	gpiod_direction_output(reset_gpio, 1);
> -	mdelay(100);
> +	mdelay(active_delay);
> +
>  	/* drive inactive, also active->inactive edge */
>  	gpiod_set_value_cansleep(reset_gpio, 0);
> -	mdelay(100);
> +	mdelay(inactive_delay);
> =20
>  	/* drive it active, also inactive->active edge */
>  	gpiod_set_value_cansleep(reset_gpio, 1);
> @@ -66,6 +69,9 @@ static int gpio_poweroff_probe(struct platform_device *=
pdev)
>  	else
>  		flags =3D GPIOD_OUT_LOW;
> =20
> +	device_property_read_u32(&pdev->dev, "active-delay-ms", &active_delay);
> +	device_property_read_u32(&pdev->dev, "inactive-delay-ms",
> +				 &inactive_delay);
>  	device_property_read_u32(&pdev->dev, "timeout-ms", &timeout);
> =20
>  	reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL, flags);
> --=20
> 2.18.0
>=20

--qqvzxmalnkykoqhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIRxEACgkQ2O7X88g7
+po/chAAj9WAvSKB5fCxfb/ay63NwY/Z0ukx6mORLwKoUmWMuNnRgIYJCgVPywG9
OFQq/G+jEZqHfoO+AlVqCUvIDVx8RdCj5SGzCna8rvnUfrVxmyDTi12atOPWoSIT
VPewQ5WWcOPbCBh3P6LbqBMhW2XIUBzYDW3OraKj2TplTWxFE5CnC258Ale+kw3a
7jiXAF5v071m4jYt6D7JwApK150kfKABmxjySrYe58KJ7y/4Q3ke2+MeHQBLjK92
xUOJfnGLdEj4K5W6a47fhG7/LewV1aWbLTr2WB5LBdEOpgdu2OwMder6BHlMz+23
NeUKJwM3Ff5CGNO7tDkg0u7gZmeXhxctHctnFBXYjYVax5YDr1pUlGQF0dJxpECd
7YxkqFfRopL/qvI/hpnMed9Bf1LZyZPvuzK1DKjryWS8WFEAljUR1dhFXVaV69EF
Rb7pyNrJQFYIG7T2aFjekqslpCGy79Jl6oK51vSaXRmGeHXJERiLhE6Gu716hVvp
EKjYTdT2dDbzO4fdBIDxcfBr/E+aG8GTb3vFNFaBcYAG8aXWQpL5HSxUorMFUOlL
DWxcPCC8+gOk0p6AMdCWWdeIT0V8a3HWg2Ig01j2NXWHTusLsbkYKHt1iWNunrMv
8lUDVnxAy1hvPSn7F/DXZyDKIJotk56yWJSDWLwBiHFGlw3sHmA=
=HNvj
-----END PGP SIGNATURE-----

--qqvzxmalnkykoqhl--
