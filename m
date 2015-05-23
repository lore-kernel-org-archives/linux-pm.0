From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
Date: Sat, 23 May 2015 19:41:49 +0200
Message-ID: <20150523174149.GA16004@earth>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55006 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbbEWRmK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 May 2015 13:42:10 -0400
Content-Disposition: inline
In-Reply-To: <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 29, 2015 at 10:32:24PM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators.

I'm not sure what you need the power supply class for. I see only
one property (ac connected), which is constant. Maybe just drop
the power supply stuff?

This would leave an almost empty driver, which just sets a single
register at probe time and probes more drivers. That would probably
be more fitting for the MFD subsystem.

-- Sebastian

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYLvYAAoJENju1/PIO/qaWZgQAKTotBXJc/t0NyNC+3zsDnZ9
uFfUgy2L0akB0TvLlq88jQ1d/QUo9laBalCft5dNIPsIHa/hAEPmjb78y5CDyVfj
0eGCLRLU50fPPArqxhZ+Fudn6ShPr9k6okqkm74E7kYm3rzgQgiz+RCHuY/WxLIO
jABJ0ZhFqMBGdONhDpH5fk1oZRCtaetb9ycWkSx2M2g1D4QPXUhf/cy2j76cJe6y
nYsTdnGlUECVmZhioBRrMxJ71BK8RqL/5gDXxJ9ZVkzz4eR8Y1c1Qkvq4G2pWAZK
EeHO+vcYIkAkySYH2EaL7P+1oFkJ5gY/NAxKy4aN/UVrQ4wSnH7Z/PgvS7laBhTD
GYjQ4eBvsXS/Z85RZngT3cmZ90cKksJlaexhUnFX1PZ/lrgSh1DnIlzWnodyfjFQ
I8BDETmm84oEO8oor1gcScjL/kfqLRmFhR3zx2oi3D3FgEabaiMA0uX40qC24HLm
p03lXgHnfif6JbNqDy9IA+Y2j5K9HI/BgnVY5nkBIwk4pROS7QocmtaeLjTRMS/w
lqCuiaEtNdbcOOowa/EsJq7HGpgU0uozUKgoLtpsfemqinlLuDMBhqbMdAS7hmZN
oZhFmOtXBTTJT8ZCwm6aESu1txsZF5l2QhZFUjH63SxfKc8q8XVEjnbvCf6ULrou
LtkZRiBkRyQiFTth/xDI
=j6CL
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
