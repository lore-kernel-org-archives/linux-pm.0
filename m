From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: imx: correct driver load sequence for cpu
 cooling
Date: Fri, 7 Nov 2014 14:47:58 -0400
Message-ID: <20141107184749.GB23972@developer>
References: <1413263527-31102-1-git-send-email-B51503@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:46470 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaKGSsH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 13:48:07 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so2824403qgd.36
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 10:48:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1413263527-31102-1-git-send-email-B51503@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <B51503@freescale.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bai,

On Tue, Oct 14, 2014 at 01:12:07PM +0800, Bai Ping wrote:
> From: Bai Ping <b51503@freescale.com>
>=20
> thermal driver should be regisetered after cpufreq driver has
> been registered and probed. Doing so is to make sure that thermal
> driver can get the max cpu cooling states correctly when calling
> get_property.
>=20
> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
> Changes for v2
> -Address the comments from Eduardo Valentin
>=20

Thanks for addressing the comments. Applied in my -fixes queue.

>  drivers/thermal/imx_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 2c516f2..8697caf 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -406,6 +406,10 @@ static int imx_thermal_probe(struct platform_device =
*pdev)
>  	int measure_freq;
>  	int ret;
> =20
> +	if (!cpufreq_get_current_driver()) {
> +		dev_dbg(&pdev->dev, "no cpufreq driver!");
> +		return -EPROBE_DEFER;
> +	}
>  	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> --=20
> 1.9.1
>=20

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXRPHAAoJEMLUO4d9pOJWLswH/0yLGywtU2Z9i3L/Mc4NRmpf
lmwbIBvVzeoT/KG8LUYFpRgFy8tJ74//VGhSSUdE1641o2AMrw+/sVCrgNogj2Tv
/zn4enezRb0y+GdR7OxLAsftYtu+3Zp8+wpzr+tgqYC77TdRL5oiFYKERzORMcHX
F+umloq8lxJhX/VBE2erdd3sFOUBTy0QRbP2xCRcRRFzqVu2laD6NI/LonmNFxUm
L3+tDcG9ztC8gJk0mi0UafGNj8fwhuBoTVW95SIj+JlP+pCJXbN8pMUr61VMVVcO
hHv6ROjtVYzN/QyxZIys9kGZl8LA2uyjvHg8GHdh4vcNVIkgC1oV2wKItBESC78=
=VVoq
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
