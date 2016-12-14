From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/3] power: supply: bq24735-charger: optionally poll
 the ac-detect gpio
Date: Wed, 14 Dec 2016 16:10:27 +0100
Message-ID: <20161214151026.5q6goxlfscv53tol@earth>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htebv6msr22h7zh6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756338AbcLNPKe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 10:10:34 -0500
Content-Disposition: inline
In-Reply-To: <1481673405-4547-3-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--htebv6msr22h7zh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 12:56:44AM +0100, Peter Rosin wrote:
> If the ac-detect gpio does not support interrupts, provide a fallback
> to poll the gpio at a configurable interval.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>
> [...]
>
> +	} else if (charger->status_gpio) {
> +		ret =3D of_property_read_u32(client->dev.of_node,
> +					   "poll-interval",
> +					   &charger->poll_interval);

Please use device_property_read_u32() instead.

> [...]

-- Sebastian

--htebv6msr22h7zh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRYOAACgkQ2O7X88g7
+pornw/+Ox8mn0XdhkzmTfKAzGdg+vj5IV2C0qlbOs4kHSVwk14ecdlA8YgJICds
d2EQkrbSGfz6m5ooSQG485Mpajg3bXs6zEtmDbmCvKZnNYAOxLoo65iFJctRv+Pr
x/+mLY6Vm+t7ir1KzvdbZTdiYtby+t3kVemuIsr+GWGGtATPRxlWfb2WJQoQHaVh
CjygyYdi/IjTaUT/+gqNKvlUe4qHkRuEjctUJVdl0Be49mdlLN0pifn4NmV9/sh5
Zos/ntyWG6JytqDKVWRgdj925JRPjb3BI+s7PeuWBY+l9dxThkqC5IZLLkKaQQsS
L9LbvlL5+zjp0xGKHck77z1FS4W7XV3A6Wn7CEyyG4OwWrtmGVhYWZlFdJ2TP6Cd
KGwWBQi8N3zASJbh76ivYl0WtUCrq783Ir/nXnDdMuoNBivzKFy5rWDiam1PKAKF
KawcXGDhOHeRfMdDa+FJ52KU6hVZYn0CTLtL2YrZyZrOaFEvDhsBGHTfSBNCTnLc
SzRFO5YnGSrFq1LDNQkvGXkylyYu9s+QNi1lcLM31hUuWui/Vfm/HBc49b/S57p1
k6S0QpN8b/Lju/O5sAVuAbX8o3Q9WsVRXHy4OAZcyC/y9Hu2zjGZFZvUEzAjJqnV
sFfRrA+R6liT/8+t3hIsMOmZtQClD5TYP5A0EUKc/vELcA9KbjY=
=1k0H
-----END PGP SIGNATURE-----

--htebv6msr22h7zh6--
