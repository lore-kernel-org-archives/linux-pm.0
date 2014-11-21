From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v12 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Fri, 21 Nov 2014 15:11:11 +0100
Message-ID: <546F47FF.2030608@suse.de>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com> <1416576682-5255-2-git-send-email-thomas.ab@samsung.com> <1416576682-5255-3-git-send-email-thomas.ab@samsung.com> <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Javier, Doug,

Am 21.11.2014 um 14:31 schrieb Thomas Abraham:
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot=
/dts/exynos5250-arndale.dts
> index 3acd97e..da2b3e1 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -563,3 +563,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boo=
t/dts/exynos5250-smdk5250.dts
> index 6a0f4c0..0eedb88 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -406,3 +406,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dt=
s/exynos5250-snow.dts
> index e51fcef..865f68a 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -345,6 +345,10 @@
>  	};
>  };
> =20
> +&cpu0 {
> +	cpu0-supply =3D <&buck2_reg>;
> +};
> +
>  &i2c_0 {
>  	status =3D "okay";
>  	samsung,i2c-sda-delay =3D <100>;

Not sure whether I've asked before... Do you know what needs to be
specified for exynos5250-spring.dts, which has in the meantime landed i=
n
kgene/for-next?

Regards,
Andreas

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/ex=
ynos5250.dtsi
> index f21b9aa..d4b418e 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -58,11 +58,34 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0>;
>  			clock-frequency =3D <1700000000>;
> +
> +			clocks =3D <&clock CLK_ARM_CLK>;
> +			clock-names =3D "cpu";
> +			clock-latency =3D <140000>;
> +
> +			operating-points =3D <
> +				1700000 1300000
> +				1600000 1250000
> +				1500000 1225000
> +				1400000 1200000
> +				1300000 1150000
> +				1200000 1125000
> +				1100000 1100000
> +				1000000 1075000
> +				 900000 1050000
> +				 800000 1025000
> +				 700000 1012500
> +				 600000 1000000
> +				 500000  975000
> +				 400000  950000
> +				 300000  937500
> +				 200000  925000
> +			>;
>  		};
>  		cpu@1 {
>  			device_type =3D "cpu";
[snip]

--=20
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 21284 AG N=FCrn=
berg
