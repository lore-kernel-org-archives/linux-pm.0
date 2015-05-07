From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Thu, 7 May 2015 20:32:36 +0100
Message-ID: <20150507193236.GS22845@sirena.org.uk>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlaF2WMUX0OM2JlS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55143 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbbEGTdh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 15:33:37 -0400
Content-Disposition: inline
In-Reply-To: <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, fabio.estevam@freescale.com, David Woodhouse <dwmw2@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org


--HlaF2WMUX0OM2JlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 09:25:19PM +0200, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 20:52 geschrieben:

> > > In the bootloader code enabling the DC-DC is critical. There is a kno=
wn
> > > issue
> > > which falsely triggers the brownout detection.

> > Why would the driver not provide these operations?

> I didn't implement this operation because the suggested workaround for the
> hardware issue isn't very nice=20
> (disable brownout detection during enabling DC-DC). I was afraid of the
> implementation.

That doesn't sound too complicated?

> > If the devices aren't sharing code then they should be separate drivers.

> Okay.=20

> mxs-regulator-ldo.c
> mxs-regulator-dcdc.c

> What do you think of?

Sure.

--HlaF2WMUX0OM2JlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS73TAAoJECTWi3JdVIfQZrIH/2giExvR8LhSg53DLrXeQgYh
FF+sBNnXA6eRdvBDsnTWkkB8EUY9oWyjFqfdNHtsJiMndHgwxx/fyvT0ux4rgcDe
4thlXBpFz2fQMkK3C4mvnLPxJpAos58t2AYT1o87OwOGZL9PCLtOKHAleepafi/G
asguzXl9wqkJJHLNGqi0zv/Crq/hmkc6rCrdJKOXo3Fg6R3MO0lU46x1OR38Tttw
V13Ls7OFQ+8T2+pEMib2yMq6a9zjyo/JRtEOfYOikLyUGe5DwtCFYk1nGqK5lLd9
rn55DcFfnrv0RsnkFIm6jsYZW9TXW7kf/pPzPSZt4E2piJcsy/Da3X2/3aVr40Q=
=rpxi
-----END PGP SIGNATURE-----

--HlaF2WMUX0OM2JlS--
