From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: imx: Do not print error message in the
 EPROBE_DEFER case
Date: Thu, 11 Dec 2014 19:14:07 -0400
Message-ID: <20141211231405.GA19853@developer>
References: <1418332300-7859-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:56176 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbaLKXON (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 18:14:13 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so4313630qab.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 15:14:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418332300-7859-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabio,

On Thu, Dec 11, 2014 at 07:11:40PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> During imx_thermal probe we have the following log:
>=20
> [    1.514819] imx_thermal 2000000.aips-bus:tempmon: failed to register c=
pufreq cooling device: -517
> [    1.515064] platform 2000000.aips-bus:tempmon: Driver imx_thermal requ=
ests probe deferral
>=20
> Avoid printing the error message in the EPROBE_DEFER case.
>=20

Thanks for your patch. But I am queuing a different patch that does a
similar job.

https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git=
/commit/?h=3Dfixes&id=3D0f1be51c358f740fe5183bd0bcd60076fdfb53d0

Can you please check my -fixes branch? When EPROBE_DEFER happens, we are
now printing a debug message only.

Cheers,

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/thermal/imx_thermal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index bb08d6e..c1188ac 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -513,8 +513,10 @@ static int imx_thermal_probe(struct platform_device =
*pdev)
>  	data->cdev =3D cpufreq_cooling_register(cpu_present_mask);
>  	if (IS_ERR(data->cdev)) {
>  		ret =3D PTR_ERR(data->cdev);
> -		dev_err(&pdev->dev,
> -			"failed to register cpufreq cooling device: %d\n", ret);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"failed to register cpufreq cooling device: %d\n",
> +				ret);
>  		return ret;
>  	}
> =20
> --=20
> 1.9.1
>=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiiUrAAoJEMLUO4d9pOJW6JUH/3onSChnC2aPyPbUu93JkrHm
D7TZBjCsw3uhGJF7H5k0ItMDY/PnIVCdY1K8dnYbqGcnjVb7v+8+IXEfixUCSuux
/2BiWwHZs7dAjmUlC8+dMHm65svyFhAuoSYVFIHdRC1tjgk7tuxFKXVtFuWBjcy9
i/VdC4BHoyjjbQ9FOtx82g0RKqCA7+Hvxpe9eQvNuNzCmauKal8iUhhtw6kkyNBl
3AIxcwQSqJl78B5EYU+QXSmVqvRFjwbfRX8CTAOVSgwazcwk/aMbVIdGxTlV2Fae
St7nQzw4qwrZ5B5MHnWb0gt778IQM+ObvUmTAQ9cQJT8vtwY1g+mjM1EdhMEwN8=
=6KW3
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
