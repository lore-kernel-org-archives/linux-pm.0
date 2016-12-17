From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/8] power: supply: tps65217: Support USB charger
 feature
Date: Sat, 17 Dec 2016 17:24:00 +0100
Message-ID: <20161217162400.7yqiibcrkzp5ac3q@earth>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="je2j4h53n2ygckoz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756897AbcLQQYF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 11:24:05 -0500
Content-Disposition: inline
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--je2j4h53n2ygckoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 09, 2016 at 04:48:58PM +0900, Milo Kim wrote:
> TPS65217 device supports two charger inputs - AC and USB.
> Currently, only AC charger is supported. This patch-set adds USB charger=
=20
> feature. Tested on Beaglebone black.
>=20
> Patch 1: Main patch
> Patch 2, 3: Clean up for charger driver data
> Patch 4 ~ 8: Naming changes for generic power supply class structure
>=20
> v2:
>   Regenerate the patchset for better code review
>=20
> Milo Kim (8):
>   power: supply: tps65217: Support USB charger interrupt
>   power: supply: tps65217: Use 'poll_task' on unloading the module

patches look fine, but these two patches must be reordered to fix
bisectability. Otherwise after patch 1 the thread is not properly
killed during driver removal.

-- Sebastian

--je2j4h53n2ygckoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVZp0ACgkQ2O7X88g7
+pophw/+I80hO/jiVdV1f+vZ+hR5mvtMIkWzvbtD7bDcxguA5nBacpkMNBxe9SvZ
kWHRX9rda7eoQjemy9aDx1J3vnc0Px6TG+usJeM+K/qIcMjf5yKucWKnFLXA0P84
s9RCUBLo//6LI43ZHnRWL/n8OQFt222gr+WVmF3YtjMHhNIiCxuolbmIGXqxqy7K
Nb2oKij/laDOXct8hrKU108HwBTD9DXeOxFnQSS4nnHL5m2sw1VWTzpO3yG3zsfH
+gaXe4GgeQVJmn78PklcS6YrxkFexBWHwi3x1C5C0m01w4fCnxixmD4oERe6+DPq
nSEMA/XU5pE/rFJ8Dz6RHmXKNKga/NEDgs1lBrgpMiaDehnQi63RnxH/Frl9NYvY
k+nFdAwME01SYCIw/ZGBmYTG/dsb8pef5B9ah4otfy1YqBpi9UBA9PqDRyofRePc
uubohXvZ24J8m4smAKLo6Ofsug2BU2jEq/4YbO2zT89P/4XMWzOvwfwtLoiAVzgE
b5pl4tGg3u7yW9OoRhu3RWwhnLbYOhz1Q/qokcCF0NbWMelYGuAddsO4eDNzpJQX
ZS9NF3YXHX/2VkA0f0kZCL9UC41Zrj7MoJJy8EYwh2DiZUorbeXWvmRWk2H+5PV9
iiO43CPFBTmpA60XI+FozA5987RoLX3k3LStf8/DumZvdvDcfj8=
=SCu/
-----END PGP SIGNATURE-----

--je2j4h53n2ygckoz--
