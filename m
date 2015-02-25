From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [v3 2/2] ARM: qcom: dts: Add tsens thermal data
Date: Wed, 25 Feb 2015 15:45:05 -0400
Message-ID: <20150225194501.GD2983@developer.amazonguestwifi.org>
References: <1424760442-12564-1-git-send-email-nrajan@codeaurora.org>
 <1424760442-12564-3-git-send-email-nrajan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424760442-12564-3-git-send-email-nrajan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Narendran Rajan <nrajan@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 10:47:22PM -0800, Narendran Rajan wrote:
> This patch adds dtsi file to contain thermal data for
> tsens sensors present in qcom A family chipsets (msm8660,
> ipq8064 etc). The data enables cooling with CPUfreq cooling
> device at 60C and thermal shutdown at 100C
>=20
> This thermal data can be resued across qcom A family chipsets
>=20
> Signed-off-by: Narendran Rajan <nrajan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 27 +++++++++++++++++++--
>  arch/arm/boot/dts/qcom-msm8660.dtsi | 27 +++++++++++++++++++--
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 28 ++++++++++++++++++++--
>  arch/arm/boot/dts/qcom-thermal.dtsi | 47 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 123 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-thermal.dtsi
>=20
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom=
-ipq8064.dtsi
> index cb225da..661ed46 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -13,7 +13,7 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible =3D "qcom,krait";
>  			enable-method =3D "qcom,kpss-acc-v1";
>  			device_type =3D "cpu";
> @@ -23,7 +23,7 @@
>  			qcom,saw =3D <&saw0>;
>  		};
> =20
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible =3D "qcom,krait";
>  			enable-method =3D "qcom,kpss-acc-v1";
>  			device_type =3D "cpu";
> @@ -273,11 +273,34 @@
>  			qcom,controller-type =3D "pmic-arbiter";
>  		};
> =20
> +		imem: memory@700000 {
> +			compatible =3D "qcom,qfprom", "syscon";
> +			reg =3D <0x00700000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			stride =3D <1>;
> +			ranges =3D <0x0 0x00700000 0x1000>;
> +		};
> +
> +		thermal-zones {
> +			#include "qcom-thermal.dtsi"
> +		};
> +
>  		gcc: clock-controller@900000 {
>  			compatible =3D "qcom,gcc-ipq8064";
>  			reg =3D <0x00900000 0x4000>;
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
> +			tsens: tsens-ipq8064 {
> +				compatible =3D "qcom,qcom-tsens";
> +				qcom,calib-offsets =3D <0x400 0x410>;
> +				qcom,tsens-slopes =3D <1176 1176 1154 1176 1111
> +						     1132 1132 1199 1132 1199
> +						     1132>;
> +				qcom,qfprom =3D <&imem 0x400 11>, <&imem 0x410 11>;
> +				qcom,qfprom-names =3D "calib", "backup_calib";
> +				#thermal-sensor-cells =3D <1>;
> +			};
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom=
-msm8660.dtsi
> index 0affd61..4eb002c 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -15,7 +15,7 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible =3D "qcom,scorpion";
>  			enable-method =3D "qcom,gcc-msm8660";
>  			device_type =3D "cpu";
> @@ -23,7 +23,7 @@
>  			next-level-cache =3D <&L2>;
>  		};
> =20
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible =3D "qcom,scorpion";
>  			enable-method =3D "qcom,gcc-msm8660";
>  			device_type =3D "cpu";
> @@ -73,11 +73,34 @@
>  			#interrupt-cells =3D <2>;
>  		};
> =20
> +		imem: memory@700000 {
> +			compatible =3D "qcom,qfprom", "syscon";
> +			reg =3D <0x00700000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			stride =3D <1>;
> +			ranges =3D <0x0 0x00700000 0x1000>;
> +		};
> +
> +		thermal-zones {
> +			#include "qcom-thermal.dtsi"
> +		};
> +
>  		gcc: clock-controller@900000 {
>  			compatible =3D "qcom,gcc-msm8660";
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
>  			reg =3D <0x900000 0x4000>;
> +			tsens: tsens-msm8660 {
> +				compatible =3D "qcom,qcom-tsens";
> +				qcom,calib-offsets =3D <0x400 0x410>;
> +				qcom,tsens-slopes =3D <1176 1176 1154 1176 1111
> +						     1132 1132 1199 1132 1199
> +						     1132>;

This may be moved to coefficients thermal zone properties.

> +				qcom,qfprom =3D <&imem 0x400 11>, <&imem 0x410 11>;
> +				qcom,qfprom-names =3D "calib", "backup_calib";
> +				#thermal-sensor-cells =3D <1>;
> +			};
>  		};
> =20
>  		gsbi12: gsbi@19c00000 {
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom=
-msm8960.dtsi
> index e1b0d5c..3722816 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -16,7 +16,7 @@
>  		#size-cells =3D <0>;
>  		interrupts =3D <1 14 0x304>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible =3D "qcom,krait";
>  			enable-method =3D "qcom,kpss-acc-v1";
>  			device_type =3D "cpu";
> @@ -26,7 +26,7 @@
>  			qcom,saw =3D <&saw0>;
>  		};
> =20
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible =3D "qcom,krait";
>  			enable-method =3D "qcom,kpss-acc-v1";
>  			device_type =3D "cpu";
> @@ -84,11 +84,35 @@
>  			reg =3D <0x800000 0x4000>;
>  		};
> =20
> +		imem: memory@700000 {
> +			compatible =3D "qcom,qfprom", "syscon";
> +			reg =3D <0x00700000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			stride =3D <1>;
> +			ranges =3D <0x0 0x00700000 0x1000>;
> +		};
> +
> +		thermal-zones {
> +			#include "qcom-thermal.dtsi"
> +		};
> +
>  		gcc: clock-controller@900000 {
>  			compatible =3D "qcom,gcc-msm8960";
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
>  			reg =3D <0x900000 0x4000>;
> +
> +			tsens: tsens-msm8960 {
> +				compatible =3D "qcom,qcom-tsens";
> +				qcom,calib-offsets =3D <0x400 0x410>;
> +				qcom,tsens-slopes =3D <1176 1176 1154 1176 1111
> +						     1132 1132 1199 1132 1199
> +						     1132>;
> +				qcom,qfprom =3D <&imem 0x400 11>, <&imem 0x410 11>;
> +				qcom,qfprom-names =3D "calib", "backup_calib";
> +				#thermal-sensor-cells =3D <1>;
> +			};
>  		};
> =20
>  		clock-controller@4000000 {
> diff --git a/arch/arm/boot/dts/qcom-thermal.dtsi b/arch/arm/boot/dts/qcom=
-thermal.dtsi
> new file mode 100644
> index 0000000..963a597
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-thermal.dtsi
> @@ -0,0 +1,47 @@
> +/*
> + * Device Tree Source for ipq8064 SoC thermal
> + *
> + * Copyright (c) 2015 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +cpu_thermal0: cpu_thermal0 {
> +	polling-delay-passive =3D <2000>; /* milliseconds */
> +	polling-delay =3D <5000>; /* milliseconds */
> +
> +			/* sensor	ID */
> +	thermal-sensors =3D <&tsens	0>;
> +	linux,hwmon;
> +
> +	trips {
> +		thermal0_cpu_alert: thermal0_cpu_alert {
> +			temperature =3D <60000>; /* millicelsius */
> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "passive";
> +		};
> +		thermal0_cpu_crit: thermal0_cpu_crit {
> +			temperature =3D <100000>; /* millicelsius */
> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "critical";
> +		};
> +	};
> +
> +	cooling-maps {
> +			map0 {
> +				trip =3D <&thermal0_cpu_alert>;
> +				cooling-device =3D
> +					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +	};
> +};
> --=20
> Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is =
a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>=20

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7iY1AAoJEMLUO4d9pOJWf6UH/1ehuCKde2DY5r3oq3kLhX8R
OOiu8H4v1sODjoFrVDpIqWrmq2AnOnzRH8+dR6PaSLfgoW5hqQGOWOmWruhuhzAF
QUr2mN2UH5TOoGWT+4/Lrc4aYFR+x3pzq2SKUdvbZE23zvsDRIVY2GE75EE3qr9k
gyK7cJ7+FFuO1x3SlpuYNS8YndaxmMUYKi9095I9NWSNZohKrLBzYHzX5ne01qC6
eWSatdNrXj69BQtFASsYHQSZyq9kHZymoaA/JGbV7HcZmLEIH1cO8Ouk9aFNSbiO
wG0wrDZqdgn/tu9/1oF2Ls09ae8r2oqTtsreu25ZgSsjG/M/Mjkb1U2BdvNd8C0=
=67MT
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
