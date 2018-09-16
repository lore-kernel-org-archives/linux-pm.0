From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 1/3] power: supply: max8998-charger: Fix platform data
 retrieval
Date: Sun, 16 Sep 2018 13:47:10 +0200
Message-ID: <20180916114710.gc2hqxwtjqfgoc2r@earth.universe>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531843509-3533-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bdmw3abbzs6dkzjg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531843509-3533-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org


--bdmw3abbzs6dkzjg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 17, 2018 at 06:05:07PM +0200, Pawe=C5=82 Chmiel wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
>=20
> Since the max8998 MFD driver supports instantiation by DT, platform data
> retrieval is handled in MFD probe and cell drivers should get use
> the pdata field of max8998_dev struct to obtain them.
>=20
> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8998_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/suppl=
y/max8998_charger.c
> index b64cf0f14142..66438029bdd0 100644
> --- a/drivers/power/supply/max8998_charger.c
> +++ b/drivers/power/supply/max8998_charger.c
> @@ -85,7 +85,7 @@ static const struct power_supply_desc max8998_battery_d=
esc =3D {
>  static int max8998_battery_probe(struct platform_device *pdev)
>  {
>  	struct max8998_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
> -	struct max8998_platform_data *pdata =3D dev_get_platdata(iodev->dev);
> +	struct max8998_platform_data *pdata =3D iodev->pdata;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct max8998_battery_data *max8998;
>  	struct i2c_client *i2c;
> --=20
> 2.7.4
>=20

--bdmw3abbzs6dkzjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueQr0ACgkQ2O7X88g7
+pquGA/+LahovDgQ0kaDuCNocwO1fnE+fKt41U2UXPDIkSQus+r3DVQXJS8an+LU
RXpcw9MeLTIkBcWbQaSubxN8MW8IJk6bqEmRZKWTao/N2WQ/scaO/V+eFnja7Ksq
mLUbJ5H7B8mZ5pQXepMUxf+o8dfOz5e6wksrO/N9asjgNDZkiiCu9jOHZAYlap4u
QB3cnjusfvCVVTkd8kCC4nqc9MAmGHg7wzuFE9sBO3owjI6VQkoEwJr6eYm1ubOv
V6uxg0iIBLZiGKLO2zrPJt/p5XT7MVbraX+rXYDrBeGQ6KuN1Fvn3c08DKgmRGKj
i6WVmOBz+NWNhI8/dLIV9F+4199TMCcoJ3ktRS4+oElB6AQsKyWzxDk1+X9WwhAY
nXjrIa0L4pV66n9/C27Si4YmO/5fr08vNYBLRJIpWW+z/dECTd4hYQDZJtVkit1K
z/ruT+lb9wRhKx2hYaG+Mh40SFCbMWys7IGgpX/ifcHpNvh4/5GEmKk8KPfQq9gA
sbB8pkkM8wqDvO56bnwr+P3rRBQKBi+O4LQkqv64278gaiEyZWGnCUG4D9ZVVS5H
8efB/YqFpjTxFaeCpaRsRbr/7lXKWueF8mObvDU5iU3JE5QwzfviPbb4obknu3F5
rOZjogzmz8/Ah33xxY++ULXpYnU5Fyz3s3fF9CRFfu3ipGmiQZc=
=gYQ8
-----END PGP SIGNATURE-----

--bdmw3abbzs6dkzjg--
