From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v2] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 11:33:28 +0200
Message-ID: <20160718093328.GB32259@ulmo.ba.sec>
References: <57726196.5060909@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34202 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbcGRJdd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 05:33:33 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so10764752pac.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2016 02:33:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57726196.5060909@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2016 at 01:37:58PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>=20
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. And there is
> no context to save for this particular block.
>=20
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
>=20
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Add Kevin's Reviewed-by tag.
> Eduardo/Zhang, can you pick this patch up for 4.8?
> ---
>  drivers/thermal/tango_thermal.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_ther=
mal.c
> index 70e0d9f406e9..d571ce2f546d 100644
> --- a/drivers/thermal/tango_thermal.c
> +++ b/drivers/thermal/tango_thermal.c
> @@ -64,6 +64,12 @@ static const struct thermal_zone_of_device_ops ops =3D=
 {
>  	.get_temp	=3D tango_get_temp,
>  };
> =20
> +static void tango_thermal_init(struct tango_thermal_priv *priv)
> +{
> +	writel(0, priv->base + TEMPSI_CFG);
> +	writel(CMD_ON, priv->base + TEMPSI_CMD);
> +}
> +
>  static int tango_thermal_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -79,14 +85,30 @@ static int tango_thermal_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> =20
> +	platform_set_drvdata(pdev, priv);
>  	priv->thresh_idx =3D IDX_MIN;
> -	writel(0, priv->base + TEMPSI_CFG);
> -	writel(CMD_ON, priv->base + TEMPSI_CMD);
> +	tango_thermal_init(priv);
> =20
>  	tzdev =3D devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &op=
s);
>  	return PTR_ERR_OR_ZERO(tzdev);
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int tango_thermal_resume(struct device *dev)
> +{
> +	struct tango_thermal_priv *priv =3D dev_get_drvdata(dev);
> +	tango_thermal_init(priv);

checkpatch will warn about this. You're supposed to separate the local
variable declarations and code by a single blank line.

> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
> +
> +#define DEV_PM_OPS	&tango_thermal_pm
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif

In my experience it's often not useful to #ifdef the struct pm_ops.
These days you almost certainly want PM enabled, and the conditional
doesn't save you all that much in the first place, because it's not
unlikely for this to fit into some of the space that would be padded
out anyway.

As a side-note, I've noticed that this driver has the following
dependencies:

	depends on ARCH_TANGO || COMPILE_TEST

which, last I checked, is probably going to fail on some architectures
because you need at least another one on HAS_IOMEM (for readl() and
writel()). That's a pre-existing problem, of course, so should be fixed
in a separate patch.

Thierry

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXjKJjAAoJEN0jrNd/PrOhexsP/iQ0IOJpChGU4wJ7ijsgHWU+
pIzIjggWwqAnwCkmW6Rb/6D6mIYPOP9o7fK5eXTLujJEvNVuTn39nss7zcSLvEUR
HnQ5WJkyeCHbmzf6nceQuA+K9Wv0EHfMu7b/q2iGBpvPF6vIQBymwpo1Bc+quyp+
ssZQCMem7FPbQhIyvSAjQgwppAErd0MX4077RTgSzZDGwdet9zKZWkfRIqc6NhG7
xwxvVvhUMvaZjgzaDIk6YVyEYMe7UXah0KEAF8EmyRn3u1Y6SUEoTWPUyM4/BJJd
kIh7Th75Uf9suA3aZ/hlAZs0i0r1Pj/DD6CwKEgvNYjmuPr3uzvgD4u0I5/lAnS1
Cwq881JGqtLEKol3+E8oirEUzxVK8Lw5/UwIQDM9G9zeV+HVd1J4GoWvO4Aul5A4
ioEzWySD6Ag1JVX51qGoSNLWgVjhudF4WGZarEZl2ZTDi/sY9Sbu1gisu1OFX4SV
8a3fHJ82IXCpM8kJp+86ROrSjFaBa7jr2kw3lA/Tlkq8CLR/Ad5pOBpETxmpR+4X
7+saJj/c2JOxRoFrKCW+HtmsJ9377KQA2eVN76mscaFJkhvLBRTa06u/838RYgUu
lou1olfOfSKsRr7J5K7e+I2IYDJVH7wRC1yhuuYO8oFWaOgCiIJQSyHgM8DYD/g5
opnZXXZKAODcD1SsWZx2
=yFap
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
