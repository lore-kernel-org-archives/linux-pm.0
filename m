From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] extcon: Split out extcon header file for consumer and
 provider device
Date: Fri, 29 Sep 2017 15:44:27 +0200
Message-ID: <20170929134427.wcsne3pf6qobw6ra@earth>
References: <CGME20170929000148epcas2p200e56186b067ec626a033c7ae2d4bbdb@epcas2p2.samsung.com>
 <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xpqingb6v2gf6lh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33276 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdI2Nob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 09:44:31 -0400
Content-Disposition: inline
In-Reply-To: <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: balbi@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org, lee.jones@linaro.org, heiko@sntech.de, yoshihiro.shimoda.uh@renesas.com, krzk@kernel.org, b.zolnierkie@samsung.com, maxime.ripard@free-electrons.com, wens@csie.org, chanwoo@kernel.org, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org


--3xpqingb6v2gf6lh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 29, 2017 at 09:01:45AM +0900, Chanwoo Choi wrote:
> The extcon has two type of extcon devices as following.
> - 'extcon provider deivce' adds new extcon device and detect the
>    state/properties of external connector. Also, it notifies the
>    state/properties to the extcon consumer device.
> - 'extcon consumer device' gets the change state/properties
>    from extcon provider device.
> Prior to that, include/linux/extcon.h contains all exported API for
> both provider and consumer device driver. To clarify the meaning of
> header file and to remove the wrong use-case on consumer device,
> this patch separates into extcon.h and extcon-provider.h.
>=20
> [Description for include/linux/{extcon.h|extcon-provider.h}]
> - extcon.h includes the extcon API and data structure for extcon consumer
>   device driver. This header file contains the following APIs:
>   : Register/unregister the notifier to catch the change of extcon device
>   : Get the extcon device instance
>   : Get the extcon device name
>   : Get the state of each external connector
>   : Get the property value of each external connector
>   : Get the property capability of each external connector
>=20
> - extcon-provider.h includes the extcon API and data structure for extcon
>   provider device driver. This header file contains the following APIs:
>   : Include 'include/linux/extcon.h'
>   : Allocate the memory for extcon device instance
>   : Register/unregister extcon device
>   : Set the state of each external connector
>   : Set the property value of each external connector
>   : Set the property capability of each external connector
>=20

[...]

>  drivers/power/supply/qcom_smbb.c              |   2 +-

[...]

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--3xpqingb6v2gf6lh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnOTjgACgkQ2O7X88g7
+pqyRw//UB2CmgweYLhikRFPftmhHfk+jzWgv2K5wULvqM0HS77+mBmHAMDLU6L4
PAF8LzVMe3iI9qdw4EX8A5FCLQVA7HRi5NWeCnVjK8iUspO0Y86EPDEnohjN6HTC
CAzQ/FclbXa6jqD2xDjh3G/ESoFgs7LRoPtnxQ27xbPm0YrdmxR6/OfmV0J3b7+V
a2ObOGlT2qQw8FiCfq1B2PBqRNG1sPUIg1Ob298X5sb8a4NR5mw30hOwOVJGQpbn
KJ0d8LD80E3DeuL09YmCpjX+kWOftuSj65fef7CYtCCZxbYhp7+znUw9/HPdqBiO
vCKsIRk08M9M0Kzvg7u0l20TyCkzrVrFckdtt2f66mcL4s8ujAA1ydNO0/icZc5j
lvDK2jjZeAykIqDZ/us0F5Atw+Q/GMOJOG1bGv4TKVDwJMkXLUc0/PjAfxUkSfIc
DXFpqLCOZQRgKT8ZYrbu9ZeDSJVVIUxMGG0HMvNt0JBfkrNmiZ8qznwBiIDvdqqj
hgHFHgJgj1XK7bt2S48PPqzdnrYF0GaXtVAddXovLYHL66k9Sy/iIhoaAizTE1Cb
+zDOq3Kq2F3rVX5ZTJWwilJWO/Y92OvMJpr2821TJOeMkGipHxYz/sjU2Xl1k2sw
HdBO4QZqYw1ea/wAwFqQ3zovuNTcvvfAHG1LR6sLhEXdIL8WqjY=
=DjCE
-----END PGP SIGNATURE-----

--3xpqingb6v2gf6lh--
