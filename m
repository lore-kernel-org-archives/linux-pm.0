From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 03/12] thermal: tegra: get rid of PDIV/HOTSPOT hack
Date: Mon, 14 Mar 2016 13:05:40 -0700
Message-ID: <20160314200539.GH1872@localhost.localdomain>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com>
 <1457665763-29781-4-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33391 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbcCNUFo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 16:05:44 -0400
Content-Disposition: inline
In-Reply-To: <1457665763-29781-4-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:09:14AM +0800, Wei Ni wrote:
> Get rid of T124-specific PDIV/HOTSPOT hack.
> tegra-soctherm.c contained a hack to set the SENSOR_PDIV and
> SENSOR_HOTSPOT_OFFSET registers - it just did two writes of
> T124-specific opaque values.  Convert these into a form that can be
> substituted on a per-chip basis, and into structure fields that have
> at least some independent meaning.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/tegra-soctherm.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/thermal/teg=
ra/tegra-soctherm.c
> index b3ec0faa2bee..b4b791ebfbb6 100644
> --- a/drivers/thermal/tegra/tegra-soctherm.c
> +++ b/drivers/thermal/tegra/tegra-soctherm.c
> @@ -48,14 +48,12 @@
>  #define SENSOR_CONFIG2_THERMB_SHIFT		0
> =20
>  #define SENSOR_PDIV				0x1c0
> -#define SENSOR_PDIV_T124			0x8888
>  #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
>  #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
>  #define SENSOR_PDIV_MEM_MASK			(0xf << 4)
>  #define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
> =20
>  #define SENSOR_HOTSPOT_OFF			0x1c4
> -#define SENSOR_HOTSPOT_OFF_T124			0x00060600
>  #define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
>  #define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
>  #define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
> @@ -436,6 +434,7 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	int err;
> +	u32 pdiv, hotspot;
> =20
>  	const struct tegra_tsensor *tsensors =3D t124_tsensors;
>  	const struct tegra_tsensor_group **ttgs =3D tegra124_tsensor_groups;
> @@ -493,8 +492,19 @@ static int tegra_soctherm_probe(struct platform_devi=
ce *pdev)
>  			goto disable_clocks;
>  	}
> =20
> -	writel(SENSOR_PDIV_T124, tegra->regs + SENSOR_PDIV);
> -	writel(SENSOR_HOTSPOT_OFF_T124, tegra->regs + SENSOR_HOTSPOT_OFF);
> +	/* Program pdiv and hotspot offsets per THERM */
> +	pdiv =3D readl(tegra->regs + SENSOR_PDIV);
> +	hotspot =3D readl(tegra->regs + SENSOR_HOTSPOT_OFF);
> +	for (i =3D 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
> +		pdiv =3D REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
> +				    ttgs[i]->pdiv);
> +		if (ttgs[i]->id !=3D TEGRA124_SOCTHERM_SENSOR_PLLX)
> +			hotspot =3D  REG_SET_MASK(hotspot,
> +						ttgs[i]->pllx_hotspot_mask,
> +						ttgs[i]->pllx_hotspot_diff);
> +	}
> +	writel(pdiv, tegra->regs + SENSOR_PDIV);
> +	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);

Is the above logic the same for all supported chips? e.g. do we always
skip pllx for hotspot configuration?


> =20
>  	/* Initialize thermctl sensors */
> =20
> --=20
> 1.9.1
>=20

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEbBAEBAgAGBQJW5xmOAAoJEMLUO4d9pOJWx3EH+ORR3Bpaw3GY8+k6+iC5zwHm
QU0U5kiEvCkD9j9j2s7urrgTuk0+yUXo4fty+pc+2XBsOXQ3m5opJ67p7yX53KQw
yVocUcbsbOqV2J+5ZnhQl8rlbpvJS73LiA71bBO7oE0B5eZBHJwj6cmTL6X5Ia5H
3FFVep2sjFWgD8E8a4FlZaez/Of8ejfqHoJ0n07GBWPtgUiRlYzoEntQKjC4h8VO
zHcdWK24LAWN1uwFmJUG36P/YaQgxUu3XoXnzj6D8ZDbDfn93A39DA3trPWhKz9/
e0P0alSm3I+vsFWt0A9QDkthLTcZ0Sffs2UoT5AO2F+UOH0ihcNC6sXRMW1q3g==
=usE0
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
