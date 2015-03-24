From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] cpufreq: exynos: allow build for !THERMAL or
 !CPU_THERMAL cases
Date: Tue, 24 Mar 2015 10:53:57 -0400
Message-ID: <20150324145355.GA29155@developer.hsd1.ca.comcast.net>
References: <2275232.48muFcOOQv@amdc1032>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2275232.48muFcOOQv@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lukasz Majewski <l.majewski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 05:20:22PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Allow driver build for !THERMAL or !CPU_THERMAL cases.
>=20
> The new dependency rule is the same as the one that CPUFREQ_DT
> option has (for cpufreq-dt driver which has the same issue with
> using of_cpufreq_cooling_register()).
>=20
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Fixes: 8b2b4a4e5366 ("cpufreq: exynos: allow modular build")
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/cpufreq/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1b06fc4..f4df4af3 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -28,7 +28,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>  config ARM_EXYNOS_CPUFREQ
>  	tristate "SAMSUNG EXYNOS CPUfreq Driver"
>  	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EX=
YNOS5250
> -	depends on THERMAL
> +	# if CPU_THERMAL is on and THERMAL=3Dm, ARM_EXYNOS_CPUFREQ cannot be =
=3Dy:
> +	depends on !CPU_THERMAL || THERMAL
>  	help
>  	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
>  	  Supported SoC versions are:
> --=20
> 1.8.2.3
>=20
>=20

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEXqDAAoJEMLUO4d9pOJWVJQH/3zwv6mJ5h6011DPNPu5W/8S
0g3IBMCJKzf56jJVQpIjDNpD25KTrgm67WBqtGO6nyU58Hf8RdUVuD100OuchW/S
ICbxgar4geS/KoDsvDcGsuDErmowJVxK8ozyfW+lk7UFz+ZQ2TTZj4pNXO5Gntoq
AXJtrBf6iYcx5nsQlt46u3Csk84bIplhVdUB81QmeZ1Tuio62+bsryvzP+PVvgcZ
g4VsOdFTng75Vh7W9QANNC+oeGbQ0CzbsrFFi1yIr6CLXC8J+E+NM6rNBiQgtM1X
hRj2P4Snehmar+XqQF6PJ6yXgTlwJA5ifsj1QoLrrV81WAh4McI35vRyslp5EOc=
=HGF/
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
