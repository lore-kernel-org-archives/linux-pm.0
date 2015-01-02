From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 12/17] thermal: exynos: dts: Provide device tree
 bindings identical to one in exynos_tmu_data.c
Date: Fri, 2 Jan 2015 14:13:38 -0400
Message-ID: <20150102181333.GB12130@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-13-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418213396-743-13-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lukasz

On Wed, Dec 10, 2014 at 01:09:51PM +0100, Lukasz Majewski wrote:
> Presented device tree bindings provide data already hardcoded in the
> exynos_tmu_data.c file.
> After this commit, it should be possible to reuse common thermal core
> framework in Exynos SoCs.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - Add proper TMU entries for exynos3250.dtsi
> ---
>  arch/arm/boot/dts/exynos3250.dtsi |  4 ++++
>  arch/arm/boot/dts/exynos4.dtsi    |  5 +++++
>  arch/arm/boot/dts/exynos4210.dtsi | 23 ++++++++++++++++++++++-
>  arch/arm/boot/dts/exynos4x12.dtsi |  3 +++
>  arch/arm/boot/dts/exynos5250.dtsi |  7 +++++--
>  arch/arm/boot/dts/exynos5420.dtsi | 33 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5440.dtsi | 18 ++++++++++++++++++
>  7 files changed, 90 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos=
3250.dtsi
> index 693a327..6edfa76 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -18,7 +18,9 @@
>   */
> =20
>  #include "skeleton.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
>  #include <dt-bindings/clock/exynos3250.h>
> +#include <dt-bindings/thermal/thermal_exynos.h>
> =20
>  / {
>  	compatible =3D "samsung,exynos3250";
> @@ -188,6 +190,8 @@
>  			interrupts =3D <0 216 0>;
>  			clocks =3D <&cmu CLK_TMU_APBIF>;
>  			clock-names =3D "tmu_apbif";
> +			type =3D <SOC_ARCH_EXYNOS3250>;

Why do we need a 'type' property here? Can't we reuse compatible?

> +			#include "exynos4412-tmu-sensor-conf.dtsi"
>  			status =3D "disabled";
>  		};
> =20
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.d=
tsi
> index e0278ec..1735bb3 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -21,6 +21,7 @@
> =20
>  #include <dt-bindings/clock/exynos4.h>
>  #include <dt-bindings/clock/exynos-audss-clk.h>
> +#include <dt-bindings/thermal/thermal_exynos.h>
>  #include "skeleton.dtsi"
> =20
>  / {
> @@ -645,4 +646,8 @@
>  		samsung,sysreg =3D <&sys_reg>;
>  		status =3D "disabled";
>  	};
> +
> +	tmu: tmu@100C0000 {
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos=
4210.dtsi
> index 10e8915..1c52681 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -21,6 +21,8 @@
> =20
>  #include "exynos4.dtsi"
>  #include "exynos4210-pinctrl.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
> +#include <dt-bindings/thermal/thermal_exynos.h>
> =20
>  / {
>  	compatible =3D "samsung,exynos4210", "samsung,exynos4";
> @@ -146,16 +148,35 @@
>  		reg =3D <0x03860000 0x1000>;
>  	};
> =20
> -	tmu@100C0000 {
> +	tmu: tmu@100C0000 {
>  		compatible =3D "samsung,exynos4210-tmu";
>  		interrupt-parent =3D <&combiner>;
>  		reg =3D <0x100C0000 0x100>;
>  		interrupts =3D <2 4>;
>  		clocks =3D <&clock CLK_TMU_APBIF>;
>  		clock-names =3D "tmu_apbif";
> +		gain =3D <15>;
> +		reference_voltage =3D <7>;
> +		type =3D <SOC_ARCH_EXYNOS4210>;
>  		status =3D "disabled";
>  	};
> =20
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			trips {
> +			      cpu_alert0: cpu-alert-0 {
> +				      temperature =3D <85000>; /* millicelsius */
> +			      };
> +			      cpu_alert1: cpu-alert-1 {
> +				      temperature =3D <100000>; /* millicelsius */
> +			      };
> +			      cpu_alert2: cpu-alert-2 {
> +				      temperature =3D <110000>; /* millicelsius */
> +			      };
> +			};
> +		};
> +	};
> +
>  	g2d@12800000 {
>  		compatible =3D "samsung,s5pv210-g2d";
>  		reg =3D <0x12800000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos=
4x12.dtsi
> index 2e9f1f7..ee24d83 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -19,6 +19,8 @@
> =20
>  #include "exynos4.dtsi"
>  #include "exynos4x12-pinctrl.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
> +#include <dt-bindings/thermal/thermal_exynos.h>
> =20
>  / {
>  	aliases {
> @@ -279,6 +281,7 @@
>  		reg =3D <0x100C0000 0x100>;
>  		clocks =3D <&clock 383>;
>  		clock-names =3D "tmu_apbif";
> +		type =3D <SOC_ARCH_EXYNOS4412>;
>  		status =3D "disabled";
>  	};
>  };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos=
5250.dtsi
> index a5bbc1a..2167394 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -20,8 +20,9 @@
>  #include <dt-bindings/clock/exynos5250.h>
>  #include "exynos5.dtsi"
>  #include "exynos5250-pinctrl.dtsi"
> -
> +#include "exynos4-cpu-thermal.dtsi"
>  #include <dt-bindings/clock/exynos-audss-clk.h>
> +#include <dt-bindings/thermal/thermal_exynos.h>
> =20
>  / {
>  	compatible =3D "samsung,exynos5250", "samsung,exynos5";
> @@ -236,12 +237,14 @@
>  		status =3D "disabled";
>  	};
> =20
> -	tmu@10060000 {
> +	tmu: tmu@10060000 {
>  		compatible =3D "samsung,exynos5250-tmu";
>  		reg =3D <0x10060000 0x100>;
>  		interrupts =3D <0 65 0>;
>  		clocks =3D <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif";
> +		type =3D <SOC_ARCH_EXYNOS5250>;
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	thermal-zones {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos=
5420.dtsi
> index 8617a03..23d488b 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -756,6 +756,8 @@
>  		interrupts =3D <0 65 0>;
>  		clocks =3D <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +		type =3D <SOC_ARCH_EXYNOS5420>;
>  	};
> =20
>  	tmu_cpu1: tmu@10064000 {
> @@ -764,6 +766,8 @@
>  		interrupts =3D <0 183 0>;
>  		clocks =3D <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +		type =3D <SOC_ARCH_EXYNOS5420>;
>  	};
> =20
>  	tmu_cpu2: tmu@10068000 {
> @@ -772,6 +776,8 @@
>  		interrupts =3D <0 184 0>;
>  		clocks =3D <&clock CLK_TMU>, <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +		type =3D <SOC_ARCH_EXYNOS5420_TRIMINFO>;
>  	};
> =20
>  	tmu_cpu3: tmu@1006c000 {
> @@ -780,6 +786,8 @@
>  		interrupts =3D <0 185 0>;
>  		clocks =3D <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +		type =3D <SOC_ARCH_EXYNOS5420_TRIMINFO>;
>  	};
> =20
>  	tmu_gpu: tmu@100a0000 {
> @@ -788,6 +796,31 @@
>  		interrupts =3D <0 215 0>;
>  		clocks =3D <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
> +		type =3D <SOC_ARCH_EXYNOS5420_TRIMINFO>;
> +	};
> +
> +	thermal-zones {
> +		cpu0_thermal: cpu0-thermal {
> +			thermal-sensors =3D <&tmu_cpu0>;
> +			#include "exynos5420-trip-points.dtsi"
> +		};
> +		cpu1_thermal: cpu1-thermal {
> +		       thermal-sensors =3D <&tmu_cpu1>;
> +		       #include "exynos5420-trip-points.dtsi"
> +		};
> +		cpu2_thermal: cpu2-thermal {
> +		       thermal-sensors =3D <&tmu_cpu2>;
> +		       #include "exynos5420-trip-points.dtsi"
> +		};
> +		cpu3_thermal: cpu3-thermal {
> +		       thermal-sensors =3D <&tmu_cpu3>;
> +		       #include "exynos5420-trip-points.dtsi"
> +		};
> +		gpu_thermal: gpu-thermal {
> +		       thermal-sensors =3D <&tmu_gpu>;
> +		       #include "exynos5420-trip-points.dtsi"
> +		};
>  	};
> =20
>          watchdog: watchdog@101D0000 {
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos=
5440.dtsi
> index 8f3373c..59d9416 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -219,6 +219,7 @@
>  		interrupts =3D <0 58 0>;
>  		clocks =3D <&clock CLK_B_125>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos5440-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmuctrl_1: tmuctrl@16011C {
> @@ -227,6 +228,7 @@
>  		interrupts =3D <0 58 0>;
>  		clocks =3D <&clock CLK_B_125>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos5440-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmuctrl_2: tmuctrl@160120 {
> @@ -235,6 +237,22 @@
>  		interrupts =3D <0 58 0>;
>  		clocks =3D <&clock CLK_B_125>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos5440-tmu-sensor-conf.dtsi"
> +	};
> +
> +	thermal-zones {
> +		cpu0_thermal: cpu0-thermal {
> +			thermal-sensors =3D <&tmuctrl_0>;
> +			#include "exynos5440-trip-points.dtsi"
> +		};
> +		cpu1_thermal: cpu1-thermal {
> +		       thermal-sensors =3D <&tmuctrl_1>;
> +		       #include "exynos5440-trip-points.dtsi"
> +		};
> +		cpu2_thermal: cpu2-thermal {
> +		       thermal-sensors =3D <&tmuctrl_2>;
> +		       #include "exynos5440-trip-points.dtsi"
> +		};
>  	};
> =20
>  	sata@210000 {
> --=20
> 2.0.0.rc2
>=20

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpt/EAAoJEMLUO4d9pOJWIaMH/iNN7PxKTpwp/q6qfbDfJJ5V
sv8I+Gxe8yYt1lF6CbGJQXelILkpZjlq36VigmsWjuj3FMFMfpO3ttw9JKCo4OBX
72a2LyntxNTjTe1SEAiEdnxXp8oC+6BlxvI7cuMq3qL/Y9f2QzDYNPAq8CXk4Ste
geKOgLG3EN1oP/vOVy8frrWAjBkLGy7mlzkjcJ9yIK8FfxIZ02VNZuRFfHaYQHz3
86o45rRBIY6J/6w2lxPr1ArETUx2ltmzYbXoMpSHZMMWzNXvsxd6BsGUvJkh0Vt3
phNIqcukD24nmkFwXHYlQ6/8GLG422lzeu0wjTM7eYQOdTQo24NYeppPdAfrziI=
=w7kB
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
