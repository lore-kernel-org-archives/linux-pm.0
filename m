From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] power: supply: ltc2941-battery-gauge: Add support
 for LTC2942
Date: Mon, 3 Jul 2017 18:10:10 +0200
Message-ID: <20170703161010.i7elaahpp6i63ikg@earth>
References: <20170624150545.2oxwror5fy2xlvaz@lenoch>
 <20170624150901.jngjwyxafyutkdhv@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vebbygkmcq7lmfpe"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52883 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbdGCQKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 12:10:14 -0400
Content-Disposition: inline
In-Reply-To: <20170624150901.jngjwyxafyutkdhv@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pm@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>


--vebbygkmcq7lmfpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Next mail should CC DT binding people.

On Sat, Jun 24, 2017 at 05:09:02PM +0200, Ladislav Michl wrote:
> LTC2942 is pin compatible with LTC2941 providing additional
> informations about battery voltage and temperature. It can
> be runtime detected using bit A7 in the Status register.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  - v2: reworked voltage computing to not overflow and keep presision
>  - v3: update devicetree binding documentation
>=20
>  .../devicetree/bindings/power/supply/ltc2941.txt   | 11 ++--
>  drivers/power/supply/ltc2941-battery-gauge.c       | 76 ++++++++++++++++=
+-----
>  2 files changed, 64 insertions(+), 23 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b=
/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> index a9d7aa60558b..0d065d54d294 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> +++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> @@ -1,9 +1,10 @@
> -binding for LTC2941 and LTC2943 battery gauges
> +binding for LTC2941, LTC2942 and LTC2943 battery gauges
> =20
> -Both the LTC2941 and LTC2943 measure battery capacity.
> -The LTC2943 is compatible with the LTC2941, it adds voltage and
> -temperature monitoring, and uses a slightly different conversion
> -formula for the charge counter.
> +All chips measure battery capacity.
> +The LTC2942 is pin compatible with the LTC2941, it adds voltage and
> +temperature monitoring, and is runtime detected. LTC2943 is software
> +compatible, uses a slightly different conversion formula for the
> +charge counter and adds voltage, current and temperature monitoring.
> =20
>  Required properties:
>  - compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also

ltc2942 should get its own compatible value.

> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 0a1b69bbca7f..c4a949dddb66 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> [...]

In addition to the binding document the new compatible value also
needs to be added in the driver.

-- Sebastian

--vebbygkmcq7lmfpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllabF8ACgkQ2O7X88g7
+ppuhQ//fphe2VMdEI2DJWNstHFMaPKaZNtYsS7AlIEYahQmr6VmVxDXRs7AFIGc
oss91zRk/ZU5MFKcbqqcJR1rHpBJvECn59tPkrkd4DV6XPjOphFedL1tSexu+06N
iCpOsmUYAdYsR4xP0doNUUQimgmvKn8DyJ2hD8lVWDP6gBpd0Rnq+Zl4E5SoOq3t
Uw+CrS6nOT19IIiTIy/gX/OOfiQxw0bGZmvtTIKgodyAItJkaT/8YcCkOjoofOzU
2Aw+5ZqswCYnD5Ipt7sfBcWJa1eypQw+PFh0KTF+rSRJFTmQ31HpkFK3Ldu76oHV
bdBdS9KH46rD9itCVzSERZYeyM3eHyQMBd/uUKQuIeW8f6OLaeGdngpg/u5iqKyB
TH5c5ci+7dRp1+Mk5MuC4UM2fN+wZQPVwgN1kuB87L9KkKBbbxPwjlrSjFCaNT1C
7zLRUnd4CEiRb7S7ddJIfutc7+5/2GJI31DMA9OduOowkBcCBkNzYXybSAQ2HvQK
8xLnLO1R2ElAHvxK79NjRW/hZNpedbwauoUEiNeyCIovp+JSxXYBYxUEsike9iYB
KHNV7IS60+eq9qJJJS8sHnZpAY3tHUQ8AwvISUdI+4uTy5ybwTYV/vnqBLEmL+9R
kPwCVwfubo0AyoDQDmw3PgmVLjYb3EkVRr2HTRH/Ap1DavGNjl8=
=dVYX
-----END PGP SIGNATURE-----

--vebbygkmcq7lmfpe--
