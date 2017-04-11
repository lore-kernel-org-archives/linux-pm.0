From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sysfs: parse string as enum when writing
 property
Date: Tue, 11 Apr 2017 18:12:22 +0200
Message-ID: <20170411161222.t23gsn4pvxofhnrh@earth>
References: <1491249177-8945-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izpvvshacpq6slgc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbdDKQM1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 12:12:27 -0400
Content-Disposition: inline
In-Reply-To: <1491249177-8945-1-git-send-email-david@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--izpvvshacpq6slgc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 03, 2017 at 02:52:57PM -0500, David Lechner wrote:
> This fixes the TODO to parse strings and convert them to enum values
> when writing to a power_supply class property sysfs attribute.
>=20
> There is at least one driver that has a writable enum property that
> previously could only be written as an integer, so a fallback to writing
> enums as integers instead of strings is provided so we don't break existi=
ng
> userspace programs.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 124 ++++++++++++++++++++----=
------
>  1 file changed, 85 insertions(+), 39 deletions(-)

drivers/power/supply/power_supply_sysfs.c: In function =E2=80=98power_suppl=
y_store_property=E2=80=99:
drivers/power/supply/power_supply_sysfs.c:138:9: error: implicit declaratio=
n of function =E2=80=98sysfs_match_string=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]

-- Sebastian

--izpvvshacpq6slgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljtAGIACgkQ2O7X88g7
+prOdQ/8Dj26hruRojIDNp3z3VsFgcrjWdYTdi/C49CO8YVxSVz9j1PQ9FlrDLLC
KIalQ4F9Ekin1a7KnV2zM11JIOB2CwXlWlGB4zcqtuGAB/q4nTjZfY8iOJiu+Xbu
3i2d/X1s85R/h8IWozdqat/8EuwpPdz7ceGDPAQHHTX7CYQ/cc8dPIoTbe0p+I5D
IB80pIN++9i5u96uslcoHAoWm1f78ThVAo8n+cUs03amJedi8cjywi90dm+3/zt9
/2bZksfS3YslqdQ6IP+4ynETNt6xSTH360E73zaiBxQVclX1AJA2KdTYbur9qmI2
UD1PNtKtGDou+NBlPGSqV9ZQiButPxhX+QQlAX+H0gStc96o/2YO6r3OisgyvDB2
0GsL1ZnaHSw+G80ms5vfAxQp/VTG3cHWzM9vM7aXqL28QgSdimTn8m0b2BkVGNXN
IGFNkGZtDrbQ6NFrvCExQHfQBGNt5axbCG535F34bdzE8fs4SDYkAiaTlhdYHize
lh4wlECgX9Ls1Sp5tFNOKQ/uQ+TbFN4sRK0OkdmoY1Iu3CDex8l81vCdDED7mRcn
y13VcBZML0psC9OuWvMu58Vh7CJMpUf/JaUdRKZ8jklH86o+fkiX84BQmHoO0as6
DZWD0V+dkI3i/2vGkren5bgECBIgPxZv6zodRCRxjIABcoO++yQ=
=KiT0
-----END PGP SIGNATURE-----

--izpvvshacpq6slgc--
