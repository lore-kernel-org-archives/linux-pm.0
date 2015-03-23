From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Mon, 23 Mar 2015 11:37:40 -0700
Message-ID: <20150323183740.GI14954@sirena.org.uk>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55380 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbCWSiK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 14:38:10 -0400
Content-Disposition: inline
In-Reply-To: <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, rjw@rjwysocki.net, kernel@pengutronix.de, dbaryshkov@gmail.com, pawel.moll@arm.com, galak@codeaurora.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, shawn.guo@linaro.org, sre@kernel.org, fabio.estevam@freescale.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, viresh.kumar@linaro.org, mark.rutland@arm.com, sebastien.szymanski@armadeus.com, marex@denx.de, devicetree@vger.kernel.org


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
> > Sascha Hauer <s.hauer@pengutronix.de> hat am 23. M=E4rz 2015 um 07:07

> > It is very unusual to describe the regulators of a device on a register
> > level like this and to iomemap each register individually. I think you
> > should drop the registers here and put this knowledge into the driver
> > like (nearly?) all others do.

> do mean dropping the base address of the regulator, too?

> How would you implement it (bare register address or regmap or syscon), s=
ince
> there
> are overlapping register regions for different driver?

> @Mark: What's your opinion?

This might be the sort of thing normally handled by a system controller,
I have to say I had assumed this had all been discussed in the previous
iterations of this seriee.

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEF1zAAoJECTWi3JdVIfQ1JsH/im8wTBhWKbNj+3o3UQwO5TL
JMOUN0sEraXzYQ1SfxaeAHq2977f57H5kU+UZiLfMm7ZBjlcdPynppi2/F9EqsYn
xADKjFwQ4Vr5bd9IJrzZyWF61K9ZsoLFc4EaPey/hmf3Ejb5Xf/4aMgVRrp0fWhw
LPaKvKQcpGyWVx2/LCMVJNUfrkMB/u2x30f7uDweu19EVEQ7tAeHfIfDfUZrcvfh
cmgwTqMuH+g2Ms/ncKwPJQiCBNKutuC8uWfDHmkdSQQvMhi5WpPPobNrQuoTICHF
q8jrGh+fLnh3h8FfDGjkmclzEkfx0rkkgaslICtJtV3eoBcOV9P33bpo61NrgEw=
=bRh2
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
