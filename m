From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: Exynos5250: add CPU OPP and regulator
 supply property
Date: Thu, 16 Jul 2015 10:34:54 +0900
Message-ID: <55A70A3E.5020600@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1435756238-845-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

On 01.07.2015 22:10, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos5250 platforms, add CPU operating points and CPU
> regulator supply properties for migrating from Exynos specific
> cpufreq driver to using generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
> - added CPU regulator supply property for Google Spring board
> - put the new cpu nodes in alphabetical order
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Andreas Faerber <afaerber@suse.de>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  |  4 ++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |  4 ++++
>  arch/arm/boot/dts/exynos5250-snow.dts     |  4 ++++
>  arch/arm/boot/dts/exynos5250-spring.dts   |  4 ++++
>  arch/arm/boot/dts/exynos5250.dtsi         | 22 ++++++++++++++++++++++
>  5 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 7e728a1..db3f65f 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -117,6 +117,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &dp {
>  	status = "okay";
>  	samsung,color-space = <0>;
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 4fe186d..15aea76 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -74,6 +74,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &dp {
>  	samsung,color-space = <0>;
>  	samsung,dynamic-range = <0>;
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index b7f4122..a4133df 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -235,6 +235,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &dp {
>  	status = "okay";
>  	pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index d03f9b8..c1edd6d 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -65,6 +65,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &dp {
>  	status = "okay";
>  	pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index bf9bee6..0c7ef12 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -63,6 +63,28 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1700000000>;
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			clock-latency = <140000>;
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
>  			cooling-min-level = <15>;
>  			cooling-max-level = <9>;
>  			#cooling-cells = <2>; /* min followed by max */
> 


I see you have all necessary acks so this can go through samsung-soc. I
started applying everything. Patch 4/4 does not apply cleanly but this
was easy to solve (I think it is better to rebase on Linus tree not on
next in such case; subsystems cannot apply easily something depending on
next).

Unfortunately this patch (2/4) has build errors:

  DTC     arch/arm/boot/dts/exynos5250-arndale.dtb
Error: ../arch/arm/boot/dts/exynos5250.dtsi:65.21-22 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [arch/arm/boot/dts/exynos5250-arndale.dtb] Error 1
make[1]: *** [dtbs] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory `/home/kozik/dev/linux/krzk/out'
make: *** [sub-make] Error 2
Fail: Make error

I tried to apply this patch on my dt-for-next branch:
https://github.com/krzk/linux/commits/dt-for-next

I hold back other patches until this is clarified.

Best regards,
Krzysztof
