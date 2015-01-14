From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 06/16] arm: dts: Adding CPU cooling binding for Exynos
 SoCs
Date: Wed, 14 Jan 2015 14:57:28 -0400
Message-ID: <20150114185726.GF3672@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-7-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:54758 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbANS5k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 13:57:40 -0500
Content-Disposition: inline
In-Reply-To: <1421242874-3425-7-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 02:41:04PM +0100, Lukasz Majewski wrote:
> Presented patch aims to move data necessary for correct CPU cooling device
> configuration from exynos_tmu_data.c to device tree.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> Changes for v3:
> - Adjust CPU's DT nodes to work with newest ti-soc-thermal/next branch
> - Patch title has been changed from "thermal: cpu_cooling: dts: ..."
> ---
>  arch/arm/boot/dts/exynos4210-trats.dts          | 15 +++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi               |  5 ++++-
>  arch/arm/boot/dts/exynos4212.dtsi               |  5 ++++-
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 15 +++++++++++++++
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 15 +++++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi               |  5 ++++-
>  arch/arm/boot/dts/exynos5250.dtsi               | 20 +++++++++++++++++++-
>  7 files changed, 76 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/e=
xynos4210-trats.dts
> index 61009f4..4cd8926 100644
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

The cpu_thermal zone above is incomplete. It is missing the following
mandatory properties (according to
Documentation/devicetree/bindings/thermal/thermal.txt):
- polling-delay:=20
- polling-delay-passive:
- thermal-sensors:
- trips:=20

> +	};
> +
>  	camera {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos=
4210.dtsi
> index bcc9e63..2e66df8 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -35,10 +35,13 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@900 {
> +		cpu0: cpu@900 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a9";
>  			reg =3D <0x900>;
> +			cooling-min-level =3D <4>;
> +			cooling-max-level =3D <2>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
> =20
>  		cpu@901 {
> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos=
4212.dtsi
> index dd0a43e..5be03288 100644
> --- a/arch/arm/boot/dts/exynos4212.dtsi
> +++ b/arch/arm/boot/dts/exynos4212.dtsi
> @@ -26,10 +26,13 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@A00 {
> +		cpu0: cpu@A00 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a9";
>  			reg =3D <0xA00>;
> +			cooling-min-level =3D <13>;
> +			cooling-max-level =3D <7>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
> =20
>  		cpu@A01 {
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/b=
oot/dts/exynos4412-odroid-common.dtsi
> index c7517fc..4838a2a 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -401,6 +401,21 @@
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
> index 29231b4..8c2c584 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -863,6 +863,21 @@
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
> =20
>  &pinctrl_0 {
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index 0f6ec93..68ad43b 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -26,10 +26,13 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@A00 {
> +		cpu0: cpu@A00 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a9";
>  			reg =3D <0xA00>;
> +			cooling-min-level =3D <13>;
> +			cooling-max-level =3D <7>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
> =20
>  		cpu@A01 {
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos=
5250.dtsi
> index 0a229fc..dd5c3a0 100644
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

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUtrwMAAoJEMLUO4d9pOJW3AcH/A7q76cWzYqW9sth3gDoE7BT
GVNNqQu58ozhd4mY5JTbI5b9qM8XkgufxGQoibxx4zmEIM47MPzP9pNKlWBwlb6c
TCjjF1ZZaRxKRNXWhZcPiyJnHEhYee7vB2wpOLIqW/eQwTLqeHne8kX3qH660pf+
VDN8+JGBFJDVt9/QqgnSQ2r8FRnXJluXGnFlWXOKQDRJt3XB4aB3vabeHYc2T42b
DzSH9URK6l14/hgMJsC6EgeO/GwjyF8q5e0aWLeub+DzccEwD5c1u0n3s2kED5hz
PPiJ/PysAGSWOkMCgFMFJB01YpKDP/3q1XbJl5AONK+MY7TviTLo/Zu2G9M3FKw=
=Fu6R
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
