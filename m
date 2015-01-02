From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 06/17] thermal: cpu_cooling: dts: Define device tree
 bindings for Exynos cpu cooling functionality
Date: Fri, 2 Jan 2015 14:15:31 -0400
Message-ID: <20150102181529.GC12130@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-7-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:56237 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbbABSRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 13:17:46 -0500
Content-Disposition: inline
In-Reply-To: <1418213396-743-7-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 01:09:45PM +0100, Lukasz Majewski wrote:
> Presented patch aims to move data necessary for correct CPU cooling device
> configuration from exynos_tmu_data.c to device tree.

I believe the patch title is misleading. Looks like you are changing
something at cpu cooling, but in fact, you are changing DTS files. I
would suggest you to use a prefix like 'arm: dts: ....'

>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> ---
>  arch/arm/boot/dts/exynos4210-trats.dts          | 15 ++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi               | 20 ++++++++++++++++
>  arch/arm/boot/dts/exynos4212.dtsi               | 20 ++++++++++++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 15 ++++++++++++
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 15 ++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi               | 32 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/exynos5250.dtsi               | 20 +++++++++++++++-
>  7 files changed, 136 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/e=
xynos4210-trats.dts
> index b59019c..d9dd9a7 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -428,6 +428,21 @@
>  		status =3D "okay";
>  	};
> =20
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				    /* Corresponds to 800MHz at freq_table */
> +				    cooling-device =3D <&cpu0 2 2>;
> +				};
> +				map1 {
> +				   /* Corresponds to 200MHz at freq_table */
> +				   cooling-device =3D <&cpu0 4 4>;
> +			       };
> +		       };
> +		};
> +	};
> +
>  	camera {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos=
4210.dtsi
> index 807bb5b..10e8915 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -41,6 +41,26 @@
>  		#clock-cells =3D <1>;
>  	};
> =20
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0x900>;
> +			cooling-min-level =3D <4>;
> +			cooling-max-level =3D <2>;
> +			#cooling-cells =3D <2>; /* min followed by max */
> +		};
> +
> +		cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0x901>;
> +		};
> +	};
> +
>  	sysram@02020000 {
>  		compatible =3D "mmio-sram";
>  		reg =3D <0x02020000 0x20000>;
> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos=
4212.dtsi
> index 3c00e6e..6405954 100644
> --- a/arch/arm/boot/dts/exynos4212.dtsi
> +++ b/arch/arm/boot/dts/exynos4212.dtsi
> @@ -22,6 +22,26 @@
>  / {
>  	compatible =3D "samsung,exynos4212", "samsung,exynos4";
> =20
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA00>;
> +			cooling-min-level =3D <13>;
> +			cooling-max-level =3D <7>;
> +			#cooling-cells =3D <2>; /* min followed by max */
> +		};
> +
> +		cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA01>;
> +		};
> +	};
> +
>  	combiner: interrupt-controller@10440000 {
>  		samsung,combiner-nr =3D <18>;
>  	};
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/b=
oot/dts/exynos4412-odroid-common.dtsi
> index eb1c08c..15d45f0 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -375,6 +375,21 @@
>  		vtmu-supply =3D <&ldo10_reg>;
>  		status =3D "okay";
>  	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				    /* Corresponds to 800MHz at freq_table */
> +				    cooling-device =3D <&cpu0 7 7>;
> +				};
> +				map1 {
> +				   /* Corresponds to 200MHz at freq_table */
> +				   cooling-device =3D <&cpu0 13 13>;
> +			       };
> +		       };
> +		};
> +	};
>  };
> =20
>  &pinctrl_1 {
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/=
exynos4412-trats2.dts
> index 121430d..396c525 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -786,4 +786,19 @@
>  		pulldown-ohm =3D <100000>; /* 100K */
>  		io-channels =3D <&adc 2>;  /* Battery temperature */
>  	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				    /* Corresponds to 800MHz at freq_table */
> +				    cooling-device =3D <&cpu0 7 7>;
> +				};
> +				map1 {
> +				   /* Corresponds to 200MHz at freq_table */
> +				   cooling-device =3D <&cpu0 13 13>;
> +			       };
> +		       };
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index d8bc059e..9ed8925 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -22,6 +22,38 @@
>  / {
>  	compatible =3D "samsung,exynos4412", "samsung,exynos4";
> =20
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA00>;
> +			cooling-min-level =3D <13>;
> +			cooling-max-level =3D <7>;
> +			#cooling-cells =3D <2>; /* min followed by max */
> +		};
> +
> +		cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA01>;
> +		};
> +
> +		cpu@2 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA02>;
> +		};
> +
> +		cpu@3 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a9";
> +			reg =3D <0xA03>;
> +		};
> +	};
> +
>  	combiner: interrupt-controller@10440000 {
>  		samsung,combiner-nr =3D <20>;
>  	};
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos=
5250.dtsi
> index d55c1a2..a5bbc1a 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -58,11 +58,14 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0>;
>  			clock-frequency =3D <1700000000>;
> +			cooling-min-level =3D <15>;
> +			cooling-max-level =3D <9>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
>  		cpu@1 {
>  			device_type =3D "cpu";
> @@ -241,6 +244,21 @@
>  		clock-names =3D "tmu_apbif";
>  	};
> =20
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				    /* Corresponds to 800MHz at freq_table */
> +				    cooling-device =3D <&cpu0 9 9>;
> +				};
> +				map1 {
> +				   /* Corresponds to 200MHz at freq_table */
> +				   cooling-device =3D <&cpu0 15 15>;
> +			       };
> +		       };
> +		};
> +	};
> +
>  	serial@12C00000 {
>  		clocks =3D <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
>  		clock-names =3D "uart", "clk_uart_baud0";
> --=20
> 2.0.0.rc2
>=20

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpuA4AAoJEMLUO4d9pOJWlogH/Av921K+26+VtKySMlmXcPjV
FTG38p01LGm+dzJLU2Cv9W0BUwtNnHsLt949GjVdeohNp/anFTH7E0ROFheuaIDO
08y9tQAqPEPINRxiuIeHniyDWIEz9jwtvgxQjNxH4vFp1FbL8rBQ9AfPHD8BTQMk
dxoG6ugNE6F1gk/jaHGqyervN5zVsY4+PnofoZEqH9JlZLjf/6D2E1uHw4XsUbb8
rC3qHIFpPDw8y7cHHapTGOFJ2vKvZ5Ocmk7ziRgFF2XG2EvMgaqi/GuwBvAheiNY
VCmoye/KswFFusVsqhREGTaN5E4Ut27uyHVu5JC9VIwZVazHoOn+uH0G8nrqn1w=
=UWAz
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
