From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Wed, 27 May 2015 18:33:21 +0100
Message-ID: <20150527173321.GH21577@sirena.org.uk>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <20150507193236.GS22845@sirena.org.uk>
 <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phG1ItUm+rpl+ZZU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59285 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbE0Re0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 13:34:26 -0400
Content-Disposition: inline
In-Reply-To: <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, fabio.estevam@freescale.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org


--phG1ItUm+rpl+ZZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 02:16:55PM +0200, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 21:32 geschrieben:

> > > > > In the bootloader code enabling the DC-DC is critical. There is a=
 known
> > > > > issue
> > > > > which falsely triggers the brownout detection.

> > > > Why would the driver not provide these operations?

> > > I didn't implement this operation because the suggested workaround fo=
r the
> > > hardware issue isn't very nice
> > > (disable brownout detection during enabling DC-DC). I was afraid of t=
he
> > > implementation.

> > That doesn't sound too complicated?

> Okay, i think i managed the brownout handling.
>=20
> Unfortunately i'm stuck at the next step. The DC-DC (3 way output) can su=
pply 3
> LDOs vddd, vdda, vddio. In case of a DC-DC state change the 3 regulators =
needs
> to be reconfigured before.

> I tought of REGULATOR_EVENT_PRE_DISABLE and REGULATOR_EVENT_PRE_ENABLE ev=
ents,
> but i'm not sure that's the right way to achieve a synchronization betwee=
n DC-DC
> and consuming LDOs.

OK, that's possibly sounding a bit complicated.  Is it just a case of
writing some value, doing a reconfiguration and rewriting the original
value or is it something more?  If it's much more complicated than that
then I think putting a comment in the driver explaining what the issue
is would be the right step, that would address the issue with the driver
looking strange.

--phG1ItUm+rpl+ZZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZf/gAAoJECTWi3JdVIfQldAH/1SZaxcgFcehJ3PAUk0hwonu
UhQMYkCk0pEH6dpXOWNmelwD4NjTjbkABlq+5oGi+Imec5K8a2I2VbUb9XO8wHGD
S2jKoeA/10+HvVj3aRcA4DGTcMMS5nR0gp0vzFCCg4v3JwGc/HMyi7tAtFmrumyJ
u1ohwG0txVwiH+0/LZRgfq/myIqSo4H2XshBXs6tPzCrb0MmttpYcjycTQQ1dEXd
je8tWIUL1HSFTNfBgb8l3QBgoTSqayl9dmZYYKgQVJv76Wmy9tCxSlGMef4Y4fWi
Bv6G5Afh0VtaknsEiVxg7hjGFyPPeJws+EKw5pVdP+SV1YDY2HGjfarYc9WS+mk=
=9sTa
-----END PGP SIGNATURE-----

--phG1ItUm+rpl+ZZU--
