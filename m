From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 3/3] Thermal: kirkwood: Convert to devm_ioremap_resource()
Date: Mon, 4 Mar 2013 08:06:56 +0100
Message-ID: <20130304070656.GG16261@avionic-0098.mockup.avionic-design.de>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
 <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3CDHHB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 02:07:01 -0500
Content-Disposition: inline
In-Reply-To: <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 12:15:34PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/thermal/kirkwood_thermal.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwoo=
d_thermal.c
> index 65cb4f0..e5500ed 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -85,11 +85,9 @@ static int kirkwood_thermal_probe(struct platform_devi=
ce *pdev)
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
>  	thermal =3D thermal_zone_device_register("kirkwood_thermal", 0, 0,
>  					       priv, &ops, NULL, 0, 0);

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNEgQAAoJEN0jrNd/PrOhCDoP/3F57Eiqe1iXx3uiojS6eQ4l
NmsH34tPxzMFObvaLTIzj7SAedHXY2Z20og74TbYH0TQXsSP/1+mAEoh4QJ22Kxs
AYQ4nU99cQXoeiWB0nXBBKc3EcDHNIXFd/BoyQwv233FzbmONAMqNtelG+pHGXK1
+KiwWJVuooIPYT8SpmYHWuAL61LVGhiJ8qIE2P1blR5lee0aNCQA/DOF7dPBzWPK
AKdnf2TLCiztGoNWkqXtzZB0xAzaZmQhwe4gY3wbptcL7YdSaaJESKqYZjitV28H
xoHt0QZCFIVHTHFdqpPPCnSnbcC0QsTjZ9vqkrhLwl6J7xMHFg603lVigPTBjeGA
RdYuIEdcCL6+xdtf19jYmvehLwLJgw+uyLqy9tqSndEGhsy4r3cGFgBwtHfOW+qK
pV0DdT48rV5s6jVWYk34ToPPVMKNdV1luIA+O19QAUKKpen7hlUnHQf3jTKvS087
C1BqnYU6DsvtXeW4j4Ierci6bZ9uanC/OCJlRNp0lAHS+XxK0GAZtFv+yxjbt3T+
k23yVEaOy5zjWajhoGgJ2KwyzseEJb6zWxn/0GdQJWGMX5+iEBauTwmEm6H7SaXp
v1StAOm5ZdevGhmFw1uLdCfQmtNsR+3ylNV3tniR92YG0nCaEpNRwRcFAKZuvgYn
KA7m2JNdLtq13Px4dFgO
=8Dpl
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
