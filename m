From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/1] power: Remove Intel Moorestown battery support
Date: Fri, 6 Jan 2017 01:08:32 +0100
Message-ID: <20170106000831.ap6ijedysyyfjnco@earth>
References: <20170105113806.139384-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q3csnjn6i5ilncub"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754707AbdAFAIj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 19:08:39 -0500
Content-Disposition: inline
In-Reply-To: <20170105113806.139384-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org


--q3csnjn6i5ilncub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Jan 05, 2017 at 01:38:06PM +0200, Andy Shevchenko wrote:
> The Moorestown support was removed by commit 1a8359e411eb ("x86/mid: Remo=
ve
> Intel Moorestown").
>=20
> Remove this leftover.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch. I have queued it into power-supply's
for-next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next

-- Sebastian

--q3csnjn6i5ilncub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu3/8ACgkQ2O7X88g7
+ppJFg/8Cll6rf3r4Brl+dAFfdERGUlnaq25YOSqh9AxAEQoXPmbInKkqy99NYjg
v3f+KWnpGEfsV7tGGQwcn0FSDPLEhqAF8vkV0ucNQ/ZYzc1YF/3McN7R5Q8EMfVp
UrpuE4BuDTWGbkjjk8UJItAORZXLRSXR6tZUfqeyHhVimEQgCLh5W831j5SMqjiD
+xgu+dFGjzvDpqqv/YZnOkU8Gwv6xXiz+FIApjEX+SC9a6Ngb/S157aeAxsd9Syp
ZBeDxLmeln9KsLmqJvPDGKD7mlzy0RYDCuKutO26dyZZMG+bDUGsMDDiuRMpcqJ6
oaNOdbvaxKGVj0tAFbiQ84hoqOicOruWes4MfzwtaY+qxhwvfaVvDNhvzIEPGZ28
MunKX/jreS72a6xb7FI3fv5d8GOxu62AK7jZqRxpNOAruJmdWdsJhKW1EECgy8TE
n8BVOrpVhhLJnGjPMGyCAn1tzhfEnTOJEHJz5Vps34MKpXawC+bdw3XdMy8nvZqJ
D56YnX+9VVB5owxcQVcSV+3H9RxciQCTJjbSLETaau3tOwqxW0hW8XftEDiwOhV6
5B61Kb+ZVQNAbY1WxSs/Xi6mj2wt7QzGUZRYRmFpTyle0AQbvdjuGNoxiUM0H9IV
vrUeWmgWPdvJVemXFJlFYzxYXFUt+Nx1th0DZziIZQIvy+Czvcc=
=YVTR
-----END PGP SIGNATURE-----

--q3csnjn6i5ilncub--
