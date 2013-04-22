From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 3/6] thermal:exynos4: TMU device tree support for
 Exynos4412 targets
Date: Mon, 22 Apr 2013 09:49:18 +0530
Message-ID: <CAK9yfHyD3KxO1J-Au8wxibjnUoLk+3MjSB_OvY2r44cHBiropg@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-4-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1366389493-8239-4-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Device tree support for TMU at Exynos4x12 targets.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

nit: Subject for these kind of patches should start with "ARM: dts: ..."

Otherwise looks good to me.
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index e3380a7..ee920b3 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -79,4 +79,14 @@
>                 interrupts = <0 89 0>;
>                 status = "disabled";
>         };
> +
> +       tmu@100C0000 {
> +               compatible = "samsung,exynos4412-tmu";
> +               interrupt-parent = <&combiner>;
> +               reg = <0x100C0000 0x100>;
> +               interrupts = <2 4>;
> +               clocks = <&clock 383>;
> +               clock-names = "tmu_apbif";
> +               status = "disabled";
> +       };
>  };
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With warm regards,
Sachin
