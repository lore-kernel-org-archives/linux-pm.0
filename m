From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 05/12] thermal: tegra: add Tegra210 specific SOC_THERM
 driver
Date: Mon, 14 Mar 2016 11:57:40 -0700
Message-ID: <20160314185739.GA1872@localhost.localdomain>
References: <1457665825-29837-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33272 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbcCNS5n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 14:57:43 -0400
Content-Disposition: inline
In-Reply-To: <1457665825-29837-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:10:25AM +0800, Wei Ni wrote:
> Add Tegra210 specific SOC_THERM driver.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/Makefile            |   1 +
>  drivers/thermal/tegra/soctherm-fuse.c     |  11 ++
>  drivers/thermal/tegra/soctherm.c          |   6 ++
>  drivers/thermal/tegra/soctherm.h          |   4 +
>  drivers/thermal/tegra/tegra210-soctherm.c | 173 ++++++++++++++++++++++++=
++++++

No Kconfig change?

>  5 files changed, 195 insertions(+)
>  create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
>=20
> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makef=
ile
> index d5fb15377b97..bf9e028eba28 100644
> --- a/drivers/thermal/tegra/Makefile
> +++ b/drivers/thermal/tegra/Makefile
> @@ -2,3 +2,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra-soctherm.o
> =20
>  tegra-soctherm-y				:=3D soctherm.o soctherm-fuse.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
> +tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.o
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegr=
a/soctherm-fuse.c
> index 931c299ab0e8..29963180c453 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -28,7 +28,18 @@
>  #define FUSE_TSENSOR_COMMON			0x180
> =20
>  /*
> + * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
> + *    3                   2                   1                   0
> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
>   * Tegra12x, etc:
> + * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bit=
s,
> + * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
> + * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
> + *
>   * FUSE_TSENSOR_COMMON:
>   *    3                   2                   1                   0
>   *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index f56e5a11384e..52a33760e8e8 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -147,6 +147,12 @@ static const struct of_device_id tegra_soctherm_of_m=
atch[] =3D {
>  		.data =3D &tegra124_soctherm,
>  	},
>  #endif
> +#ifdef CONFIG_ARCH_TEGRA_210_SOC
> +	{
> +		.compatible =3D "nvidia,tegra210-soctherm",
> +		.data =3D &tegra210_soctherm,
> +	},
> +#endif
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
> diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soc=
therm.h
> index f80ee1492ddb..69d317269af1 100644
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -106,5 +106,9 @@ int tegra_calc_tsensor_calib(const struct tegra_tsens=
or *sensor,
>  extern const struct tegra_soctherm_soc tegra124_soctherm;
>  #endif
> =20
> +#ifdef CONFIG_ARCH_TEGRA_210_SOC
> +extern const struct tegra_soctherm_soc tegra210_soctherm;
> +#endif

Is CONFIG_ARCH_TEGRA_210_SOC going to be tristate?

If only bool, do you need to make the symbol extern?

> --=20
> 1.9.1
>=20

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5wmgAAoJEMLUO4d9pOJW8NsH/R0XPJy2yNbdHJYjmJCPKAHm
MalLHllL9n131aKCG7tXbdFh/QTKou6D9sqIJ23wshZkaLm6NFH79VI4NqqiEAlz
dFMOwhzg6WLseXoRHnM6dfGZZY9dRCR1Ib9O4gVA+ksicLYhb+EOtIT13oopVDXc
P3Yr/1RKKs5HI7OIo1Ckwj4NgfiYZ71/wKmSeBlU2eYyrSZl5bKkNqXGli9u5jIB
05aVo4Z4IX+/6AO/XaPr45KZYl8utIkgaCLgXegC4mfvcf07QRSChdOkWy/Uch7A
B7xQxASkZoYz/cfUvnoO6QGNmsXi76qQ2fe0TpgvN3sfc+M6For/mYAf5wFXAJA=
=NcPA
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
