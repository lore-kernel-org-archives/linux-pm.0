From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] RFC: spi: let SPI masters inherit suspend child
 ignorance
Date: Thu, 7 Apr 2016 10:06:11 -0700
Message-ID: <20160407170611.GW1924@sirena.org.uk>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
 <1460035237-12037-4-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51104 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbcDGRGT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 13:06:19 -0400
Content-Disposition: inline
In-Reply-To: <1460035237-12037-4-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 03:20:37PM +0200, Linus Walleij wrote:
> This patch is analogous to the I2C patch preceding it

Please write standalone changelogs so people can understand what the
patch is supposed to do from reading the changlog.  They'll have to
follow the change later on when looking at it in git.

> and the reasoning is the same for all slow busses
> where the master device should only wake up when
> messages get transferred rather than constantly
> babysitting its children.

This isn't really about the bus being slow, it's about the bus being
able to usefully pause itself.

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBpOCAAoJECTWi3JdVIfQFR0H/0gi9iv/5ADqXf5d3BNDgYiO
bZDRFB/B9rpIIBQhCzipx+5lBrxhZKX7lgB+r81QLRDGhZbKW5CPcIpNNPXVWOpo
KiUu5umXmD8mXrRUQEPZw+1M7/ZCjKxJl79qRxdSyNw4WL2Vwl76SxnPnTq8/CB3
BCXEraPdYzm6qgjpgYRKc/JKTFk26xJSqSFk79PRJOLkG+EGnQpSw65cKyGAg+DX
GT0MJgQ2NVB1w50kH4vlqtZ9lp4NR4ZoQnDuOGTIPrIYvvkDUANJWUHgeHvry9GR
jPnCkmi1Aw1OdjUR9OPlj8Fv8btkN8KfhlmcSSHlALMXJ3haxgaMeNLLpq9A/ww=
=f4k3
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
