From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Fri, 1 Dec 2017 16:27:53 +0100
Message-ID: <20171201152753.7c5l47q2voqdgsdp@earth>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiqo7d4eej7fqedu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbdLAP16 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 10:27:58 -0500
Content-Disposition: inline
In-Reply-To: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org


--hiqo7d4eej7fqedu
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

Thanks, queued.

-- Sebastian

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

--hiqo7d4eej7fqedu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohdPcACgkQ2O7X88g7
+pp2/Q//XxwsaWnRR/ygD/mFUMMo818lBVMOkyKK3jhV2kEM2LJGwOHyy96XiIKz
2wJV4xqBGPbV8eMZwNSj0VoL5/2Ros2fHpKOy2H6NWbotjy/TdLFq57nXkn64PU4
ehVkXg8kiuVW/XB8oIllls4UGIR/vToek1BACjrqSRjK8RjUuegCVlepUk+XIto6
U9LQOsHjiKGsjBGiwQJbA2AtyAQej2sKMndv8q0mKz3kIIIGfI7aFAf/BwgVsIin
9aCd2xwrxsewpzIAsdHkAjjVUUPsIFs4cBAsiQWMInj0EGYwxNlgnNdKxqi+9YK4
n2MPDTHcR/5GUhXz+dj4KOQoX/mweXJQo+sZQhHABS4Yy+rSifQJPZFmLvlY+4iS
wEOlO6JFxuK83IBBZi+erXojA2W3V2fp5az2a6vg1qIvhwsLBDxRnPzXugnI5ebB
s+xzn9pXINzUOVt3Mw0r8LrIZu03p8sp/G12bVK2uwxsc7jPONrZXdtULP/xZz6O
7ymGKAhiPmePWl6ZI7dFTiqoS6OsjQMouwyPkDsu9jpgGtNtmnF9S71LNIZcIkMk
D/wBCQudbR+KrlFXaRAp7ExIsBsAvbToC/qDNGwrujUWg2UrOGsBjv20gGOb/Gdi
UnBMbT8jRFqBvEn07K+gEry0WABQe5vu9b+cTjsDzWFVIrNR/Kw=
=lXai
-----END PGP SIGNATURE-----

--hiqo7d4eej7fqedu--
