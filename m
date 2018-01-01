From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [2/2] arm64: dts: r8a7796: add thermal cooling management
Date: Mon, 1 Jan 2018 10:11:05 -0800
Message-ID: <20180101181102.GA3487@localhost.localdomain>
References: <20170913105909.13230-3-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913105909.13230-3-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 13, 2017 at 12:59:09PM +0200, Niklas S=F6derlund wrote:
> Add nodes and properties for thermal cooling management support.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 38 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/d=
ts/renesas/r8a7796.dtsi
> index 2905a3b953aab145..0b805dc30925e9be 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
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
>  		a53_0: cpu@100 {
> @@ -2116,12 +2118,24 @@
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
> +						cooling-device =3D <&a57_0 5 5>;
> +					};
> +				};
>  			};
> =20
>  			sensor_thermal2: sensor-thermal2 {
> @@ -2130,12 +2144,24 @@
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
> +						cooling-device =3D <&a57_0 5 5>;
> +					};
> +				};
>  			};
> =20
>  			sensor_thermal3: sensor-thermal3 {
> @@ -2144,12 +2170,24 @@
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
> +						cooling-device =3D <&a57_0 5 5>;
> +					};
> +				};
>  			};
>  		};
> =20
