From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH -next] power: axp288_charger: remove duplicated include
 from axp288_charger.c
Date: Tue, 16 Aug 2016 00:39:38 +0200
Message-ID: <20160815223937.riwsi2kofhcyo4d3@earth>
References: <1471079227-9753-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oveky3hsuyfkkblh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57274 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184AbcHOWjs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 18:39:48 -0400
Content-Disposition: inline
In-Reply-To: <1471079227-9753-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org


--oveky3hsuyfkkblh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 13, 2016 at 09:07:07AM +0000, Wei Yongjun wrote:
> Remove duplicated include.
>=20
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/power/supply/axp288_charger.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, queued.

-- Sebastian

--oveky3hsuyfkkblh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXskSpAAoJENju1/PIO/qa3OkP/0Cjzs6hhAMRxdXrmTlDieuc
399xSyXC0Wan9Y5VTGcA206GCfFcLBTDn71Lby3/K9PJJq7qifBXf7bq4BBTlPSF
wTcm0Iw9qe49NaiRnW7vFMjoB4ZpxmrwT+L9G6OSddP6O2Xx0hckjhQ0M3I9n3oI
1WVxvdLEddI276rQJGrdot6xcS3OGa9jkB39KZREqohTmCo7+jvYmD5/MuiWax5g
j1UpOKvCpJVUX5ENtQHSYg4vf6iZu7pkznZQ/X+U2nV2U39KFYroBvg5ZW9KunE6
WZrhZa4cM5jbkyxlW3otqn0jPkeJBLLKDWh1t0m910eEAZnNzlwkz4vZUXZUxaAw
G3FJ1eDqBJw8nxwFoY9bSJqx+QPFmGBry0Z3AyjmXRfn74JdvCSCQGEz5xnGl1MJ
7ziZDZaEmKTIJHUAYX9SFJsCUhz/u4D0fOSy9mxpEvP5/TI7np742ojlB0wJ+02b
qdBTXqO+g1TTUHSnQfTPmreIeIMz60d54raP/zOsYZXZ31oWS5TcrCYvF4K3F/mh
c1ddpmvPWLASiQQWWP77ppIPB8uSBQ4Lyj+pGq2FTZ/0mp6eujQ8913GR5wr2+mu
sQ1LxAtv49BRvg9BDnI8VfbsTrv1BN5Ghx8uK2a7BKZmJxvTO3KU0QwVZE5t+XAB
u9AofOnDy2cokkYY/NNL
=S4o2
-----END PGP SIGNATURE-----

--oveky3hsuyfkkblh--
