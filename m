From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 4/8] ARM: dts: Exynos5420: add CPU OPP and regulator supply
 property
Date: Wed, 22 Apr 2015 10:12:08 +0200
Message-ID: <20150422101208.7f03ff3b@amdc2363>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
 <1429622278-12216-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429622278-12216-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Anderson <dianders@chromium.org>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Bartlomiej,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos5420 platforms, add CPU operating points and CPU
> regulator supply properties for migrating from Exynos specific
> cpufreq driver to using generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   38
> +++++++++++++++++++++++++++++++++++++ 1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index f67b23f..85b9cfc 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -59,8 +59,26 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0x0>;
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu-cluster.0";
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +			clock-latency = <140000>;
> +
> +			operating-points = <
> +				1800000 1250000
> +				1700000 1212500
> +				1600000 1175000
> +				1500000 1137500
> +				1400000 1112500
> +				1300000 1062500
> +				1200000 1037500
> +				1100000 1012500
> +				1000000 987500
> +				 900000 962500
> +				 800000 937500
> +				 700000 912500
> +			>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -69,6 +87,7 @@
>  			reg = <0x1>;
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +			clock-latency = <140000>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -77,6 +96,7 @@
>  			reg = <0x2>;
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +			clock-latency = <140000>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -85,14 +105,29 @@
>  			reg = <0x3>;
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
> +			clock-latency = <140000>;
>  		};
>  
>  		cpu4: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x100>;
> +			clocks = <&clock CLK_KFC_CLK>;
> +			clock-names = "cpu-cluster.1";
>  			clock-frequency = <1000000000>;
>  			cci-control-port = <&cci_control0>;
> +			clock-latency = <140000>;
> +
> +			operating-points = <
> +				1300000 1275000
> +				1200000 1212500
> +				1100000 1162500
> +				1000000 1112500
> +				 900000 1062500
> +				 800000 1025000
> +				 700000 975000
> +				 600000 937500
> +			>;
>  		};
>  
>  		cpu5: cpu@101 {
> @@ -101,6 +136,7 @@
>  			reg = <0x101>;
>  			clock-frequency = <1000000000>;
>  			cci-control-port = <&cci_control0>;
> +			clock-latency = <140000>;
>  		};
>  
>  		cpu6: cpu@102 {
> @@ -109,6 +145,7 @@
>  			reg = <0x102>;
>  			clock-frequency = <1000000000>;
>  			cci-control-port = <&cci_control0>;
> +			clock-latency = <140000>;
>  		};
>  
>  		cpu7: cpu@103 {
> @@ -117,6 +154,7 @@
>  			reg = <0x103>;
>  			clock-frequency = <1000000000>;
>  			cci-control-port = <&cci_control0>;
> +			clock-latency = <140000>;
>  		};
>  	};
>  

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
