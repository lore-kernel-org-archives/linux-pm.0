From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 11/12] arm64: tegra: add soctherm node for Tegra210
Date: Mon, 14 Mar 2016 12:25:01 -0700
Message-ID: <20160314192500.GE1872@localhost.localdomain>
References: <1457665894-30141-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457665894-30141-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:11:34AM +0800, Wei Ni wrote:
> Adds soctherm node for Tegra210, and add cpu,
> gpu, mem, pllx as thermal-zones. Set critical
> trip temp for cpu and gpu thermal zone.
>=20
> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 60 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra210.dtsi
> index cd4f45ccd6a7..c7ef500a347e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -3,6 +3,7 @@
>  #include <dt-bindings/memory/tegra210-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/tegra124-soctherm.h>
> =20
>  / {
>  	compatible =3D "nvidia,tegra210";
> @@ -802,4 +803,63 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	soctherm: thermal-sensor@0,700e2000 {
> +		compatible =3D "nvidia,tegra210-soctherm";
> +		reg =3D <0x0 0x700e2000 0x0 0x1000>;
> +		interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&tegra_car TEGRA210_CLK_TSENSOR>,
> +			<&tegra_car TEGRA210_CLK_SOC_THERM>;
> +		clock-names =3D "tsensor", "soctherm";
> +		resets =3D <&tegra_car 78>;
> +		reset-names =3D "soctherm";
> +		#thermal-sensor-cells =3D <1>;
> +	};
> +
> +	thermal-zones {
> +		cpu {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <0>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
> +
> +			trips {
> +				cpu_shutdown_trip: shutdown-trip {
> +					temperature =3D <102500>;
> +					hysteresis =3D <1000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +		mem {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;


Why no trips for mem? Why should we  care ?

Please have a look on the binding to check for mandatory properties and
sub nodes.

> +		};
> +		gpu {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <0>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
> +
> +			trips {
> +				gpu_shutdown_trip: shutdown-trip {
> +					temperature =3D <103000>;
> +					hysteresis =3D <1000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +		pllx {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;

ditto

> +		};
> +	};
>  };
> --=20
> 1.9.1
>=20

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5xALAAoJEMLUO4d9pOJWsEcH/0P3RwxImVvxf/9cX8tY19Vh
C5D+jZzSBPPbpcp4EF/OOMVKY+8gbTp6qX7KIPz8JGmRJHS7cFQ0POvZfa57XU3H
JsLG1Xl4/Qi+WVUeR3C5g8OIekMGYKNtUi/ptvwhDdvhpHkbHq26OCR3P6sOwIIC
cfrzwSAg6vM6cqit8BavHZFeIVMr/gt5FC4mil3yJpEK3xzN0/liCIyVK05hO0lp
WGJNzBwzaWi1MZ97grkUz7Ql5DDcM9hrYcHMGE1y0T6PundzEpypyqMqYVEzWQph
lv0BDM8JwC+U+afceBaaaQrrxo9IG8cZpKDsBgga+Bf/hbTd94pcQ+P22zcBc5c=
=TRKa
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
