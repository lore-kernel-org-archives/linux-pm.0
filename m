From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [1/2] arm64: dts: r8a7795: add thermal cooling management
Date: Mon, 1 Jan 2018 10:12:07 -0800
Message-ID: <20180101181204.GA3567@localhost.localdomain>
References: <20170913105909.13230-2-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170913105909.13230-2-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 13, 2017 at 12:59:08PM +0200, Niklas S=F6derlund wrote:
> Add nodes and properties for thermal cooling management support.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>

Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 40 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/d=
ts/renesas/r8a7795.dtsi
> index 0ccac86bccc6b6f0..1818fd20660d0315 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -53,6 +53,7 @@
>  				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
>  				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
>  				<&cluster0_opp_tb7>;
> +			#cooling-cells =3D <2>;
>  		};
> =20
>  		a57_1: cpu@1 {
> @@ -67,6 +68,7 @@
>  				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
>  				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
>  				<&cluster0_opp_tb7>;
> +			#cooling-cells =3D <2>;
>  		};
> =20
>  		a57_2: cpu@2 {
> @@ -81,6 +83,7 @@
>  				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
>  				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
>  				<&cluster0_opp_tb7>;
> +			#cooling-cells =3D <2>;
>  		};
> =20
>  		a57_3: cpu@3 {
> @@ -95,6 +98,7 @@
>  				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
>  				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
>  				<&cluster0_opp_tb7>;
> +			#cooling-cells =3D <2>;
>  		};
> =20
>  		a53_0: cpu@100 {
> @@ -2821,12 +2825,24 @@
>  				thermal-sensors =3D <&tsc 0>;
> =20
>  				trips {
> +					sensor1_passive: sensor1-passive {
> +						temperature =3D <95000>;
> +						hysteresis =3D <2000>;
> +						type =3D "passive";
> +					};
>  					sensor1_crit: sensor1-crit {
>  						temperature =3D <120000>;
>  						hysteresis =3D <2000>;
>  						type =3D "critical";
>  					};
>  				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip =3D <&sensor1_passive>;
> +						cooling-device =3D <&a57_0 4 4>;
> +					};
> +				};
>  			};
> =20
>  			sensor_thermal2: sensor-thermal2 {
> @@ -2835,12 +2851,24 @@
>  				thermal-sensors =3D <&tsc 1>;
> =20
>  				trips {
> +					sensor2_passive: sensor2-passive {
> +						temperature =3D <95000>;
> +						hysteresis =3D <2000>;
> +						type =3D "passive";
> +					};
>  					sensor2_crit: sensor2-crit {
>  						temperature =3D <120000>;
>  						hysteresis =3D <2000>;
>  						type =3D "critical";
>  					};
>  				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip =3D <&sensor2_passive>;
> +						cooling-device =3D <&a57_0 4 4>;
> +					};
> +				};
>  			};
> =20
>  			sensor_thermal3: sensor-thermal3 {
> @@ -2849,12 +2877,24 @@
>  				thermal-sensors =3D <&tsc 2>;
> =20
>  				trips {
> +					sensor3_passive: sensor3-passive {
> +						temperature =3D <95000>;
> +						hysteresis =3D <2000>;
> +						type =3D "passive";
> +					};
>  					sensor3_crit: sensor3-crit {
>  						temperature =3D <120000>;
>  						hysteresis =3D <2000>;
>  						type =3D "critical";
>  					};
>  				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip =3D <&sensor3_passive>;
> +						cooling-device =3D <&a57_0 4 4>;
> +					};
> +				};
>  			};
>  		};
>  	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
