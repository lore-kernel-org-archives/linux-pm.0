From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: thermal: exynos4: TMU device tree support
 for Exynos4412 targets
Date: Thu, 25 Apr 2013 11:45:24 -0400
Message-ID: <51794F94.4030107@ti.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com> <1366893045-31586-1-git-send-email-l.majewski@samsung.com> <1366893045-31586-2-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40559 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557Ab3DYPpl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 11:45:41 -0400
In-Reply-To: <1366893045-31586-2-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, eduardo.valentin@ti.com

On 25-04-2013 08:30, Lukasz Majewski wrote:
> Device tree support for TMU at Exynos4x12 targets.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This patch looks good to me:
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> Changes for v2:
> - None
> ---
>   arch/arm/boot/dts/exynos4x12.dtsi |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index e3380a7..ee920b3 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -79,4 +79,14 @@
>   		interrupts = <0 89 0>;
>   		status = "disabled";
>   	};
> +
> +	tmu@100C0000 {
> +		compatible = "samsung,exynos4412-tmu";
> +		interrupt-parent = <&combiner>;
> +		reg = <0x100C0000 0x100>;
> +		interrupts = <2 4>;
> +		clocks = <&clock 383>;
> +		clock-names = "tmu_apbif";
> +		status = "disabled";
> +	};
>   };
>

