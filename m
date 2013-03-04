From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/3] Thermal: rcar: Convert to devm_ioremap_resource()
Date: Mon, 4 Mar 2013 08:06:29 +0100
Message-ID: <20130304070629.GF16261@avionic-0098.mockup.avionic-design.de>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
 <1362379534-30662-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62433 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3CDHGj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 02:06:39 -0500
Content-Disposition: inline
In-Reply-To: <1362379534-30662-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 12:15:33PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_therma=
l.c
> index 28f0919..b28990a 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -399,11 +399,9 @@ static int rcar_thermal_probe(struct platform_device=
 *pdev)
>  		/*
>  		 * rcar_has_irq_support() will be enabled
>  		 */
> -		common->base =3D devm_request_and_ioremap(dev, res);
> -		if (!common->base) {
> -			dev_err(dev, "Unable to ioremap thermal register\n");
> -			return -ENOMEM;
> -		}
> +		common->base =3D devm_ioremap_resource(dev, res);
> +		if (IS_ERR(common->base))
> +			return PTR_ERR(common->base);
> =20
>  		/* enable temperature comparation */
>  		rcar_thermal_common_write(common, ENR, 0x00030303);
> @@ -422,11 +420,9 @@ static int rcar_thermal_probe(struct platform_device=
 *pdev)
>  			return -ENOMEM;
>  		}
> =20
> -		priv->base =3D devm_request_and_ioremap(dev, res);
> -		if (!priv->base) {
> -			dev_err(dev, "Unable to ioremap priv register\n");
> -			return -ENOMEM;
> -		}
> +		priv->base =3D devm_ioremap_resource(dev, res);
> +		if (IS_ERR(priv->base))
> +			return PTR_ERR(priv->base);
> =20
>  		priv->common =3D common;
>  		priv->id =3D i;

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNEf1AAoJEN0jrNd/PrOhsNIQAJmFski4VULaXdPgBXj0FTA5
n5dz08k+18rtSpe8nrsqWXL5uuYyhblDYLrwXz719wrSZIFdC5z732yaVLX57exf
59YLDBliLMJkPy453hNwmfhyl8Xua+AFnVXUSZ8g/gM6eiV6G/5Zbct5X+VQpROZ
SWzu385zLYaUzyGGG7IRCV7yCzHRR1Ad86L5X7Ur+Zz0RBTX8FWHOGhYXuiXXj0v
5q1PkEg4W3AaaI/NZ8FMl0pPN9CU8fdu4nvp80zIZv4MV5uzrKrcp2hDg0uGCMKS
v74zoBXpTf1/lq9cVy7ScM2R/DOzllbf9D5dkVqCQjP5P4ZZuehPn7cMHnBlot6A
DJI35CVWbHPaCZdc3O14QMkTPBCTl6wkb1Sme6Ov4shyzv4bqi0QOtiL4Onx7eds
MGefYzCQIAI5YiWKoSfo4htso3CCssNAMzY3wdH1Ujxd0B2N9bEugx+a+DoJx0Yn
VO0lkChy7g6C2fMLcUftVY/J3St/ve0WK3njc4i80ge0zz8i7RizVn8FzSJYgczK
ET4NZAlaYL5capptWzIpRy/n7DwABdVF9JIxQ1K4tSvTc9pMWvrF+Z23/TfZXHGF
she65QBPvfxVKXnqn03ceroKkjrZ5HgP36Oji4Y4R6LzvKApXfDmpwUSzKtJW7mT
V9f0L4si1moU1ZoDODAq
=MuH+
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
