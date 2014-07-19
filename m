From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v7 4/6] ARM: dts: Exynos: add cpu nodes, opp and cpu clock
 configuration data
Date: Sat, 19 Jul 2014 15:18:00 +0200
Message-ID: <53CA7008.7000106@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com> <1405345118-4269-5-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405345118-4269-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

Please see my comments inline.

On 14.07.2014 15:38, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos 4210/5250/5420 based platforms, add CPU nodes, operating points and
> cpu clock data for migrating from Exynos specific cpufreq driver to using
> generic cpufreq drivers.

[snip]

> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index ee3001f..c3a73bf 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -31,6 +31,33 @@
>  		pinctrl2 = &pinctrl_2;
>  	};
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {

nit: Missing blank line after last property.

The cluster ID field of MPIDR on Exynos4210 is 0x9 not zero, which means
that this should be cpu@900.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;

			reg = <0x900>;

> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +
> +			operating-points = <
> +				1200000 1250000
> +				1000000 1150000
> +				800000	1075000
> +				500000	975000
> +				400000	975000
> +				200000	950000
> +			>;
> +		};
> +
> +		cpu@1 {

		cpu@901

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;

			reg = <0x901>;

> +		};

In general this wouldn't have even booted, because there were several
places where code relied on CPUs being 0, 1, 2... However I have sent
necessary fixes and they should hit linux-next in few days.

> +	};
> +
>  	sysram@02020000 {
>  		compatible = "mmio-sram";
>  		reg = <0x02020000 0x20000>;

[snip]

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 834fb5a..66b0f98 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -63,6 +63,29 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1700000000>;
> +
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +
> +			operating-points = <
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
> +			clock-latency = <200000>;

I don't see this property specified for Exynos4210. Have you missed it
there?

Best regards,
Tomasz
