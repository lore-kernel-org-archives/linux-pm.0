From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
Date: Wed, 5 Aug 2015 20:22:20 +0200
Message-ID: <20150805182220.GC11315@earth>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39019 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbbHESWY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 14:22:24 -0400
Content-Disposition: inline
In-Reply-To: <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 11:39:54AM +0200, Alexandre Belloni wrote:
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
>=20
> Get and use the slow clock as it is necessary for the at91 reset
> controller.

You call clk_prepare_enable during probe without a matching
clk_disable_unprepare on module removal.

-- Sebastian

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwlRZAAoJENju1/PIO/qaPsgP/jODPMqUypCcjxBPcfWPu8Cj
lvH8bQgvvAmXvr3LwoL6EOfLgTGbhF9DTT0qk95sF0OakVP0/o6AkxfJFC4hwRyG
GMVJqMAo5SuTqVtpLjHBKyJVrr0lB+k1ptcJ2g3QV5yz0JJLDiW4XeeJi0zGNe/S
pMZg8/teO3G86gURzDpoRvmsQnijx/ecLnbhq85VyDdkYobKIZcZgfh8TTm5YN9C
leedFsWCdPT72Yzf15IXsPi9hRSH50V/MYe8GVpwLfut0ws6V8vHoGcfWE+6XkH5
smJdaKbkbMNKDs3SYBLGgzUaSrABPyI0u5hLceuBQsEs+TQasMSSepMDSS535mp4
x8oqaH2J+Yf8rdUdGeDnTolovgIS/4+G1PujJ6nfTstPPYhTKbjRHCFl8o4QBxyL
qaF9x/E518nBE7DTqy+P7fRbwjMNPgjFntvEpNDocRZV/gavN4d8AIu9X+Mqd3f/
IMXl55Fpbbapkbbg8AqizvdAxZ/nhWfhE9WtsjhUQhpLTqTlYMhC3kunDGj0MyVr
aTBFtMR99X8OeRNgUKbTnE0g5ZisdF9S1ka20KqVL5pGX8ogxkJmbgbShPB1UW59
pK400YzwKlV/dpzhV8FbKDWRzH1e1RqFOACHZaS2zC2CnfPGiubEiCxw8XduN89p
WqYB4P/OsBzvjGgR8isx
=GHg9
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
