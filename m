From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Tue, 29 Jul 2014 12:31:51 +0200
Message-ID: <53D77817.7030605@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com> <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

Other than the same question about 400 MHz OPP for Exynos4210, I have
also few more inline.

On 29.07.2014 07:28, Thomas Abraham wrote:
> For Exynos 4210/5250/5420 based platforms, add CPU operating points and CPU
> regulator supply properties for migrating from Exynos specific cpufreq driver
> to using generic cpufreq drivers.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         |    6 ++++
>  arch/arm/boot/dts/exynos4210-trats.dts          |    6 ++++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 ++++
>  arch/arm/boot/dts/exynos4210.dtsi               |   12 +++++++
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    6 ++++
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 ++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 ++++
>  arch/arm/boot/dts/exynos5250.dtsi               |   23 ++++++++++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 ++++

There are more Exynos5420-based boards supported in mainline. If you do
not have necessary data and/or hardware to fully enable the new driver
on them, you should add responsible people on Cc list, so at least they
know they have one more item on their TODO list. Added them for you.

>  arch/arm/boot/dts/exynos5420.dtsi               |   38 +++++++++++++++++++++++
>  10 files changed, 115 insertions(+)

[snip]

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 492e1ef..876247a 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -63,6 +63,29 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1700000000>;
> +
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			clock-latency = <200000>;

Where does this latency value comes from? How did you calculate it?

For example, on Exynos4210, for all operating points added by your
patches, the highest PLL locking latency will be 60uS, because the
highest PDIV value would be 6 and PLL lock time is PDIV*240 ticks of 24
MHz reference clock.

> +
> +			operating-points = <
> +				1700000 1300000
> +				1600000 1250000

[snip]

> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 6052aa9..084e587 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -24,6 +24,12 @@
>  		bootargs = "console=ttySAC2,115200 init=/linuxrc";
>  	};
>  
> +	cpus {

Is there no regulator for cpu0?

> +		cpu@4 {
> +			cpu0-supply = <&buck6_reg>;
> +		};
> +	};
> +
>  	fixed-rate-clocks {
>  		oscclk {
>  			compatible = "samsung,exynos5420-oscclk";
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index cb2b70e..1116d55 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi

[snip]

>  
>  		cpu1: cpu@1 {
> @@ -69,6 +87,7 @@
>  			reg = <0x1>;
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +			clock-latency = <200000>;

Do you need to specify this property for every CPU or rather just for
those which have operating points specified?

Best regards,
Tomasz
