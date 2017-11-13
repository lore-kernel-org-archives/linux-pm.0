From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Mon, 13 Nov 2017 11:55:24 +0100
Message-ID: <20171113105524.xdiusofmau36zdeu@earth>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65nbnsdmfj5tfvha"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdKMKz2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Nov 2017 05:55:28 -0500
Content-Disposition: inline
In-Reply-To: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org


--65nbnsdmfj5tfvha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 07, 2017 at 03:43:22PM +0300, Dan Carpenter wrote:
> The original code does this: "1 << (1 << 11)" which is undefined in C.
>=20
> Fixes: dbc4deda03fe ("power: Adds support for Smart Battery System Manage=
r")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis.  Not tested.
>=20
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sb=
s-manager.c
> index ccb4217b9638..cb6e8f66c7a2 100644
> --- a/drivers/power/supply/sbs-manager.c
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32=
 chan)
>  		return ret;
> =20
>  	/* chan goes from 1 ... 4 */
> -	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> +	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
>  	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
>  	if (ret)
>  		dev_err(dev, "Failed to select channel %i\n", chan);

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

sbs-manager has been added to linux-next through the i2c tree due to
dependencies, so this one also needs to go through i2c.

-- Sebastian

--65nbnsdmfj5tfvha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloJehkACgkQ2O7X88g7
+poN+Q/+PWC/wbKnUw50qQkdlp4OPbbaZ4ktchc0U+R4ntpuNQag4OF8RQQeY0yH
8PWlOZ5cbYOyU8t9DdKRwJ0XZfjabfRnH+zuE5E8beYf9HEcwgJPDVOAcFhXcrmv
cZ5lQ1NJQQucHLydxsXj2vBH9+vINEvVjQbomOnjZ+5FKqcoguGiHulsxQiIGfv2
ChxkMXDpHbEzeOQM9pXVcXbCdb7NgRswGPYut4c+hyowOoQU6QV3D+LyEchm3Z/4
Yl0R1qclqLSLHr+tNRuhb+cC0ICUdCxFfgCbjhtxuoR41BoIesybekqKq0xGbBNP
aFW9+faqL3YTlpT/baY8eBhVY79tsoeb2130ryaAHZPpZ/SItcrmOOyYudBRKu+N
HzAYnBp2GuP1a4Qnuczqq1zAoXaQmTPEpA0TSxrklpw5XD+14MfL+vsVbnUVXiQl
eCQTrhCrpxyOOALaCXyqV1Gp5yvPSB9i+fTTnUX7OqQ+nLs96GAXg53h1sqsQj+M
Io9I0ZHH/o+MXVh+T0knKc5QT1gFZcqxoPYQGvpjKeMNED5K5pxFFB5FnMadY+KQ
0R7NJmvNJBlAvOIpD59qYdYH/REYFl/wptI81qyv1OgQ1X1z2VbapHqmIyKj8N65
dBNyaC7JoktkEJGvuXRZRUACnoZKdnYREu9F/UKdxGVLj3WPyII=
=ipBr
-----END PGP SIGNATURE-----

--65nbnsdmfj5tfvha--
