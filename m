From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
Date: Wed, 17 Feb 2016 12:31:05 +0530
Message-ID: <20160217070105.GK2454@vireshk-i7>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
 <1455692128-28504-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455692128-28504-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

On 17-02-16, 15:55, Krzysztof Kozlowski wrote:
> On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
> 12 steps for big core (700-1800 MHz). Add respective cooling cells.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> index 261d25173f61..498ae82e1cb2 100644
> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> @@ -33,6 +33,9 @@
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
>  			operating-points-v2 = <&cluster_a15_opp_table>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <11>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -70,6 +73,9 @@
>  			clock-frequency = <1000000000>;
>  			cci-control-port = <&cci_control0>;
>  			operating-points-v2 = <&cluster_a7_opp_table>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <7>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};

Though it wouldn't matter (for the issue you are getting), but this should be
added for all the CPUs in case some other CPU is booted first.

-- 
viresh
