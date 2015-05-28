From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Thu, 28 May 2015 15:26:55 +0100
Message-ID: <20150528142655.GX21577@sirena.org.uk>
References: <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <20150507193236.GS22845@sirena.org.uk>
 <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
 <20150527173321.GH21577@sirena.org.uk>
 <1973961885.66028.1432760281554.JavaMail.open-xchange@oxbsltgw06.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rR6pEsNFzVJhSSrj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60706 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbbE1O16 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 10:27:58 -0400
Content-Disposition: inline
In-Reply-To: <1973961885.66028.1432760281554.JavaMail.open-xchange@oxbsltgw06.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, fabio.estevam@freescale.com, David Woodhouse <dwmw2@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org


--rR6pEsNFzVJhSSrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 10:58:01PM +0200, Stefan Wahren wrote:

> In case of a single driver instance instead of 4 ones (vddd, vddio, vdda,
> dc-dc), things would be much easier.

> Here are the steps for disabling DC-DC:

> 1. configure vddio to work without DC-DC
> 2. configure vdda to work without DC-DC
> 3. configure vddd to work without DC-DC
> 4. backup DC-DC settings
> 5. disable brownout detection
> 6. disable DC-DC
> 7. restore DC-DC settings

> My problem is that step 1 to 3 must be done step by step through the other
> regulator instances.

For the regulator API steps 1-3 aren't going to be needed since
dependency management means that we won't try to disable a regulator
that we think is in use.

> > If it's much more complicated than that
> > then I think putting a comment in the driver explaining what the issue
> > is would be the right step, that would address the issue with the driver
> > looking strange.

> Enabling or disabling DC-DC is only needed internally by the power subsystem
> (e.g. in case of handoff AC to battery), because the DC-DC only supplys the
> regulator daisy. From my understanding hardware components could use only the
> regulator outputs. In the end a state change is necessary, but it shouldn't be a
> public.

Should this actually be shown as a regulator then and not as part of the
power controller?

--rR6pEsNFzVJhSSrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZyWuAAoJECTWi3JdVIfQJ6YH/jXNmOjP3xxMx4DNKgBnzedd
vWqA2DoLDwereXlm//lgWLjKNjX5Fei2htbTev/ojkiBQMulAgIRiftCwPj0h0zq
pxu8CQkyfmwl/7l9lxJ/BfM8qKqRps9GMSTZYvgHQAbZJlKMzt14fpY5OhNc6CFQ
susPyRH0ZzA/74EP6q7sAfW1n53/GJNyF1Jflgzq+bBxRpxVjD1qJ6PC8lK0fxyl
1wJ/ivVkBix/1zKIXeUmU98BK2ZjABE7iIPbxvd6kfJoC0jCETShL1eu1F7kIvq9
sF97HbDjOe0xz8vW6kkL2bjP2iwqh37O5wpiF47DDqklQzciViKqyzoJqWfSmyc=
=vRG0
-----END PGP SIGNATURE-----

--rR6pEsNFzVJhSSrj--
