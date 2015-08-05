From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 19/23] power/reset: at91-poweroff: get and use slow clock
Date: Wed, 5 Aug 2015 20:22:54 +0200
Message-ID: <20150805182253.GD11315@earth>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-20-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39089 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbbHESW5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 14:22:57 -0400
Content-Disposition: inline
In-Reply-To: <1438335599-3301-20-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 11:39:55AM +0200, Alexandre Belloni wrote:
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
>=20
> Get and use the slow clock as it is necessary for the at91 shutdown
> controller.

You call clk_prepare_enable during probe without a matching
clk_disable_unprepare on module removal.

-- Sebastian

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwlR9AAoJENju1/PIO/qaUjcP/jDI2qm8RaOHnog543dYjESf
ZdIzvKyLOvs06Nyzj+s+gSYeeOAHWdjHenjJH3GC92J8p4DfPWvYIs5rOVUR/BbD
7faFLUBasDlFyB3B6bOIrSH3PNZysgnHLWgG+yK2iy/C7tviTVU4Lp73dQkuJSAR
f7CSN6EpyxGfwCENKJCIPgQ1wxwo33Fcee8yFvJySbaFGo2YttP3oV9Cwl43lHNI
0Sjcn3rcINopowX3xrxjAtDaxWG+L0W7kcBuuio64/Gu81RmR/v0jmXNO/z8+Kyg
eitGy8U/k/s6JNTaOBZ3ySZtYEvrf1CwfEU5nUa3ZOb/+36p5GYOI5yzsQj84Mag
Gb1INV6r0yTSFlwQkc+mzozIaLTzl28EjqTUGOb7X3eOarA5KONJJWN8dl7wTtz0
OyCfF/2ZvIRTMVTiw1RadZXxXA6ZeooN7KHY7Vv4El+LU89DwwwxUeP0SkQv+i1p
FpKNgWp6FUMEVg2TBiOsmpzla9ApX0vUJi8aQ7VBUYumQpwrxJF+gKNyRB4joVG0
lJ4JsWCUMU2PDheZx+D/xX/1jiWTgozX1Y+IuaKRQ4SlUZqZUMQG3bMCksL/7w10
lo8/pWp4Vc3z853342bb4pa6wyLl7Y8xn+PXYvqQqX0jkpwXx87cDKaQVIJOLtPL
422uIho2qi1d80idn0ig
=XFkR
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
