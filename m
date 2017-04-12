From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/4] BQ24190 charger fixes
Date: Wed, 12 Apr 2017 16:52:18 +0200
Message-ID: <20170412145218.ubhv4j7s3fkb3yah@earth>
References: <20170411115957.14253-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5nsbhb5fz5nerws4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbdDLOwX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 10:52:23 -0400
Content-Disposition: inline
In-Reply-To: <20170411115957.14253-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>


--5nsbhb5fz5nerws4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 11, 2017 at 04:59:53AM -0700, Liam Breck wrote:
> Here in one patchset are two patches I posted recently, and two more:
>=20
> Patch 1 is a replacement (as agreed) for
>   "power: supply: bq24190_charger: Don't spam the logs on charger plug / =
unplug"
> Patch 2 fixes up Hans' extcon patch. If you would like me to squash it wi=
th his
>   original patch, let me know.
> Patch 3 (repost) fixes some issues with PM runtime error handling.
> Patch 4 fixes a nit in register_reset().
>=20
> Changed in v5:
> * move condition in extcon OTG boost code
> * document extcon client invocation of charger driver
> * udelay -> usleep_range in register_reset()
>=20
> Changes in v4:
> * fix definition of bq24190_reg_poc_chg_config_*
> * revert to if (device_property_read... =3D=3D 0)

Thanks, queued.

-- Sebastian

--5nsbhb5fz5nerws4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuPyAACgkQ2O7X88g7
+prAABAAgQ/zCCFI4s+4UFrAFKQqCuGIXZH2TrgkTqU0GnHSTv4Uv5mS+FcuMFIP
dUkmA5C+U3iyzYbmhJv37xexmRRDKXxth5LgnZuVVhtbvUB1GZF1FA6ZAb9zC+Yk
F7Bfu5YbHW9ky21nHUh0DuP8kpPo0LFq5O+u81i2fuApXdMOLllGO1hdR8v+A/Xa
tgYh9OqHuvGpSJC9QolIrPpYkhETDbFLKRZNjhcB4YR8TU+16uFgVgrQBI/FVQBc
yMrmLXajGCXLYRvy1b2ZBoN1RHte8fdt9bmwNti4Ot8WxGwJIcaJ3qZxWWH52+Vh
hQrea7UfdMIbyGuEObA37z8ftyvZgZrg2pXVHnTaiCRgyXl4vws0Pc0EOwiGMFAx
63aEtCeyudIJUQd3x86+Wn+1dX8RmPEKJqoqCv9FED1UbZzcD+lRgaDswfdSS3vs
R3LAVNCtWyD6AE3NIb4kK97/6TEvjcZ4+UyDpBecTgvE8Fe83Q0Hk4rDdu3u0RYL
X4DFNWjEWLTobth+6h0xu6QXF51gRF+jclT/m4BIUtyTvghvAr8Mg97nLsEKfwai
3RrNS4xIh7ixUTDh2Vze+6i4rURolLAeqMF49qWYv+JABqsaYZHpzKRkV5p0D9Bd
3DTKLbbmirgGy9dzQOvBQtV7twe85kKksYeBoaopVBCyv4fB2C4=
=dOKd
-----END PGP SIGNATURE-----

--5nsbhb5fz5nerws4--
