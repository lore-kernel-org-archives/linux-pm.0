From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/3] power: supply: bq24735: handle AC adapter absence
Date: Thu, 22 Dec 2016 16:47:16 +0100
Message-ID: <20161222154715.sowhh2kil4r7ovdx@earth>
References: <1482233582-29770-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6v3fqa7sv7tvulp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbcLVPrV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Dec 2016 10:47:21 -0500
Content-Disposition: inline
In-Reply-To: <1482233582-29770-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--z6v3fqa7sv7tvulp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 12:32:59PM +0100, Peter Rosin wrote:
> There is provision in the driver for handling the case where the
> chargers are not responding to i2c requests when the AC adapter
> is absent. I think this has been used by some Tegra boards that
> leave the charger handling to some other component and that only
> wants the kernel to be aware of the charging status for reporting
> (or whatever).
>=20
> However, in my case, the kernel should handle configuration and
> enable/disable the charging, but this is not working very well
> when the charger disappears (and is reset) on AC adapter absence.
>=20
> This series fixes the issues I have found in this area so that I
> can boot without AC adapter and have the correct charging config
> every time I do attach the AC adapter.
>=20
> Cheers,
> Peter
>=20
> Peter Rosin (3):
>   power: supply: bq24735: move down bq24735_{en,dis}able_charging
>   power: supply: bq24735: configure the charger as part of enabling it
>   power: supply: bq24735: always check for AC adapter presence in probe
>=20
>  drivers/power/supply/bq24735-charger.c | 56 ++++++++++++++++------------=
------
>  1 file changed, 26 insertions(+), 30 deletions(-)

Thanks for your patchset. We are currently in the merge
window and your patchset will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--z6v3fqa7sv7tvulp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhb9YEACgkQ2O7X88g7
+popMA//SngizE6jNyQA7ifjNsfnXwpZCTCmBwB/YVw4h/bR9bf9CWU/S9mvp9iA
BZVkNpxzQ/830wMn766nz3luokuayHJW58H16/XAOjeiMuu08TCafT7YfzE+o1sb
fhAvV9OgBmz0bM6W604bNMJv+9rAdGF8osw47mpbJq1TcvnqFqg1laDVaszi50Sq
RQMW43nW8q48xOznyqWSOpfRdQ6PiE0T/700HrafQqb5aPcAXJ8f9PZtMIGu2Sz+
sOwexHjvWF20psQeh+7RrJm3BQNTx+wGjysz+MENZT9DV3mSaLETmJ39V48jSbXG
/hKmfq1wnGashfIJcdwp866dxMim0cJUzUgJZ1wWdxx5E8/isW6pWdf6+2+oHmQJ
KX9gb+Rt36z+iMpZyuGQlstFmlcjTqWGGtRPAwrjetQ9H0bi8qWdo4vfXbI5sFJ1
H9E6G5Q8iWlB6BigZ4LB5/03ibcW41cZs36dW8fKjb6funJLtGAvPxbxV81uz5Kq
VgERFymu/06ZlzJ7GrBw0Z3BaJzQp3IlzejzvYaRZOnl6SnM3hbSARJiW+XcZXhH
twmNTAWicrNUMw/9Vrxx7rbJAGbytVg3fuThX3Q5vALr4WhaZupvJWhHlJS8+JTE
GcRB5z4oTMP3FJ7C4gMv8zs7NXEuzLo+grOym00dKKQgYK7LLUY=
=zq0E
-----END PGP SIGNATURE-----

--z6v3fqa7sv7tvulp--
