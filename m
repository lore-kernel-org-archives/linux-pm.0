From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v9 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Wed, 30 Jul 2014 13:28:47 +0200
Message-ID: <53D8D6EF.8010503@suse.de>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com> <1406707663-16656-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406707663-16656-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Am 30.07.2014 10:07, schrieb Thomas Abraham:
> For Exynos 4210/5250/5420 based platforms, add CPU operating points a=
nd CPU
> regulator supply properties for migrating from Exynos specific cpufre=
q driver
> to using generic cpufreq drivers.
>=20
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         |    4 +++
>  arch/arm/boot/dts/exynos4210-trats.dts          |    4 +++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +++
>  arch/arm/boot/dts/exynos4210.dtsi               |   14 ++++++++-
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +++
>  arch/arm/boot/dts/exynos5250-snow.dts           |    4 +++
>  arch/arm/boot/dts/exynos5250.dtsi               |   25 +++++++++++++=
+-
>  arch/arm/boot/dts/exynos5420.dtsi               |   38 +++++++++++++=
++++++++++
>  9 files changed, 99 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/=
dts/exynos4210-origen.dts
> index f767c42..887dded 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -334,3 +334,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&buck1_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/d=
ts/exynos4210-trats.dts
> index f516da9..66119dd 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -446,3 +446,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&varm_breg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/a=
rm/boot/dts/exynos4210-universal_c210.dts
> index d50eb3a..bf0a39c 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -492,3 +492,7 @@
>  &mdma1 {
>  	reg =3D <0x12840000 0x1000>;
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&vdd_arm_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/ex=
ynos4210.dtsi
> index bcc9e63..69bac07 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -35,10 +35,22 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@900 {
> +		cpu0: cpu@900 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a9";
>  			reg =3D <0x900>;
> +			clocks =3D <&clock CLK_ARM_CLK>;
> +			clock-names =3D "cpu";
> +			clock-latency =3D <160000>;
> +
> +			operating-points =3D <
> +				1200000 1250000
> +				1000000 1150000
> +				800000	1075000
> +				500000	975000
> +				400000	975000
> +				200000	950000

Nit: Here you left-align the columns ...

> +			>;
>  		};
> =20
>  		cpu@901 {
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot=
/dts/exynos5250-arndale.dts
> index d0de1f5..3b12a97 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -575,3 +575,7 @@
>  		usb-phy =3D <&usb2_phy>;
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boo=
t/dts/exynos5250-smdk5250.dts
> index b4b35ad..f07e834 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -414,3 +414,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dt=
s/exynos5250-snow.dts
> index f2b8c41..91acca7 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -509,4 +509,8 @@
>  	};
>  };
> =20
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> +
>  #include "cros-ec-keyboard.dtsi"
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/ex=
ynos5250.dtsi
> index 492e1ef..97b282c 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -58,11 +58,34 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0>;
>  			clock-frequency =3D <1700000000>;
> +
> +			clocks =3D <&clock CLK_ARM_CLK>;
> +			clock-names =3D "cpu";
> +			clock-latency =3D <140000>;
> +
> +			operating-points =3D <
> +				1700000 1300000
> +				1600000 1250000
> +				1500000 1225000
> +				1400000 1200000
> +				1300000 1150000
> +				1200000 1125000
> +				1100000 1100000
> +				1000000 1075000
> +				 900000 1050000
> +				 800000 1025000
> +				 700000 1012500
> +				 600000 1000000
> +				 500000  975000
> +				 400000  950000
> +				 300000  937500
> +				 200000  925000

=2E.. here you right-align both ...

> +			>;
>  		};
>  		cpu@1 {
>  			device_type =3D "cpu";
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/ex=
ynos5420.dtsi
> index cb2b70e..3154b4c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -59,8 +59,26 @@
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0x0>;
> +			clocks =3D <&clock CLK_ARM_CLK>;
> +			clock-names =3D "cpu-cluster.0";
>  			clock-frequency =3D <1800000000>;
>  			cci-control-port =3D <&cci_control1>;
> +			clock-latency =3D <140000>;
> +
> +			operating-points =3D <
> +				1800000 1250000
> +				1700000 1212500
> +				1600000 1175000
> +				1500000 1137500
> +				1400000 1112500
> +				1300000 1062500
> +				1200000 1037500
> +				1100000 1012500
> +				1000000 987500
> +				 900000 962500
> +				 800000 937500
> +				 700000 912500

=2E.. but here only the left column.

> +			>;
>  		};
> =20
>  		cpu1: cpu@1 {
> @@ -69,6 +87,7 @@
>  			reg =3D <0x1>;
>  			clock-frequency =3D <1800000000>;
>  			cci-control-port =3D <&cci_control1>;
> +			clock-latency =3D <140000>;
>  		};
> =20
>  		cpu2: cpu@2 {
> @@ -77,6 +96,7 @@
>  			reg =3D <0x2>;
>  			clock-frequency =3D <1800000000>;
>  			cci-control-port =3D <&cci_control1>;
> +			clock-latency =3D <140000>;
>  		};
> =20
>  		cpu3: cpu@3 {
> @@ -85,14 +105,29 @@
>  			reg =3D <0x3>;
>  			clock-frequency =3D <1800000000>;
>  			cci-control-port =3D <&cci_control1>;
> +			clock-latency =3D <140000>;
>  		};
> =20
>  		cpu4: cpu@100 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a7";
>  			reg =3D <0x100>;
> +			clocks =3D <&clock CLK_KFC_CLK>;
> +			clock-names =3D "cpu-cluster.1";
>  			clock-frequency =3D <1000000000>;
>  			cci-control-port =3D <&cci_control0>;
> +			clock-latency =3D <140000>;
> +
> +			operating-points =3D <
> +				1300000 1275000
> +				1200000 1212500
> +				1100000 1162500
> +				1000000 1112500
> +				 900000 1062500
> +				 800000 1025000
> +				 700000 975000
> +				 600000 937500

Dito.

> +			>;
>  		};
> =20
>  		cpu5: cpu@101 {
> @@ -101,6 +136,7 @@
>  			reg =3D <0x101>;
>  			clock-frequency =3D <1000000000>;
>  			cci-control-port =3D <&cci_control0>;
> +			clock-latency =3D <140000>;
>  		};
> =20
>  		cpu6: cpu@102 {
> @@ -109,6 +145,7 @@
>  			reg =3D <0x102>;
>  			clock-frequency =3D <1000000000>;
>  			cci-control-port =3D <&cci_control0>;
> +			clock-latency =3D <140000>;
>  		};
> =20
>  		cpu7: cpu@103 {
> @@ -117,6 +154,7 @@
>  			reg =3D <0x103>;
>  			clock-frequency =3D <1000000000>;
>  			cci-control-port =3D <&cci_control0>;
> +			clock-latency =3D <140000>;
>  		};
>  	};
> =20

Since I don't really care which template you choose and can't judge mos=
t
numbers, FWIW

Reviewed-by: Andreas F=E4rber <afaerber@suse.de>

Thanks for resolving the conflict,

Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
