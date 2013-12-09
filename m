From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 4/4 v4] ARM: dts: Exynos5420: Add device nodes for TMU
 blocks
Date: Tue, 10 Dec 2013 06:15:08 +0900
Message-ID: <52A632DC.6040509@samsung.com>
References: <1382004240-3282-1-git-send-email-l.krishna@samsung.com> <1384866359-16157-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1384866359-16157-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On 11/19/13 22:05, Naveen Krishna Chatradhi wrote:
> Exynos5420 SoC has per core thermal management unit.
> 5 TMU channels 4 for CPUs and 5th for GPU.
>
> This patch adds the device tree nodes to the DT device list.
>
> Nodes carry the misplaced second base address and the second
> clock to access the misplaced base address.
>
> Signed-off-by: Leela Krishna Amudala<l.krishna@samsung.com>
> Signed-off-by: Naveen Krishna Chatradhi<ch.naveen@samsung.com>
> Signed-off-by: Andrew Bresticker<abrestic@chromium.org>
> ---
> Changes since v3:
> None, Just respinning
>
> Changes since v2:
> 3. uses the new compatible strings introduced along with adding
>     support for Exynso5420.
>
> Changes since v1:
> 1. Nodes carry the misplaced second base address and the second
>     clock to access the misplaced base address.
> 2. Correct the clock number for the TMU4
>
>   arch/arm/boot/dts/exynos5420.dtsi |   48 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 6ffefd1..d736b40 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -369,4 +369,52 @@
>   		clock-names = "gscl";
>   		samsung,power-domain =<&gsc_pd>;
>   	};
> +
> +	/* tmu for CPU0 */
> +	tmu@10060000 {
> +		compatible = "samsung,exynos5420-tmu";
> +		reg =<0x10060000 0x100>;
> +		interrupts =<0 65 0>;
> +		clocks =<&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	/* tmu for CPU1 */
> +	tmu@10064000 {
> +		compatible = "samsung,exynos5420-tmu";
> +		reg =<0x10064000 0x100>;
> +		interrupts =<0 183 0>;
> +		clocks =<&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	/* tmu for CPU2 */
> +	tmu@10068000 {
> +		compatible = "samsung,exynos5420-tmu-triminfo";
> +		/* 2nd reg is for the misplaced TRIMINFO register */
> +		reg =<0x10068000 0x100>,<0x1006c000 0x4>;
> +		interrupts =<0 184 0>;
> +		clocks =<&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	/* tmu for CPU3 */
> +	tmu@1006c000 {
> +		compatible = "samsung,exynos5420-tmu-triminfo-clk";
> +		/* 2nd reg is for the misplaced TRIMINFO register */
> +		reg =<0x1006c000 0x100>,<0x100a0000 0x4>;
> +		interrupts =<0 185 0>;
> +		clocks =<&clock 318>,<&clock 319>;
> +		clock-names = "tmu_apbif", "tmu_apbif_triminfo";
> +	};
> +
> +	/* tmu for GPU */
> +	tmu@100a0000 {
> +		compatible = "samsung,exynos5420-tmu-triminfo-clk";
> +		/* 2nd reg is for the misplaced TRIMINFO register */
> +		reg =<0x100a0000 0x100>,<0x10068000 0x4>;
> +		interrupts =<0 215 0>;
> +		clocks =<&clock 319>,<&clock 318>;
> +		clock-names = "tmu_apbif", "tmu_apbif_triminfo";
> +	};
>   };

BTW, there is just only this patch to support TMU on exynos5420?

- Kukjin
