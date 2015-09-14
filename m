From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 0/5] Let the power allocator thermal governor run on
 any thermal zone
Date: Sun, 13 Sep 2015 20:04:16 -0700
Message-ID: <20150914030414.GA5075@localhost.localdomain>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35174 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbINDET (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2015 23:04:19 -0400
Content-Disposition: inline
In-Reply-To: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Javi,

On Wed, Aug 26, 2015 at 02:26:39PM +0100, Javi Merino wrote:
> Relax the thermal governor requirements of sustainable_power and at
> least two trip points so that it can be bound to any thermal zone.
> Its behavior won't be optimal, it would be the best it can with the
> data provided.
>=20
> Changes since v3:
>    - Don't hardcode a value for sustainable power and re-estimate
>      the PID controllers every time if no sustainable power is given
>      as suggested by Eduardo Valentin.
>    - power_actor_get_min_power() moved to a patch of its own.
>=20
> Changes since v2:
>   - Typos suggested by Daniel Kurtz
>=20
> Changes since v1:
>   - Let the power allocator governor operate if the thermal zone
>     doesn't have tzp as suggested by Chung-yih Wang
>=20
> Javi Merino (5):
>   thermal: Add a function to get the minimum power
>   thermal: power_allocator: relax the requirement of a sustainable_power
>     in tzp
>   thermal: power_allocator: relax the requirement of two passive trip  =
=20
>      points
>   thermal: power_allocator: don't require tzp to be present for the
>     thermal zone
>   thermal: power_allocator: exit early if there are no cooling devices

This patch set does not apply clean. Could you please refresh it?

>=20
>  Documentation/thermal/power_allocator.txt |   2 +-
>  drivers/thermal/power_allocator.c         | 241 ++++++++++++++++++++++--=
------
>  drivers/thermal/thermal_core.c            |  28 ++++
>  include/linux/thermal.h                   |   6 +
>  4 files changed, 212 insertions(+), 65 deletions(-)
>=20
> --=20
> 1.9.1
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV9jknAAoJEMLUO4d9pOJWWYsH/1oixlDsX9VjAedgV166qGGG
8iwWyjfuh26RaLmCbeT+wova/nizkzTuu+MRrJ2Nx4N8d63THUCWXD6uUVxgUVvJ
wz1JB6GH41CgghbxCSpPdv/eiyT6glzMMULcJyD3jkiw6RkpAWI6Ies79RsoFt1M
7JcXx9y4iPQH9SzpKZha9gEXVHk1JdV3whuUPwRcF5Sou8OiriYFiD0BDmKT0mZf
1NeCFUTQImXrbDlrD42YznDGmpwZAmu225gML48LHZQZn0u002PGxTGFiCXuuycR
X3N4fjvJizUpz/mFchpF3mV2zEQjNmI1bJQ74wnKqel3xockH4Zw+8OitRDs4ew=
=7ZIH
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
