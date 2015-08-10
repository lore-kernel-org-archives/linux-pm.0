From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
Date: Mon, 10 Aug 2015 19:11:49 +0200
Message-ID: <20150810171148.GA21858@earth>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
 <20150805182220.GC11315@earth>
 <20150810155005.GH3411@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34330 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbbHJRLz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Aug 2015 13:11:55 -0400
Content-Disposition: inline
In-Reply-To: <20150810155005.GH3411@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 10, 2015 at 05:50:05PM +0200, Alexandre Belloni wrote:
> On 05/08/2015 at 20:22:20 +0200, Sebastian Reichel wrote :
> > On Fri, Jul 31, 2015 at 11:39:54AM +0200, Alexandre Belloni wrote:
> > > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent sys=
tem
> > > hang") added a workaround for the slow clock as it is not properly ha=
ndled
> > > by its users.
> > >=20
> > > Get and use the slow clock as it is necessary for the at91 reset
> > > controller.
> >=20
> > You call clk_prepare_enable during probe without a matching
> > clk_disable_unprepare on module removal.
>=20
> They will never be compiled as modules as the Kconfig option is a
> bool so we don't have a .remove and the module will never be removed.

In that case the module_platform_driver() statement at the bottom
should be replaced with builtin_platform_driver().

> Do you want me to change at91-reset and at91-poweroff to work as
> modules?

That would also be fine.

-- Sebastian

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVyNtNAAoJENju1/PIO/qa3YcP/0i2FxRQ68UuPKdk1ixH7G/R
s+aXmhNFr3YhujvoIyXfYaPE1J2mMZ5rli5N42lZL2yohj0o0xKg0kb41OA6bvL4
NkIIHySVVlw8FSJKzOaBPUoewsu3HdKZVIF2sHbsv+vlCoPczVaa05hrvKjSLGl5
nvwmcms6UkaksHkuPuYS033L7mN80cOM3RBfbWTGiVJLK6SdNfxQCtCjRbEcEpBj
cTIM5mSC0TbKA0bMxlLS4aaD7JpqHFxbgwuOeKk4uXAo4Y25AbxXxCQiA6y45e3F
rROzeLFsKjCJ4qxNGQFV1t1RXBmNzX2e9y06ZkF1VzSrA1Q8v3uxlphjNqsUMzFt
HeP0yIf5x9TzV5kJNpyKahR1TdowUg3NE4KQa75mhkXJBDOge9KhpCqjQ50bEm3p
s7ULE9AAm+S+MXtbt2Z3OTpD70nm9259LLp6QQadXLrJHBdNJ2NgCmN8mC5SDtol
DRy998FrE2GaVIKqV9OPG0ByIVB2t+4IOTkVWClSYLmb6CCzSFhPs8AHVKhv/0XP
Y39DQdLad1k5C5IJglaegu0whPetFNNZCwTocl+DeaG4jWOdvdB4OI0jEmxAHKS1
WSTYv0tbtISKxuNPEtvrFCWo9gypTypuxb/isPQ4EgWEG8JBoM00NHcjKhM5Vlnu
OTwFUSLfviwiCnzeVRL0
=v6XF
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
