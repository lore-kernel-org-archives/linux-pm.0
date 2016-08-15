From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH -next] power: axp288_fuel_gauge: remove duplicated
 include from axp288_fuel_gauge.c
Date: Tue, 16 Aug 2016 00:39:19 +0200
Message-ID: <20160815223918.xemswtdh2lioazvt@earth>
References: <1471079207-9668-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g724cnt6dm2ydigh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57168 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201AbcHOWjY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 18:39:24 -0400
Content-Disposition: inline
In-Reply-To: <1471079207-9668-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org


--g724cnt6dm2ydigh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 13, 2016 at 09:06:47AM +0000, Wei Yongjun wrote:
> Remove duplicated include.
>=20
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, queued.

-- Sebastian

--g724cnt6dm2ydigh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXskSWAAoJENju1/PIO/qaTPIP+QFYQLnWjhMaJcqZEILZkFLk
mcM6jS0KnvzcECiKIYEdmJVXqA5GItftXvps6THGsDX/e1Waxtk7Zv6wy2GxjHZZ
W4G6OjVyG0PGukegTH1N+RuwAAphcm5WAw/vJNmi+2XSYnQK2tLvGHjWmAvjWUgU
j+sZ7s7LjmQPMQswAze5vDrCQPH7n8sqh5xkMwJwg37P6hF2mFiSrwiariTb9/jD
45YretPwfSo40L6dHGxS34hfcG7wTbQAwwEYnsXKnx7fWiCjA0SE7SAy7NV752l3
dYDTkjR1Q0gpn9y94V0/apm+Ofy7lGi1LPTLavdXIKbOwM/3s7B70FrwMT12/vyW
MmiD8P5HwYJdKx4Ecgb2PknzS2TSEK0sC4gy8a+ogf4JjUeHe4BhUecAY/6WN5N1
6/5bpHAAnutrKaOcwxIBcc63zU6VwczMfODC+In/41P6UYA2TVjhbk1nwiEDPrWi
XxGkxzOdI428tODPCrEUkL2mfioAPIt6+/wc/KB4/3k5Wkrj8MrCgKhVbWZohmmF
YaE+iv7avxE0thK06EZBnQfOGASz4rpG+X+RAdwADIVVS4phbafUeE8FRzmUYaUh
XBhXRQBSmDTbwVz3hlGjfx7Q+J8muK1rW7gwrdt0B0w8hx2R7Zr+r40Y/mkmk26F
qnyj0gmqmqvDzrT93HxH
=kb8y
-----END PGP SIGNATURE-----

--g724cnt6dm2ydigh--
