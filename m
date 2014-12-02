From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 04/26] thermal: exynos: Handle -EPROBE_DEFER properly
Date: Tue, 2 Dec 2014 19:08:22 -0400
Message-ID: <20141202230820.GD3432@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <79bbedd743bdd82f37a578ece26359432ddccc72.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48137 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbaLBXIc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:08:32 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so10285006qcv.15
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:08:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <79bbedd743bdd82f37a578ece26359432ddccc72.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2014 at 03:13:58PM +0530, Viresh Kumar wrote:
> cpufreq_cooling_register() can return -EPROBE_DEFER if cpufreq driver isn=
't
> ready yet and so the callers must defer their initialization.
>=20
> Exynos thermal drivers weren't handling this well and were raising false =
error
> message when -EPROBE_DEFER is returned to them.
>=20
> Fix them to handle -EPROBE_DEFER.

As mentioned in patch 0, this one has been merged to another patch.

>=20
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c | 7 ++++---
>  drivers/thermal/samsung/exynos_tmu.c            | 4 +++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/th=
ermal/samsung/exynos_thermal_common.c
> index bf39212..0be1d54 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -369,9 +369,10 @@ int exynos_register_thermal(struct thermal_sensor_co=
nf *sensor_conf)
>  		th_zone->cool_dev[th_zone->cool_dev_size] =3D
>  				cpufreq_cooling_register(cpu_present_mask);
>  		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
> -			dev_err(sensor_conf->dev,
> -				"Failed to register cpufreq cooling device\n");
> -			ret =3D -EINVAL;
> +			ret =3D PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(sensor_conf->dev,
> +					"Failed to register cpufreq cooling device\n");
>  			goto err_unregister;
>  		}
>  		th_zone->cool_dev_size++;
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 49c0924..cc3677f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -683,7 +683,9 @@ static int exynos_tmu_probe(struct platform_device *p=
dev)
>  	/* Register the sensor with thermal management interface */
>  	ret =3D exynos_register_thermal(sensor_conf);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to register thermal interface\n");
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"Failed to register thermal interface\n");
>  		goto err_clk;
>  	}
>  	data->reg_conf =3D sensor_conf;
> --=20
> 2.0.3.693.g996b0fd
>=20

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkZaAAoJEMLUO4d9pOJWlmsH/jISSdR+Tm302pGUkfnxQN/O
zz1+Id6mp2QfclZGY+aNQ4bUi9vr5cmvZYkkzizbhy4dRawFZQ+Rbyhlpfrr676P
QRLvTvRMTFBhmeBtP5boUkEH6vd11lnUYW88W2OLqWmbR8ecFdonrKoo0vn5fUYW
WbkSQVc0L1lXBdlAvL+0mLGOJXuFjGC1EncCsn3qfCf0GBoLkSkkxHrGly3IxRYK
/Avl7rByohOnVOcCBGgZV2o7t1z8djZYDUOUdnk85DhhUuENYnzo5nDbZpQmPJg7
ZKLXyHDfe9/qGrfdFBpcajrekDUKl5IiSW6E/UFKWz/ryi7yWNtQHG6/JtGE2qE=
=skHu
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
