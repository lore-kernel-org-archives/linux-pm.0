From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: wm97xx_battery: remove redundant 2nd null
 check on pdata
Date: Wed, 4 Jan 2017 22:21:12 +0100
Message-ID: <20170104212112.dws54sse2xnjgtfv@earth>
References: <20161229152312.20537-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7s3z4yierqhu67j2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935872AbdADVVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 16:21:17 -0500
Content-Disposition: inline
In-Reply-To: <20161229152312.20537-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--7s3z4yierqhu67j2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Colin,

On Thu, Dec 29, 2016 at 03:23:12PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> pdata is being null checked twice, the 2nd check is redundant code
> and can be removed.
>=20
> Fixes CoverityScan CID 1392340 "Logically dead code"
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for your patch. I have queued it into power-supply's
for-next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next

-- Sebastian

--7s3z4yierqhu67j2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhtZ0cACgkQ2O7X88g7
+ppF0RAAi/aTeqpe5qtoPXLzoPsyliZcVMBsgmXSMeIZXlY//xSqppNitjwOmN5t
J+tJmg7dNqUxBfpIwBse7Va3xmW1TK3ShSQrg6RU5Oq1aa7LPtJ+whrlI8Wn2MKo
GCgLIkYxQLQSaUFHP9DGWv4c8VJMYR3f6YfQh7x3LNpoy0dWP9AqNX1OxLifEoZz
FJ7H3cCoZfOmrsJJqHwBREVdMiKgkIrv7C17IBXlFDwprLCJJ7mGWsvg+eBDsvSY
L5mrr5IgZ7x0GeqbIXU33Y/+TDK4r9XxcapPCV+KV1UdZCm84gdb/UNaX/Ba8Dci
QrpjevLnkJOukPWjtEoocHxVr41XW1gnQQ+Il1+qLcw1c+QE4HDBZGJdq+jOD1H7
sxvKOpIY77DTTUQDq2+TdJCIuEhyOzsP+pXSANjHsW8Py/TK6wH1qoW/518AHna9
5AoOxjrwyXZfrDyrKAeVkgX9VMx4d1vCyqgne02tHL/m5mFt/5iZmxIxFq0YI8qm
ngsHEwvy5xBvQt4x7uepOv4BbwDZLxsG79Ls8eJYE5q3OvlRuuW16Kv8Sr6SZJ6e
A8D2Dku5594oE59fHA2t0pFNFzT9JA8wPQm1KTjTVMcDqq12jMf9NJqqUmbe8WPX
ku0NiVd8J1dfNQeVtxcnj2zs7D8CUdE4jtRrgzRYaKpfRGQ4FlY=
=+3ap
-----END PGP SIGNATURE-----

--7s3z4yierqhu67j2--
