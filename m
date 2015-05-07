From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Thu, 7 May 2015 19:52:16 +0100
Message-ID: <20150507185216.GP22845@sirena.org.uk>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4fsOrigxu51SYCTq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55091 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbEGSxe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 14:53:34 -0400
Content-Disposition: inline
In-Reply-To: <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, fabio.estevam@freescale.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org


--4fsOrigxu51SYCTq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 08:37:18PM +0200, Stefan Wahren wrote:
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 4. Mai 2015 um 22:34

> > i'm sorry, i forgot the following point in the changelog:

> > - move dcdc handling from mxs_power to mxs-regulator

> > I hope the change is okay. I implemented only is_enabled() to have at least 1
> > operation.
> > But it's not really necessary.

> do we need enable / disable operation?

> In the bootloader code enabling the DC-DC is critical. There is a known issue
> which falsely triggers the brownout detection.

Why would the driver not provide these operations?

> > > I'm also not 100% clear what code the DCDCs and LDOs are
> > > sharing here...

> > Actually only probing and the regulator info structure.

> How can i improve that?

If the devices aren't sharing code then they should be separate drivers.

--4fsOrigxu51SYCTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS7RfAAoJECTWi3JdVIfQmGoH/10VsepwZEibzdV2dY6UO9lu
mmNB2eoQRn+vJddku1a6LpJwIIfUMXOFe8TymVUoRp0qjmHfJViMR/NgkJRhWkJd
2hwoZ8nuxrHw8Qf0NQVwqGwp4pyLnNy4qOX+czJnQQQnniUjZfkoZ2+t1vN7cFiN
UirXeTZ38dRj3QuIDEa7l8t4+CNP/7N6PJgG2w2BkscCsPG9Q22JPPABhDJpfaIv
ssDaut+siwaaCMDvBKC1HAiBo05qjGXGtkM/pkR7TpD+CV73sUvhZgR+jUwcieYz
tD0nj3eBgnfObip3kcZDXxLrTSpcUPowLzyeAR0eUfPOkSRX7WKVQ7Cm1egKaaE=
=NGkv
-----END PGP SIGNATURE-----

--4fsOrigxu51SYCTq--
