From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] power: max17042_battery: Use reg type instead of
 chip type
Date: Tue, 31 Mar 2015 17:31:55 +0200
Message-ID: <20150331153155.GA25737@earth>
References: <1427808847-19498-1-git-send-email-beomho.seo@samsung.com>
 <1427808847-19498-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51610 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbbCaPcW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 31 Mar 2015 11:32:22 -0400
Content-Disposition: inline
In-Reply-To: <1427808847-19498-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-pm@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 31, 2015 at 10:34:05PM +0900, Beomho Seo wrote:
> [...]
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> -		if (chip->chip_type == MAX17042)
> +		if (chip->reg_type == MAXIM_REG_TYPE_MAX17047)
>  			ret = regmap_read(map, MAX17042_V_empty, &data);
>  		else
>  			ret = regmap_read(map, MAX17047_V_empty, &data);

Looks like you inverted the logic.

> [...]

-- Sebastian

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVGr3oAAoJENju1/PIO/qak+wP/RXL3MdWqdryd9QTYcTSlqiw
qiZAlGsWGnnPPWpLftWvF8ADnWaAa6lKUS6o9uZTKZBKCG0Iz41Y/4XfH2Fpx8mk
rc09rUq2FsQmZ+bnqURhKNHCuRBgvVL0wHGntMSfeI/tYuEuHAOo2f2fRHwggXAI
elz8+2p6449EPBRIfh5B2jE5ZpOHVqXS3hp+bNoAyLw037/mU2nfVQrelGZUt5cu
stQRSiIbVU/DB9fzQTUVtWOytYcG1Mm6P9JmZrygTCF3FN9xy7p0MAZTevscbCWe
MEeqIqu94Kov7pmTEiiZoeD9OCkZS/N2Nu67FTTqx/QvvvTKB17qmmKiIx9F4iQ+
sEcfiNb68MJsWTg4UsO5R4415kgsy5pBc0UhRM7l4S98Z5sxyWIqZwWjJHfVjf/+
v+LhTNiMtyQYgOc0qVwHGP59ZYh8TCsS2kPH1KAvCF7N1RwG+da6nvm1A50ktFL/
8GmkOVDmC2dwmuZ/KUGR1Ya+rzmag29SEAoQVe1suBnbgq8mte5JVXUSbsvhvcRl
O2LaeF/m31E1MMiLepzf27jtG1JuoIKQKHOg5LOlxkNn4HoQsIKuosxejEq6UMTv
owFMr/uipgylbKyGYempl/Hy7CBFYXWu0CU8Y3UCGOnk62Wp+BLgrXVItVeLU1AN
/MNpKCL1c6xYVs+bsw4S
=2LL9
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
