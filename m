From: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 10/10] arm64: dts: Create SoC thermal zone for Juno
Date: Wed, 12 Aug 2015 16:55:00 +0100
Message-ID: <20150812155500.GW20890@e106497-lin.cambridge.arm.com>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
 <1438615378-14241-11-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438615378-14241-11-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 03, 2015 at 04:22:58PM +0100, Punit Agrawal wrote:
> Setup a thermal zone driven by the SoC temperature sensor on Juno
> r0. Create passive trip points and bind them to cpufreq cooling
> devices that support the power extensions.

Hi Punit,

>=20
> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/arm/juno.dts | 50 ++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/a=
rm/juno.dts
> index d2e67f3..664961c 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -9,6 +9,7 @@
>  /dts-v1/;
> =20
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> =20
>  / {
>  	model =3D "ARM Juno development board (r0)";
> @@ -90,6 +91,8 @@
>  			next-level-cache =3D <&A57_L2>;
>  			clocks =3D <&scpi_dvfs 0>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <530>;

The Documentation/devicetree/bindings/thermal/thermal.txt document desc=
ribes two additional
required properties, cooling-min-state and cooling-max-state which are =
missing here.

>  		};
> =20
>  		A57_1: cpu@1 {
> @@ -100,6 +103,8 @@
>  			next-level-cache =3D <&A57_L2>;
>  			clocks =3D <&scpi_dvfs 0>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <530>;
>  		};
> =20
>  		A53_0: cpu@100 {
> @@ -110,6 +115,8 @@
>  			next-level-cache =3D <&A53_L2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <140>;
>  		};
> =20
>  		A53_1: cpu@101 {
> @@ -120,6 +127,8 @@
>  			next-level-cache =3D <&A53_L2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <140>;
>  		};
> =20
>  		A53_2: cpu@102 {
> @@ -130,6 +139,8 @@
>  			next-level-cache =3D <&A53_L2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <140>;
>  		};
> =20
>  		A53_3: cpu@103 {
> @@ -140,6 +151,8 @@
>  			next-level-cache =3D <&A53_L2>;
>  			clocks =3D <&scpi_dvfs 1>;
>  			cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
> +			#cooling-cells =3D <2>;
> +			dynamic-power-coefficient =3D <140>;
>  		};
> =20
>  		A57_L2: l2-cache0 {
> @@ -167,5 +180,42 @@
>  				     <&A53_3>;
>  	};
> =20
> +	thermal-zones {
> +		soc_thermal {
> +			polling-delay =3D <1000>;
> +			polling-delay-passive =3D <100>;
> +			sustainable-power =3D <2500>;
> +
> +			thermal-sensors =3D <&scpi_sensors0 3>;
> +
> +			trips {
> +				threshold: trip-point@0 {

You also need a reg=3D property if you have the @index thing.

Best regards,
Liviu

> +					temperature =3D <55000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +				target: trip-point@1 {
> +					temperature =3D <65000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&target>;
> +					cooling-device =3D <&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution =3D <2048>;
> +				};
> +				map1 {
> +					trip =3D <&target>;
> +					cooling-device =3D <&A57_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution =3D <1024>;
> +				};
> +
> +			};
> +		};
> +	};
> +
>  	#include "juno-base.dtsi"
>  };
> --=20
> 2.1.4
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
