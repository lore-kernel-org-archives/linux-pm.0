From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 14:31:48 +0200
Message-ID: <20150710123148.GA28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net>
 <559F7AC4.6050008@atmel.com>
 <20150710120907.GC3127@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDpvzslK0qRw06MN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50522 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754037AbbGJMfJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 08:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20150710120907.GC3127@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Josh Wu <josh.wu@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org


--vDpvzslK0qRw06MN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrote:
> Hi,
>=20
> On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
> > I would agree with Maxime. Currently all latest chip reset function is
> > compatible with the atmel,sama5d3-rstc.
> > So check compatible string is enough for now.
> > But of cause if we have other incompatible reset in future with new chi=
p,
> > the structure like you said is needed.
>=20
> We managed to avoid using of_machine_is_compatible() in all the at91
> drivers. I'd like to keep it that way. It was painful enough to remove
> all those cpu_is_at91xxx calls.

That's your call...

> Also, using it is trying to match strings and will result in longer boot
> times.

Have you looked at the implementation of of_match_device? If that's
really a concern to you, you should actually avoid it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--vDpvzslK0qRw06MN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn7s0AAoJEBx+YmzsjxAghHsQAIBVBlT2AUIuvADfHmLgeqqd
ExsizCx/CnjHv8/qyxvxFW8H70Yr6SSmgLymqBz5LyUx1rtPa7ThA3uYL3/tPPjE
Mf3DffsxLSn6PNyAjPubsZ0IOjfhWfzz/9+GENRDB22KOC2hyg7nigBqgyGZ/ES0
DOVetjkNnkHIEVbPYkGVvM9kLRRIVcxnj0gpyTnjWqtgcf/qsDlghHJDCTo2HVYd
JMPv27Ni9aDlzjI+dfV/CSFYBy3modCLnFOPCNtXWDpapgW+cOjNz3R9aHGqmUWi
sh5Sn/IEh2agKZDMK3mxRp6NCdLVFjUrSj/VzDx3oJDxKp9sGmNa0adNB1Cnf449
iP9aKH5upIZMqWHcsX7yWsf/TxtrJejRsHckQDnp3NlFGIcTAesYZFhs6Y/pA2pW
eR+3GJyT0oRQPCfU5NGDCmgbF4bj+jZCmuBoj3JFkqPJIS8R04knSGXovPEVP6Wu
VcWC0nv+6qkOSx7Ws1drv5y/yNzvqDfWKSjrBbZbw5FMqOIDYE+fk+MAUTCSg1ri
Wozw7F78CVmReYNI3aTvAQMfCDpYaplDtihJljXZuXrCi2bYF5yVWKqXFIZlA553
yyxmrlOvUUTqNMjt8d5ZU0mijhC24c2P1fevAl9xIVJt2MnzVpwDP3skCkm6SuPl
uhn84K1ii2PxYo9eqyoY
=TBWO
-----END PGP SIGNATURE-----

--vDpvzslK0qRw06MN--
