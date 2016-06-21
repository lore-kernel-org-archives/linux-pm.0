From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current limit management
Date: Tue, 21 Jun 2016 13:30:49 +0300
Message-ID: <878txyomue.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23960 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbcFUKe0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 06:34:26 -0400
In-Reply-To: <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_device=
 *pdev)
>  		}
>  	}
>=20=20
> +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
> +		power->usb_charger =3D
> +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);

the fact that you rely on strings and pass them via pdata is an
indication that you don't have enough description of the HW. Seems like
we need to come up with a set of DT properties which tie a charger to a
UDC.

I'm thinking a phandle would be enough?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaRdZAAoJEIaOsuA1yqREWksP/3H62lJ2lTqKX3DhMAKRJyK7
zpq0+xXK++/Y+jPDseQhFL8FlxMvOnkIgxZwJ6BX1jE8bj4opr17+H4fvbevi0e5
Hz9kGCLQrQWmjypAuDI9jD5a8wL4fc6ei0tBcsr6dH/5dts8lqZy8YOFmbyLdsni
1kSe3IZiwfDlj5iDLQmt6x/Fe5eLZ51223JzAuRCqhYnWMYcJX/WlW3oR+J8TPVD
EQ1LDvVnmw/xnAi8Ez81ttDTZOoFALJzD8yrMi8bP/Jzb0vADMkLNxLMj9o3KN66
scD7Hj2kxC6HNQVKyQ9l50UpLH5FNR/Xo6niOP5RqtywliOBrFG2k6byQ46u6Ow7
WFABSaprC7GCzby98YapXnHQwIwinpg0kRIwql5gbs5fGhR0q+aXKypnohlcK2o3
sv8YaMsWK0cSJeh/91ML9jPYfw/iqfqZ4kO8uY1ncNR0BdNsKG7QyWTgu27r+jEa
A5K4OHBrkRzY/oGkK8w7m/sS6jCe+n6GHhqcs36QOjWEkca+cQKkhZavu5Ad2NKc
Sd/pltYy2UqFQ1M47hEax0HuzedoZZ9fNtlTKaP3uM4wuwxgyv0WUEMQxULyYXt+
qeurXpyS/GSh087tlRG7/18KenZtIoMt0tCq0faFq4YW3flznynobAWgtcpBiJ43
e39cEK1HqI14wa0ksS7f
=Wca5
-----END PGP SIGNATURE-----
--=-=-=--
