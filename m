From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: ipaq_micro_battery: fix alias
Date: Thu, 24 Nov 2016 00:09:05 +0100
Message-ID: <20161123230905.qanedjdqla5u42dh@earth>
References: <E1c1VrC-0000LC-Jo@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2gl7yxn3mfonv26i"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756384AbcKWXJM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 18:09:12 -0500
Content-Disposition: inline
In-Reply-To: <E1c1VrC-0000LC-Jo@rmk-PC.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org


--2gl7yxn3mfonv26i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russel,

On Tue, Nov 01, 2016 at 09:59:50AM +0000, Russell King wrote:
> The alias for the ipaq_micro_battery driver is incorrect, fix it so the
> module can be auto-loaded.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/power/supply/ipaq_micro_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/su=
pply/ipaq_micro_battery.c
> index 4af7b770f293..2fa6edd6e8b1 100644
> --- a/drivers/power/supply/ipaq_micro_battery.c
> +++ b/drivers/power/supply/ipaq_micro_battery.c
> @@ -313,4 +313,4 @@ module_platform_driver(micro_batt_device_driver);
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("driver for iPAQ Atmel micro battery");
> -MODULE_ALIAS("platform:battery-ipaq-micro");
> +MODULE_ALIAS("platform:ipaq-micro-battery");

Thanks, queued into power-supply's for-next branch.

-- Sebastian

--2gl7yxn3mfonv26i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg2IZEACgkQ2O7X88g7
+ppT7hAAicHdQbo4AFS14w5EIKQrucm8e9RcdpmeWCWYZbdbkAJzme8XcfOdLIgA
VVFt5najwqVNSI5GalSOyeG8xiym/M5S6Tvx5RFSkvVacAu+KHlx30aYx6uESrcb
k4cVO++dZAjnFazaCvXShizlImccs+dBhNfE5Wqa6oqT7a6ba30I9cuiG/aUsAZO
YZ9YbesR/v9cMATJm7S2jOKenESlf1Gl5RU0xHL2PhlAfT7BJbRrSf/NmIn9mZiM
YRqXQ8/H8A4KRYe4/G/V/4vZJbwCOsRwfe0YgTWIqsNnVPeP135zw9nVFCsmhqz5
Kz0WFjJ7j6zcJj0vVBSc29VwtQlR7oy90/DigEldcKlikzyccVYEQEjID/SdpB03
+THJ/FQW9G8np3h5BSoVpE05H1Or86ECQ5fM80iWaW4zgEodBNxZrh7DTCxPWTus
s2U81Z18wy679k3ryM0mOalAX5/3g2GDJFLFQvgubGnoT8g0trPTHwIgihj51KG1
6TXlTkG/R9YCDscnZgnazvthbOzugQMAHRV9JxCIXkl8CSeff3qhiWUrSh9L3Cf5
WpSj0YvHVgvuP9x2UEslxKDIVlr7NBjOMMefEgtR0SZGOD/DqPkLNmuS5b7LvBd5
yktPldGbHNrrtGcVOeEiv88272PtvTJ4bi+KnigrUkUE3bJeZck=
=iUbu
-----END PGP SIGNATURE-----

--2gl7yxn3mfonv26i--
