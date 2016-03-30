From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 14/14] arm: tegra: set critical trips for Tegra124
Date: Wed, 30 Mar 2016 18:30:32 +0800
Message-ID: <56FBAAC8.1090208@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-15-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:14573 "EHLO
	hkmmgate101.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbcC3KaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 06:30:08 -0400
In-Reply-To: <1459247364-1139-15-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

To: Rob Herring <robh+dt@kernel.org>


On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 18:29, Wei Ni wrote:
> Set general "critical" trip temperatures for cpu, gpu, mem and pllx
> thermal zones for all Tegra124 platform, these trips can trigger
> shut down or reset.
> Tegra124 Jetson TK1 was already set "critical" trips before, so it
> can overwrite the general values.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 18 ++--------
>  arch/arm/boot/dts/tegra124.dtsi           | 60 +++++++++++++++++++++=
++++++++++
>  2 files changed, 63 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boo=
t/dts/tegra124-jetson-tk1.dts
> index 66b4451eb2ca..0e24ecd71ac7 100644
> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> @@ -1931,44 +1931,32 @@
>  	thermal-zones {
>  		cpu {
>  			trips {
> -				trip@0 {
> +				cpu-shutdown-trip {
>  					temperature =3D <101000>;
>  					hysteresis =3D <0>;
>  					type =3D "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				/* There are currently no cooling maps because there are no cool=
ing devices */
> -			};
>  		};
> =20
>  		mem {
>  			trips {
> -				trip@0 {
> +				mem-shutdown-trip {
>  					temperature =3D <101000>;
>  					hysteresis =3D <0>;
>  					type =3D "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				/* There are currently no cooling maps because there are no cool=
ing devices */
> -			};
>  		};
> =20
>  		gpu {
>  			trips {
> -				trip@0 {
> +				gpu-shutdown-trip {
>  					temperature =3D <101000>;
>  					hysteresis =3D <0>;
>  					type =3D "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				/* There are currently no cooling maps because there are no cool=
ing devices */
> -			};
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegr=
a124.dtsi
> index 68669f791c8b..076a384848ba 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -996,6 +996,21 @@
> =20
>  			thermal-sensors =3D
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
> +
> +			trips {
> +				cpu-shutdown-trip {
> +					temperature =3D <103000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
>  		};
> =20
>  		mem {
> @@ -1004,6 +1019,21 @@
> =20
>  			thermal-sensors =3D
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
> +
> +			trips {
> +				mem-shutdown-trip {
> +					temperature =3D <103000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
>  		};
> =20
>  		gpu {
> @@ -1012,6 +1042,21 @@
> =20
>  			thermal-sensors =3D
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
> +
> +			trips {
> +				gpu-shutdown-trip {
> +					temperature =3D <101000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
>  		};
> =20
>  		pllx {
> @@ -1020,6 +1065,21 @@
> =20
>  			thermal-sensors =3D
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
> +
> +			trips {
> +				pllx-shutdown-trip {
> +					temperature =3D <103000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
>  		};
>  	};
> =20
>=20
