From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 13/16] thermal: exynos: dts: Provide device tree
 bindings identical to the one in exynos_tmu_data.c
Date: Wed, 14 Jan 2015 15:05:52 -0400
Message-ID: <20150114190550.GB4105@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-14-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421242874-3425-14-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 02:41:11PM +0100, Lukasz Majewski wrote:
> Presented device tree bindings provide data already hardcoded in the
> exynos_tmu_data.c file.
> After this commit, it should be possible to reuse common thermal core
> framework in Exynos SoCs.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - Add proper TMU entries for exynos3250.dtsi
> Changes for v3:
> - Remove "type" DT properties, which will be extracted from compatible
> - "samsung,tmu_" prefix for TMU specific properties has been added
>=20
> ---
>  arch/arm/boot/dts/exynos3250.dtsi |  2 ++
>  arch/arm/boot/dts/exynos4.dtsi    |  4 ++++
>  arch/arm/boot/dts/exynos4210.dtsi | 21 ++++++++++++++++++++-
>  arch/arm/boot/dts/exynos4x12.dtsi |  1 +
>  arch/arm/boot/dts/exynos5250.dtsi |  5 +++--
>  arch/arm/boot/dts/exynos5420.dtsi | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5440.dtsi | 18 ++++++++++++++++++
>  7 files changed, 76 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos=
3250.dtsi
> index 2246549..8cc078c 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "skeleton.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
>  #include <dt-bindings/clock/exynos3250.h>
> =20
>  / {
> @@ -188,6 +189,7 @@
>  			interrupts =3D <0 216 0>;
>  			clocks =3D <&cmu CLK_TMU_APBIF>;
>  			clock-names =3D "tmu_apbif";
> +			#include "exynos4412-tmu-sensor-conf.dtsi"
>  			status =3D "disabled";
>  		};
> =20
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.d=
tsi
> index b8168f1..f18d746 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -645,4 +645,8 @@
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
> index 2e66df8..7f0e012 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -21,6 +21,7 @@
> =20
>  #include "exynos4.dtsi"
>  #include "exynos4210-pinctrl.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
> =20
>  / {
>  	compatible =3D "samsung,exynos4210", "samsung,exynos4";
> @@ -146,16 +147,34 @@
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
> +		samsung,tmu_gain =3D <15>;
> +		samsung,tmu_reference_voltage =3D <7>;
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
> index 93b7040..3ee2031 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -19,6 +19,7 @@
> =20
>  #include "exynos4.dtsi"
>  #include "exynos4x12-pinctrl.dtsi"
> +#include "exynos4-cpu-thermal.dtsi"
> =20
>  / {
>  	aliases {
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos=
5250.dtsi
> index dd5c3a0..07fd73a 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -20,7 +20,7 @@
>  #include <dt-bindings/clock/exynos5250.h>
>  #include "exynos5.dtsi"
>  #include "exynos5250-pinctrl.dtsi"
> -
> +#include "exynos4-cpu-thermal.dtsi"
>  #include <dt-bindings/clock/exynos-audss-clk.h>
> =20
>  / {
> @@ -236,12 +236,13 @@
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
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	thermal-zones {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos=
5420.dtsi
> index 517e50f..f5771e5 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -761,6 +761,7 @@
>  		interrupts =3D <0 65 0>;
>  		clocks =3D <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmu_cpu1: tmu@10064000 {
> @@ -769,6 +770,7 @@
>  		interrupts =3D <0 183 0>;
>  		clocks =3D <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmu_cpu2: tmu@10068000 {
> @@ -777,6 +779,7 @@
>  		interrupts =3D <0 184 0>;
>  		clocks =3D <&clock CLK_TMU>, <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmu_cpu3: tmu@1006c000 {
> @@ -785,6 +788,7 @@
>  		interrupts =3D <0 185 0>;
>  		clocks =3D <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
>  	};
> =20
>  	tmu_gpu: tmu@100a0000 {
> @@ -793,6 +797,30 @@
>  		interrupts =3D <0 215 0>;
>  		clocks =3D <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
>  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> +		#include "exynos4412-tmu-sensor-conf.dtsi"
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

For all thermal zones added in this patch, can you please make sure they
all've got the mandatory fields?

>  	};
> =20
>  	sata@210000 {
> --=20
> 2.0.0.rc2
>=20

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUtr4FAAoJEMLUO4d9pOJWjIkH/0484r4nyy5TEKp9aqTTqG7v
qji2m5VEradajWYxIQbGwje7Qz+zgfp+ox1paLZ4ISHXzeaM1p+I6X1XTuIMN3KD
vI8R6Ebq14ZWXtVKzioK1YMcGxreYCSsXIRZkiN0YYXNFZWfxkYcNcyn8V4UpFHQ
upIye3gIEuhmOI4/nP0lHb3vozPgxBpidMldlx2j6yPhStZ/rNuyrtO2QNq8RYjS
EeUrJwstrhrjCaRd2ayieyr/JtdCsnOzhcRI+bnf0LbZzHgXG+KXNb6HanYVJqOT
yj1FiEwDZv3B8pj5oWUyRm7hTRM51X3VEdxGmVcotrieryglMOqxG//WubVVG2M=
=ZmDg
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
