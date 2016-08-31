From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 07/11] power: act8945a_charger: Add capacity level
 property
Date: Wed, 31 Aug 2016 16:56:23 +0200
Message-ID: <20160831145622.a5pmhddb5fqpzy5z@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-8-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sr2c5r4qnkz35osj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934021AbcHaO46 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 10:56:58 -0400
Content-Disposition: inline
In-Reply-To: <1472109599-21915-8-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--sr2c5r4qnkz35osj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:19:55PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
>=20
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

[...]

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..a983de2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -77,7 +77,7 @@ config BATTERY_88PM860X
> =20
>  config BATTERY_ACT8945A
>  	tristate "Active-semi ACT8945A charger driver"
> -	depends on MFD_ACT8945A || COMPILE_TEST
> +	depends on MFD_ACT8945A || GPIOLIB || COMPILE_TEST

This looks wrong. You probably wanted (MFD_ACT8945A && GPIOLIB).
But since the gpio consumer headers defines stubs for the !GPIOLIB
case just drop the dependency.

>  	help
>  	  Say Y here to enable support for power supply provided by
>  	  Active-semi ActivePath ACT8945A charger.

[...]

> +	charger->lbo_gpio =3D devm_gpiod_get(dev, "active-semi,lbo", GPIOD_IN);
> +	if (PTR_ERR(charger->lbo_gpio) =3D=3D -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(charger->lbo_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"lbo\"\n");
> +		charger->lbo_gpio =3D NULL;
> +	}

Please use devm_gpiod_get_optional():

charger->lbo_gpio =3D devm_gpiod_get_optional(dev, "active-semi,lbo", GPIOD=
_IN);
if (IS_ERR(charger->lbo_gpio)) {
    err =3D PTR_ERR(charger->lbo_gpio)
    dev_err(dev, "unable to claim gpio \"lbo\": %ld\n", err);
    return err;
}

-- Sebastian

--sr2c5r4qnkz35osj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxvAWAAoJENju1/PIO/qabzsP/RyOlhVt5NvTTPjYLIjj1KNr
OMqi2ya5id9Nr5EUU8w57BAncW7q+qbB0gDjRR9JjbhfU2ZFJporD87DpOKYFPbZ
0UWS8kvN6Yj5COW+pvd1dm1jsrncAMMNJwaRajV2MdZDq6gNVs9I6VjQdXOqb9lX
3pYgeEeBYYp23DY0adx94LtdCCEaLn+pqqJ5/t08M/EmATUR1bGy1rlQJexj85xV
x2U0mTBAq60OEtxkJOMXazwaw4WqIHK6D9kWY+gtCaNSBy6p3AvKSh7MtG8hjtqE
U3bt+OenJLSMfYSVtY4RPMhlZaWy4hEoqoKP6nWhvOraM2b6vwUNuNTb8n62Us2q
5FVdBQx9s6WOeTT/2H5fUDNUsdQPy0mNEm8fYxLo6Ba4ofFjeB9TYqkIAKIAzPuV
OxtZywtEDPIz+HUzOitpOx5K8BCQyhqnTRMdhFLdiCQTd8cxxGhWm6+b/AeOZ6T8
P1FqgXLqQd5Onv7Dk9LGu8kGQ8L/z7GrFhjZ+3MCV1oBx6JUNS1xMdC4F1AlsIxg
HS1xj9Ki5AR/IGpjsICAsFpzL5Wm81s45G5hdhpAvcd4xzoD+ZyJIuvQhivhoLTv
hAVJvU5zj4+D2NCMTGHmEUF6ecBFeIIZKvtmj6BocnoPJWxZ0aQDqg9u01il6aAs
jKYeaUVE2ppMOSOFkFL3
=w4ku
-----END PGP SIGNATURE-----

--sr2c5r4qnkz35osj--
