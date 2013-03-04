From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/3] Thermal: dove: Convert to devm_ioremap_resource()
Date: Mon, 4 Mar 2013 08:06:04 +0100
Message-ID: <20130304070604.GE16261@avionic-0098.mockup.avionic-design.de>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65194 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab3CDHGJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 02:06:09 -0500
Content-Disposition: inline
In-Reply-To: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Andrew Lunn <andrew@lunn.ch>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 12:15:32PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/thermal/dove_thermal.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_therma=
l.c
> index 7b0bfa0..3078c40 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -143,22 +143,18 @@ static int dove_thermal_probe(struct platform_devic=
e *pdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->sensor) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->sensor))
> +		return PTR_ERR(priv->sensor);
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!res) {
>  		dev_err(&pdev->dev, "Failed to get platform resource\n");
>  		return -ENODEV;
>  	}
> -	priv->control =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->control) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	priv->control =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->control))
> +		return PTR_ERR(priv->control);
> =20
>  	ret =3D dove_init_sensor(priv);
>  	if (ret) {

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNEfcAAoJEN0jrNd/PrOhBcwP/j2I5+OJAWSl36dyYFpTn+hl
agF8ByBilclvJNpOzW+fBv5iy6aZ5b7WIeZ+4mMf4WeUjzMP3K0AIwBwo/Fv1+HX
eFHdyyhwRQWf3pdZXHHD7dm4FOdBRFQNtuy4IXW2+r7s9juBRFtpNLcU+4fTYsuq
cV1zAm2Izo78uqm0DA/xQc6LjjFCvuaZ7oPa9TirsN2IEXPawC1KAJEMkixwWVrw
3QClnqp9fL7X18DDF1sZIoLaiGs4eBN4inWoaUx4uLxjqtIrAFGdAYtR2kB/I0DQ
OFfqsFeAaJ+XMnEH9HlYc3reAYvDzQERjr6TwUACKOu9NhWupmlwaTloZl2mKrVm
bKWpQJ/K0z/qZKQkDfQVHUHC3J01s1gKiJXDIk0W9Tnz9STYn2frWlGQ2xQEPFIj
Skd+zhksqwnzsHvKXIHV8/bRIjvaZglAJosoBXIrHO0EGgkZlQzt/AgbbWr6YMF0
vgKAH4+NVeMqgf6ecyWDLwN7B16iqd/9MyLZ7D3Z6kUCDCJoYQ/PMJKO5MynaoFt
igmNqcKoHAdNdrbrhArZDZ7xdCMce/oE13vqW39+SMGQqWWPd/XMABzzagHylQ8G
yv1n11+axXkVkvICucjjVFIrEASxivWNyH6w2lie19e9gk3FulQEEZ61WacL13Ip
/EeZE71rkBWZZoBSG+Se
=WEcf
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
