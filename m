From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] regulator: add mxs regulator driver
Date: Mon, 23 Mar 2015 11:39:12 -0700
Message-ID: <20150323183912.GJ14954@sirena.org.uk>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
 <20150322161425.GC6643@sirena.org.uk>
 <1459171144.549216.1427132741792.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55397 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbCWSjW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 14:39:22 -0400
Content-Disposition: inline
In-Reply-To: <1459171144.549216.1427132741792.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: rjw@rjwysocki.net, kernel@pengutronix.de, dbaryshkov@gmail.com, pawel.moll@arm.com, galak@codeaurora.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, shawn.guo@linaro.org, sre@kernel.org, fabio.estevam@freescale.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, viresh.kumar@linaro.org, mark.rutland@arm.com, sebastien.szymanski@armadeus.com, marex@denx.de, devicetree@vger.kernel.org


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 06:45:41PM +0100, Stefan Wahren wrote:

> > So, this isn't actually quite a busy wait because we do a schedule()
> > rather than a cpu_relax() but still it could devolve into that - 20ms
> > seems a long time to burn doing that. If we're expecting this to finish
> > very quickly can we do an initial busy wait then fall back to something
> > with an actual sleep or soemthing?

> We will need to keep the initial usleep_range(). So do you think of the
> following:

> 1. usleep_range
> 2. busy_wait for BM_POWER_STS_DC_OK
> 3. msleep (for the timeout case)

That's what I'm suggesting - do the initial busy wait for a reasonably
short time period and then fall back to something that sleeps.

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEF3PAAoJECTWi3JdVIfQw3AH/RPx5AyUsR3KhG9JEAyjbHDh
MleWOgIT0AlSqL9Lt4yuGueUcFRcsvWaikpFliPZZGwKjTgBJWgTF3wRh/s11Abr
dVPkkLd1ohCVtiomr5vPekJxe78JCC3ym7Fa4BefEtDrBO31fgBjapWsbouxAvrZ
KDPmCHvcDhDsLFwf5Uoxk84C590Ch3XPFjQR1nJDwDdq5a44LQWNShj3EaRsicLm
m70e33IW8Hkx2aMd81D0WKV2yD8d8obXREgV3p6YzHyR5w44dOw6mDAsWt75Iovw
X3nXyV3+MRHnvZR7A4T3TF4pwiqbYIwCf/0j/PxAS0gPOuY4dyICBe0Yd3Sg1Rg=
=IAuR
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
