From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/4] arm64: tegra: Add BPMP thermal sensor to Tegra186
Date: Fri, 30 Jun 2017 16:56:05 -0700
Message-ID: <20170630235603.GA2943@localhost.localdomain>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35289 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdF3X4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 19:56:10 -0400
Content-Disposition: inline
In-Reply-To: <20170616112825.31025-1-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, rui.zhang@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jun 16, 2017 at 02:28:22PM +0300, Mikko Perttunen wrote:
> This adds the thermal sensor device provided by the BPMP, and the
> relevant thermal sensors to the Tegra186 device tree.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 48 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra186.dtsi
> index 5e62e68ac053..5c19ea74da24 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>  #include <dt-bindings/power/tegra186-powergate.h>
>  #include <dt-bindings/reset/tegra186-reset.h>
> +#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
> =20
>  / {
>  	compatible =3D "nvidia,tegra186";
> @@ -444,6 +445,53 @@
>  			#size-cells =3D <0>;
>  			status =3D "disabled";
>  		};
> +
> +		bpmp_thermal: thermal {
> +			compatible =3D "nvidia,tegra186-bpmp-thermal";
> +			#thermal-sensor-cells =3D <1>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		a57 {
> +			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_CPU>;
> +		};
> +
> +		denver {
> +			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AUX>;
> +		};
> +
> +		gpu {
> +			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_GPU>;
> +		};
> +
> +		pll {
> +			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_PLLX>;
> +		};
> +
> +		always_on {
> +			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AO>;
> +		};

All the above zones are lacking mandatory fields. Please refer to the
thermal binding documentation.=20

>  	};
> =20
>  	timer {
> --=20
> 2.13.1
>=20
