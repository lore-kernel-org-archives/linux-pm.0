From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: collie_battery: hide unused variable
Date: Mon, 15 Feb 2016 06:03:09 +0100
Message-ID: <20160215050308.GD28626@earth>
References: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41935 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbcBOFDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 00:03:13 -0500
Content-Disposition: inline
In-Reply-To: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 25, 2016 at 04:45:49PM +0100, Arnd Bergmann wrote:
> The 'wakeup_enabled' variable in this driver is only accessed
> by the optional power management functions and we get a warning
> when they are disabled:
>=20
> drivers/power/collie_battery.c:29:12: error: 'wakeup_enabled' defined but=
 not used [-Werror=3Dunused-variable]
>=20
> This moves the definition next to the users inside the same #ifdef,
> which avoids the warning.

Thanks, queued.

-- Sebastian

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwVwMAAoJENju1/PIO/qamFUP/ie81KfItzRtPLgGvqreBMx9
oKA9iXqA+8e4CwRa5kGShkpYVwCteFMiTOog5dq0UgzNzu29DN5mcN8XxLjg9Q32
1pNvzzc+Kazz3HU8O38srw2N840kPrE5B7jpADsQGIuqAkYJk/97ASr2dCaHDOBW
pbkeNguPEAXGJE6PQl+5yKyFoeEoXTVS5gGsR7wSDuoKLuEeYk3T8Xh/OE1XSEsc
WbBqlVwSKUhuoTz61jdpCV78ZEzshYLegbg5jHECyX8xvaBWNgSKlc3ch8YPQuto
E/zIMQfKwqCdT1fu6W9vFUkgot8axPa8JH3zyVYfVFoIlz9daQToNwyTL5RRowmq
HxhHtGseEeC3b1gyDxUtWQkPeAGRSb3YdcDzpF7f5qJ++TDaZwwYfwtFJ2c/NfKc
tMPUKeL+lQW7ulo65EheSw3VZ/ZMD62SCdtkTv58T0vWv4VUtI+inu0cg/ujlhAI
jENNzSKBOpd28gSbrGidfva3lzOlGcjCKDtTOTtiyGr+HNPwtoq6cFOPcsuZoUPB
U5Fux0IPvuxjo5AoB/PJtAXRrkX94fp5xsE03rCWW91eDJuW3OHM8WoNOX8bnA+f
mgs0jbyY4rA9nYj7sC3B5Nm/NUvmaxmRbJruJKm/hwb1TVO/3MP4b8KPKXXfoQFf
I5JGiBAJfhti+FFhgtL3
=XIWf
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
