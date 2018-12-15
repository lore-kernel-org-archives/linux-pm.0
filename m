From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] arm64: tegra: Add thermal zones on Tegra194
Date: Sat, 15 Dec 2018 09:28:14 -0800
Message-ID: <20181215172812.GA10700@localhost.localdomain>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
 <20181123121839.18573-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123121839.18573-2-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 23, 2018 at 01:18:38PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The NVIDIA Tegra194 SoC defines six thermal zones. Define all of them in
> device tree.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

The patch 1 I added in my -linus branch.

> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 39 ++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index cbba7395a286..39169f6b6166 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>  #include <dt-bindings/reset/tegra194-reset.h>
>  #include <dt-bindings/power/tegra194-powergate.h>
> +#include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
> =20
>  / {
>  	compatible =3D "nvidia,tegra194";
> @@ -938,6 +939,44 @@
>  		mbox-names =3D "rx", "tx";
>  	};
> =20
> +	thermal-zones {
> +		cpu {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_CPU>;
> +			status =3D "disabled";
> +		};
> +
> +		gpu {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_GPU>;
> +			status =3D "disabled";
> +		};
> +
> +		aux {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_AUX>;
> +			status =3D "disabled";
> +		};
> +
> +		pllx {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_PLLX>;
> +			status =3D "disabled";
> +		};
> +
> +		ao {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_AO>;
> +			status =3D "disabled";
> +		};
> +
> +		tj {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX>;
> +			status =3D "disabled";
> +		};
> +	};
> +
>  	timer {
>  		compatible =3D "arm,armv8-timer";
>  		interrupts =3D <GIC_PPI 13
