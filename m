From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: qcom_smbb: add regulator dependency
Date: Wed, 18 Jan 2017 17:07:56 +0100
Message-ID: <20170118160756.zsjt2nc6hg2zgjc3@earth>
References: <20170118151233.1529065-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ggpe3s4hblf6qz7a"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbdARQIB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Jan 2017 11:08:01 -0500
Content-Disposition: inline
In-Reply-To: <20170118151233.1529065-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tim Bird <tim.bird@sonymobile.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--ggpe3s4hblf6qz7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Jan 18, 2017 at 04:12:10PM +0100, Arnd Bergmann wrote:
> The added regulator dependency in the smbb driver causes build errors
> when regulators are disabled, e.g. in randconfig build testing:
>=20
> drivers/power/supply/qcom_smbb.o: In function `smbb_chg_otg_is_enabled':
> qcom_smbb.c:(.text.smbb_chg_otg_is_enabled+0x18): undefined reference to =
`rdev_get_drvdata'
> drivers/power/supply/qcom_smbb.o: In function `smbb_charger_probe':
> qcom_smbb.c:(.text.smbb_charger_probe+0x410): undefined reference to `dev=
m_regulator_register'
>=20
> This adds a Kconfig dependency to avoid the link error.
>=20
> Fixes: 61274eff0dde ("power: supply: qcom_smbb: Add otg regulator for con=
trol of vbus")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/power/supply/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 59f9841dc246..5f134cf8988c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -404,6 +404,7 @@ config CHARGER_QCOM_SMBB
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
>  	depends on OF
>  	depends on EXTCON
> +	depends on REGULATOR
>  	help
>  	  Say Y to include support for the Switch-Mode Battery Charger and
>  	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger

Thanks, queued.

-- Sebastian

--ggpe3s4hblf6qz7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh/ktcACgkQ2O7X88g7
+pqc+A/+IYy38yKEDHExhn6yKo26JkKcOkJOaWUf8KTMEaksiT9M4i5eCAzWO1H5
5gGVclXBB5ny82jy46g31Or+rbOFQM3sKap702489KuGB9/kaMN1fDgZl7rAp0CR
6zHd4SxyXPO45KEXlsxcU/ZPQ+udmE/4g5wugWpUqq8bvSWC5L6fIkrJePdG8UTc
aJhoLhU3VCVhKnrkkJ7VFJbF9UpoDSFCpYqLMVt2rv1fax/PayUaRj0P1O9Rpi8r
MzjnYQj38pTmOnZjk/xI0vgRz6aJ0p74rfQUch1vBBzE4UAGh6r6UNnKgMcOgIAw
uXA6J0NDFzBaHswtjY1jNT/Kt7W++pC6HCf39JSgTVGYNcXot+VjGu3ZzAnGyW8k
P04WveeiZweKWnx36eVtUuwvPkDrbsxcMgDS/Yl++YsGlxr+cstb6mT3nLFhe/Ag
6V1t8pc2C5m00x96QZlCsfudAbai+nDxaDXDc/SuNRWWUrb6jFweOk+krUjOAlQp
/9KafPVsJMBwVb74RZpCvr+VY21ZJ1zWOmX+HiILjk1FdFJUGYFTCUIgnnsojUko
IhJb3N42ULdqYzfXmmHIV7b0zZyEYZ3bSa59rgAy9pwuXPsFf4hDwUPzHTq0eVCk
uYXeREOPRUxeqYzkzt4GeaDNSw4Yo46N3m4Ul2ZY7PE3oQbLtfA=
=Nnv9
-----END PGP SIGNATURE-----

--ggpe3s4hblf6qz7a--
