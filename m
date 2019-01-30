From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 6/8] DT: arm: exynos: add DMC device for exynos5422
Date: Wed, 30 Jan 2019 10:46:40 +0100
Message-ID: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
References: <CGME20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0@eucas1p2.samsung.com>
 <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com> <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 29 Jan 2019 at 18:55, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 69 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 +++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..4d76335 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -235,6 +235,27 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>, <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>, <&clock CLK_CLKM_PHY1>;
> +                       clock-names = "fout_spll", "mout_sclk_spll",
> +                               "ff_dout_spll2", "fout_bpll", "mout_bpll",
> +                               "sclk_bpll", "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0", "clkm_phy0", "clkm_phy1";

We misunderstood each other. I did not ask for compaction into one
continued line but for proper indentation. Having one entry per one
line was fine because you have really a lot of entries and it was
making things easier to check.
It should look like:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos54xx.dtsi?h=v4.20#n78

Best regards,
Krzysztof
