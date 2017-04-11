From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: max17047: Add Maxim MAX17047 Fuel Gauge
 battery driver
Date: Tue, 11 Apr 2017 16:42:04 +0200
Message-ID: <20170411144204.5xk3jq24zmkytcn5@earth>
References: <20170403111647.30500-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwxzjm73u2la7rbb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753208AbdDKOmJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 10:42:09 -0400
Content-Disposition: inline
In-Reply-To: <20170403111647.30500-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org


--nwxzjm73u2la7rbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 03, 2017 at 01:16:47PM +0200, Hans de Goede wrote:
> This commit adds support for the Maxim MAX17047 Fuel Gauge chip.
>=20
> This was tested on a GPDwin x86 Cherry Trail machine which uses the
> Maxim MAX17047 Fuel Gauge in combination with a TI bq24292i charger.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max17047_battery.c | 286 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 294 insertions(+)
>  create mode 100644 drivers/power/supply/max17047_battery.c

max17047 is already supported by drivers/power/supply/max17042_battery.c

-- Sebastian

--nwxzjm73u2la7rbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs6zwACgkQ2O7X88g7
+pqGlQ//RuUOiyhZ8fvjw7RNCrc34uRM/Nw/E31cBdPPD5tK+n86ev824D4L/jMk
vbGj7LxUP12JA6QbEyRm814Qnp+loNTsk33naLhdsWnSxTVRbiHIi29GbHUN67Ii
q5HkbzZrp3iXrX0picFbrnhhEEXbTKpBHGl6tFHAfA6vakK0O+VTOwMl9OAsHhOF
zDBA/Kkv1ZANGQGk5P2x+fuYRAJLOFPccB0uo9dtCjheorMRts+otjvDOjCNQEpn
RCntdmm6U6MNflwoy3IZsfu+ivW8TQudqlfH1RUOVWmD3N3zIu0XdrkRxpgRPhz4
/OnFDq1vBMTvrb8yZKBIc6IbfHXFQWbJfGuFtW01E+Ozn3APSujdvg+I1rlveAre
U4HW2ZSma6QtS7jRIq5CTAMRYy2LhLzxL6IdvQdGj0zKS7NOE12Mh0EkOxj13LtL
RwhL4yd/SAGhgaflBq+BsTW2TMRG/u0zPPMEP4YfMCKoqa9iT2PXsHxIvIWbNSwO
j+R9ch4pxYOn2fcJ/N6efhWRILy/Gq5/R/KPzsehszUiql+LEk+trQ3x+Q6qa4Uq
22N2P0HYgIrGLqCAVQXbQzz6g/eftYz9q+7TJny1Oknjm+ycs/QrGCaRkrYbCVzp
YMxNacR98zoY65o2lRyIevR44WKwV5Og7ftUWMXubvwVhLvbY+k=
=N1yP
-----END PGP SIGNATURE-----

--nwxzjm73u2la7rbb--
