From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] i2c: let I2C masters inherit suspend child ignorance
Date: Mon, 11 Apr 2016 07:58:13 +0100
Message-ID: <20160411065813.GF18319@sirena.org.uk>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
 <1460035237-12037-3-git-send-email-linus.walleij@linaro.org>
 <CACRpkdb7r02E990LJEPwLWuZgPeK2w_jg054kFk12wxSUPY02Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59158 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcDKG6Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 02:58:24 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdb7r02E990LJEPwLWuZgPeK2w_jg054kFk12wxSUPY02Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 11, 2016 at 08:53:40AM +0200, Linus Walleij wrote:

> If everyone agrees that i2c devices should never require the bus
> to be resumed, we can of course use the big hammer and
> just:

> pm_suspend_ignore_children(&adap->dev, true);

> Same for SPI. (And w1, ...)

> Thoughts?

That seems better.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXC0sEAAoJECTWi3JdVIfQvroH/1wW6MjGgasd7tkwAQSzPNV3
rjzSKhxeDLfUximkq2FlC2Bq9nemVzyC1f5tjl36pmZOl0ga6ceJ8VEhQn0W92/m
tm9x6ZIFZZWqvfAv5SX3vtwbMyxwaVHCMl1nHiXA7n5Y/9xZ9KJlUOIGNLcvibpJ
tn7bT68FE07ZOBcUX3lpigYcskvMEVCIc4QMumvHvCuuae79o8hwb/pyHTCI6TIp
LChT3+DQXepwokRfjmUg56sHw1DJTanX2MPdfHLki4XSQV15SxKHCqrtaVbO+6GI
yGYS/Uso4gxtCek6hQnuo10bLJmuJgNrUXgSSZJnykXd3KwlxYOiVNRKYGtlWDw=
=Vvsp
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
