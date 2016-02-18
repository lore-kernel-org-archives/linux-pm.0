From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
Date: Thu, 18 Feb 2016 17:58:09 +0000
Message-ID: <87h9h599zi.fsf@e105922-lin.cambridge.arm.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
	(Krzysztof Kozlowski's message of "Thu, 18 Feb 2016 14:13:01 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
> 12 steps for big core (700-1800 MHz). Add respective cooling cells.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> ---
>
> Changes since v1:
> 1. Add cooling properties to all CPUs (suggested by Viresh).
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> index 261d25173f61..5c052d7ff554 100644
> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> @@ -33,6 +33,9 @@
>  			clock-frequency = <1800000000>;
>  			cci-control-port = <&cci_control1>;
>  			operating-points-v2 = <&cluster_a15_opp_table>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <11>;

Although the above two properties are defined they aren't parsed in the
kernel.

Setting min / max extents for cooling devices via cooling maps does work
though.


[...]
