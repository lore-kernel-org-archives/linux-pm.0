From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Wed, 28 Jan 2015 13:22:11 -0400
Message-ID: <20150128172209.GF29600@developer.hsd1.ca.comcast.net>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1422451015-390439-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5215344865465122021=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422451015-390439-4-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============5215344865465122021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 02:16:55PM +0100, Arnd Bergmann wrote:
> The exynos cpufreq driver code recently gained a dependency on the
> cooling code, which may be a loadable module. This breaks an ARM
> allmodconfig build:
>=20
> drivers/built-in.o: In function `exynos_cpufreq_probe':
> :(.text+0x1748e8): undefined reference to `of_cpufreq_cooling_register'
>=20
> To avoid this problem, change cpufreq Kconfig to allow the drivers
> to be loadable modules as well and enforce a dependency on the
> thermal module. Also, export the symbols that are used for communicating
> between the three cpu-specific parts of the driver and the main module.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e725d26c4857 ("cpufreq: exynos: Use device tree to determine if cp=
ufreq cooling should be registered")
> ---
>  drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
>  drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
>  drivers/cpufreq/exynos4210-cpufreq.c |  1 +
>  drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
>  drivers/cpufreq/exynos5250-cpufreq.c |  1 +
>  5 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0f9a2c3c0e0d..99ac56746ebd 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -26,11 +26,12 @@ config ARM_VEXPRESS_SPC_CPUFREQ
> =20
> =20
>  config ARM_EXYNOS_CPUFREQ
> -	bool
> +	tristate
> =20
>  config ARM_EXYNOS4210_CPUFREQ
> -	bool "SAMSUNG EXYNOS4210"
> +	tristate "SAMSUNG EXYNOS4210"
>  	depends on CPU_EXYNOS4210
> +	depends on THERMAL
>  	default y
>  	select ARM_EXYNOS_CPUFREQ
>  	help
> @@ -40,8 +41,9 @@ config ARM_EXYNOS4210_CPUFREQ
>  	  If in doubt, say N.
> =20
>  config ARM_EXYNOS4X12_CPUFREQ
> -	bool "SAMSUNG EXYNOS4x12"
> +	tristate "SAMSUNG EXYNOS4x12"
>  	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
> +	depends on THERMAL
>  	default y
>  	select ARM_EXYNOS_CPUFREQ
>  	help
> @@ -51,8 +53,9 @@ config ARM_EXYNOS4X12_CPUFREQ
>  	  If in doubt, say N.
> =20
>  config ARM_EXYNOS5250_CPUFREQ
> -	bool "SAMSUNG EXYNOS5250"
> +	tristate "SAMSUNG EXYNOS5250"
>  	depends on SOC_EXYNOS5250
> +	depends on THERMAL
>  	default y
>  	select ARM_EXYNOS_CPUFREQ
>  	help
> @@ -62,9 +65,10 @@ config ARM_EXYNOS5250_CPUFREQ
>  	  If in doubt, say N.
> =20
>  config ARM_EXYNOS5440_CPUFREQ
> -	bool "SAMSUNG EXYNOS5440"
> +	tristate "SAMSUNG EXYNOS5440"
>  	depends on SOC_EXYNOS5440
>  	depends on HAVE_CLK && OF
> +	depends on THERMAL
>  	select PM_OPP
>  	default y
>  	help

Reading the code briefly, looks like the intention is to separate soc
specific code into different files, but they all compose one single
driver. Translating into module, I believe it makes sense to build them
into a single module, instead of having all of them as separate module.

Meaning, only ARM_EXYNOS_CPUFREQ becomes tristate, all the remaining
continues bool. And we add the following Makefile change to your patch

---
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3..c3c3cf5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -26,13 +26,19 @@ config ARM_VEXPRESS_SPC_CPUFREQ
=20
=20
 config ARM_EXYNOS_CPUFREQ
-	bool
+	tristate "SAMSUNG EXYNOS CPUfreq Driver"
+	depends on THERMAL
+	default y
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS platforms
+
+	  If in doubt, say N.
=20
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
 	depends on CPU_EXYNOS4210
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4210
 	  SoC (S5PV310 or S5PC210).
@@ -42,8 +48,8 @@ config ARM_EXYNOS4210_CPUFREQ
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4X12
 	  SoC (EXYNOS4212 or EXYNOS4412).
@@ -54,7 +60,7 @@ config ARM_EXYNOS5250_CPUFREQ
 	bool "SAMSUNG EXYNOS5250"
 	depends on SOC_EXYNOS5250
 	default y
-	select ARM_EXYNOS_CPUFREQ
+	depends on ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0..b26e2bf 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,10 +51,11 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+=3D arm_big_little_dt=
=2Eo
=20
 obj-$(CONFIG_ARCH_DAVINCI)		+=3D davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+=3D dbx500-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+=3D exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+=3D exynos4210-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+=3D exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+=3D exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+=3D arm-exynos-cpufreq.o
+arm-exynos-cpufreq-y					:=3D exynos-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+=3D exynos4210-cpufre=
q.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+=3D exynos4x12-cpufre=
q.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+=3D exynos5250-cpufre=
q.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+=3D exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o

> diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cp=
ufreq.h
> index 9f2062a7cc02..32a895af4961 100644
> --- a/drivers/cpufreq/exynos-cpufreq.h
> +++ b/drivers/cpufreq/exynos-cpufreq.h
> @@ -53,7 +53,7 @@ struct exynos_dvfs_info {
>  	void __iomem	*cmu_regs;
>  };
> =20
> -#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS4210_CPUFREQ)
>  extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
> @@ -61,7 +61,7 @@ static inline int exynos4210_cpufreq_init(struct exynos=
_dvfs_info *info)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS4X12_CPUFREQ)
>  extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
> @@ -69,7 +69,7 @@ static inline int exynos4x12_cpufreq_init(struct exynos=
_dvfs_info *info)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS5250_CPUFREQ)
>  extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
> diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exyno=
s4210-cpufreq.c
> index 843ec824fd91..4b5de19f0ea2 100644
> --- a/drivers/cpufreq/exynos4210-cpufreq.c
> +++ b/drivers/cpufreq/exynos4210-cpufreq.c
> @@ -182,3 +182,4 @@ err_moutcore:
>  	pr_debug("%s: failed initialization\n", __func__);
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(exynos4210_cpufreq_init);
> diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exyno=
s4x12-cpufreq.c
> index 9e78a850e29f..d2924e1bc909 100644
> --- a/drivers/cpufreq/exynos4x12-cpufreq.c
> +++ b/drivers/cpufreq/exynos4x12-cpufreq.c
> @@ -234,3 +234,4 @@ err_moutcore:
>  	pr_debug("%s: failed initialization\n", __func__);
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(exynos4x12_cpufreq_init);
> diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exyno=
s5250-cpufreq.c
> index 3eafdc7ba787..b2810b839331 100644
> --- a/drivers/cpufreq/exynos5250-cpufreq.c
> +++ b/drivers/cpufreq/exynos5250-cpufreq.c
> @@ -208,3 +208,4 @@ err_moutcore:
>  	pr_err("%s: failed initialization\n", __func__);
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(exynos5250_cpufreq_init);

and certainly we would not need to export such functions anymore

> --=20
> 2.1.0.rc2
>=20

BR,

Eduardo

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUyRq1AAoJEMLUO4d9pOJWv28H/2fRnu0+n0HpVMbyjJaiW8CG
fA3CtfjQgPmurshBtqh3FtpYYnLhv9KR6VuPEe/FbDwZ7j0gSTVqkBb0m6u5l7PC
0W94GQwGll1XPE/uYU9EMyEXGNzOvFKPXAklWmDHYYt4LSN8N3VzdR3OkO6Kl/Cz
UgIk/6kUeq8fcI9vOtidC+5gAC62wa0+matht5LUgP4MYWuT1RrB+jvQPh29kYT8
nAoahK973EAKQC06VRQIFskp7D2vW21ab0d/KGAsQCukuZPVdN8mNoru4y9asae/
nYWVcwHmW7SXT1pFRp2lXHx5AhITDT2+yF9gfmj12hixmbIMJnrfGwc7gPg5rw8=
=1uHa
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--


--===============5215344865465122021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5215344865465122021==--
