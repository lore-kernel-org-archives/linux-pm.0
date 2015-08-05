From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
Date: Wed, 5 Aug 2015 20:04:19 +0200
Message-ID: <20150805180419.GA11315@earth>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
 <20150720164241.GA5930@earth>
 <55B72EEA.5020600@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38059 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbHESEY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 14:04:24 -0400
Content-Disposition: inline
In-Reply-To: <55B72EEA.5020600@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Josh Wu <josh.wu@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Tue, Jul 28, 2015 at 09:27:38AM +0200, Nicolas Ferre wrote:
> >> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
> >> new reset function for sama5d3 and later chips.
> >=20
> > queued.
>=20
> As my Device Tree changes depend on this modification,
> we can synchronize in tree ways:

Sorry for the delay.

> 1/ you provide me a stable branch so that I can pull it before applying
> my changes that can go through arm-soc.
>=20
> 2/ you let me take the driver's modifications with me and the two
> patches of the series would go through arm-soc.
>
> 3/ you take the second patch of my series with my Acked-by tag and carry
> both of them up to Linus' tree.

I would be fine with all solutions, but 2/ would also require
you handling another patch. I think your option 4/ is the best:

> Okay, so to ease synchronization, I take this one with me through
> arm-soc and add the old compatibility string as a fallback =3D> the
> newer will be used when merged...

FWIW:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwlAhAAoJENju1/PIO/qaOs4P/2gLQ11zJVW1MhESMMQUcrgM
A9y4sZAElZAc/qhkFyZ4UDc1S8s5YdHCf+JE02Yyzk2VN45qSJqCWU+6jkfpNW1W
vUPDm8m8XWqq+tXOS9CmlQURLtSNEFPpKfSvbnacMbtAwOLQVIt365W6IfRkd6Zv
xSttHVOIvNKUdBIYK7xNNrtknkC/ZjPhUrxzrWfUOmxhZc6ReGoPMX1Hg4cew+cH
MMwcNqQhFRdEVTE8wrd6MU3P/mDckO9olRiTvH7cSH8u3wDeCCwkArCDvikZ6OXD
pxs8k86qHkzoNPNHRU3DqZ2LHtL2zsQhOlTw04aeM6UxgCHbQ4DiIdr7NC51RS30
9yahtH87YkXg7p3vAAfmiWGpZzVkFnug0Qa/hxRPnKgg1HhINTuXp3Gw6PFERcD+
5H5JwphiCXLZeWojUzCWDvkzpRq8WbGZylK6JZlu8F37HHQLuFEQCNABjTDI2MT+
Xh3AgIIiEe0en3Yk4VaUUFWIgs1wiKcAL99R6aVOYVBXCasyPoP8Oqe6oo4ep4LX
BhG4wYJRim+d9MzPuWCVzRWsLZhapMumudK3VTtKBaCYx4FLp/YO7SpyqJebr9GG
oMwt/nIVx7ooi0YSj8yfsbzvpIsZdbxL/VExUhmMYVRsT5YiVKCUqQSjMGutGYI3
oSgb/T7DtY967SFtFRbg
=VIUg
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
