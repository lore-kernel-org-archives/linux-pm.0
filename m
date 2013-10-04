From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/2] thermal: TI: remove TI_THERMAL dependency on CPU_THERMAL
Date: Fri, 4 Oct 2013 12:38:04 -0400
Message-ID: <524EEEEC.80805@ti.com>
References: <1412622.ASunnW5zzY@amdc1032>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TkHviQwhismBvmKDlP0Dufiw4eeUgWqd8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56824 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab3JDQir (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 12:38:47 -0400
In-Reply-To: <1412622.ASunnW5zzY@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

--TkHviQwhismBvmKDlP0Dufiw4eeUgWqd8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04-10-2013 08:39, Bartlomiej Zolnierkiewicz wrote:
> Cover cpufreq_get_current_driver() call in ti-thermal-common.c with
> CPU_FREQ ifdefs and remove no longer needed CPU_THERMAL dependency
> from TI_THERMAL config option (stubs for other cpufreq functions for
> CPU_THERMAL=3Dn case are already available).
>=20
> Please note that this enables TI_THERMAL config option in the final
> config derived from omap2plus_defconfig (which enables CPU_THERMAL
> config option but without CPU_FREQ one so TI_THERMAL config option
> was not enabled previously in the final config).
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/thermal/ti-soc-thermal/Kconfig             | 1 -
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/t=
i-soc-thermal/Kconfig
> index bd4c7be..bf5d6e4 100644
> --- a/drivers/thermal/ti-soc-thermal/Kconfig
> +++ b/drivers/thermal/ti-soc-thermal/Kconfig
> @@ -13,7 +13,6 @@ config TI_SOC_THERMAL
>  config TI_THERMAL
>  	bool "Texas Instruments SoCs thermal framework support"
>  	depends on TI_SOC_THERMAL
> -	depends on CPU_THERMAL

Until the code that uses cpu thermal is still present in the driver, I
would prefer to have this dependency, for runtime proper behavior. The
driver design is still to take the responsibility to load the cpufreq
cooling device. Up to now they are still dependent.

>  	help
>  	  If you say yes here you want to get support for generic thermal
>  	  framework for the Texas Instruments on die bandgap temperature sens=
or.
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drive=
rs/thermal/ti-soc-thermal/ti-thermal-common.c
> index 4f8b9af..94d91af 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -357,10 +357,12 @@ int ti_thermal_register_cpu_cooling(struct ti_ban=
dgap *bgp, int id)
>  	if (!data)
>  		return -EINVAL;
> =20
> +#ifdef CONFIG_CPU_FREQ
>  	if (!cpufreq_get_current_driver()) {
>  		dev_dbg(bgp->dev, "no cpufreq driver yet\n");
>  		return -EPROBE_DEFER;
>  	}
> +#endif

I would prefer not to have this ifdef here.

> =20
>  	/* Register cooling device */
>  	data->cool_dev =3D cpufreq_cooling_register(cpu_present_mask);
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--TkHviQwhismBvmKDlP0Dufiw4eeUgWqd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF0EAREIAAYFAlJO7u4ACgkQCXcVR3XQvP2KJwEAhL6YwH0/DGCLl56G9muH9OkN
vPPSu6rFX92Cg8D6ThUA9jhEUOPmCznJgmFNXgtb8eZ/klCGQbGYgCl5d3LsT50=
=5GCu
-----END PGP SIGNATURE-----

--TkHviQwhismBvmKDlP0Dufiw4eeUgWqd8--
