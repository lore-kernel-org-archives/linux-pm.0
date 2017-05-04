From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: twl4030-charger: make
 twl4030_bci_property_is_writeable static
Date: Thu, 4 May 2017 17:22:48 +0200
Message-ID: <20170504152248.opqdp4jcizlk2zn4@earth>
References: <20170503103357.22598-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vv7dv6b5v5dmyh5f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37165 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdEDPWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 11:22:53 -0400
Content-Disposition: inline
In-Reply-To: <20170503103357.22598-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org


--vv7dv6b5v5dmyh5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 03, 2017 at 11:33:57AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The function twl4030_bci_property_is_writeable can be made static
> as it does not need to be in global scope.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, queued.

-- Sebastian

--vv7dv6b5v5dmyh5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLR0gACgkQ2O7X88g7
+prS1Q/9GHDVTANxz/5iLoEJJu2aHySNzID8J567niT6I1uQ4Bqbacqv30+lldMS
TJweJyywJlB0eMZx9F+g9EJ8UnfLK/YWpZWBuwqKcXkIpcb/ydbJvXOQdrM8lM1S
TiRjbzBL99FR37/f9wDWJtDsUDTpnv7QT0ukBz5FnChSo79gjX9msNxdeIN3ShvI
M4zxWiiOKDafUEL+omT2ogiGAq5ad8bJc5U7Urn+7IUCkMGJYchNtLtXqqAC0vUi
ZN0Ccj6BuHrV7KullDv3y/XmKa5fnpDPpkDEoQy9Iuc5UbirWBdz/RKBspsIyKeo
GOjbZBgemmmI3BziZO9t8u86Dcme5Me3xq/GNTN38hEq7PAGQCUFvPJcRkpn8F3j
ttpkEIKDV/0hVsUKFLxoXOFD6QUlU4xYqWNf19zPsVX5vHH9hTknBd/3IZm9g7c9
OI4Wd6Z53CS4JD1Vo/4fx/B8uznKqUk4MK4SUdf8YgRxqt+1IOzFLv0DWGFvjGrp
hnQF+6qeSvOjrI2gmgEJB9pp0pQlvUQWaQGKxMKMk3zNO0HXf1151Oi8dsag2JwO
uEnwaeMzcnM1XucDc+IXF6GE/o77juHkA2i0dpafBFwk29+Ld1YfZCk8YJEOzX+W
+N50zNrkwaDGBKwVhhhZl8rluWwEk/C6lAQ4Osg/yu+zefWjaqo=
=vwKw
-----END PGP SIGNATURE-----

--vv7dv6b5v5dmyh5f--
