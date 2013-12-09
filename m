From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 4/4 v3] ARM: dts: Exynos5420: Add device nodes for TMU
 blocks
Date: Mon, 09 Dec 2013 13:57:09 +0100
Message-ID: <3503788.1T16Njt87z@amdc1227>
References: <1382004240-3282-1-git-send-email-l.krishna@samsung.com>
 <1384238268-24671-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:18108 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933192Ab3LIM5W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2013 07:57:22 -0500
In-reply-to: <1384238268-24671-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com

Hi Naveen,

On Tuesday 12 of November 2013 12:07:48 Naveen Krishna Chatradhi wrote:
> Exynos5420 SoC has per core thermal management unit.
> 5 TMU channels 4 for CPUs and 5th for GPU.
> 
> This patch adds the device tree nodes to the DT device list.
> 
> Nodes carry the misplaced second base address and the second
> clock to access the misplaced base address.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes since v2:
> 3. uses the new compatible strings introduced along with adding
>    support for Exynso5420.
> 
> Changes since v1:
> 1. Nodes carry the misplaced second base address and the second
>    clock to access the misplaced base address.
> 2. Correct the clock number for the TMU4
> 
>  arch/arm/boot/dts/exynos5420.dtsi |   48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

In addition to updating to reflect my comments to patch 3/4, please also
see my comments inline.

> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 6ffefd1..d736b40 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -369,4 +369,52 @@
>  		clock-names = "gscl";
>  		samsung,power-domain = <&gsc_pd>;
>  	};
> +
> +	/* tmu for CPU0 */
> +	tmu@10060000 {

Instead of the comment, it might be better to add a label to the node,
such as

tmu_cpu0: tmu@10060000 {

for TMU of CPU0 and so on.

> +		compatible = "samsung,exynos5420-tmu";
> +		reg = <0x10060000 0x100>;
> +		interrupts = <0 65 0>;
> +		clocks = <&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	/* tmu for CPU1 */
> +	tmu@10064000 {
> +		compatible = "samsung,exynos5420-tmu";
> +		reg = <0x10064000 0x100>;
> +		interrupts = <0 183 0>;
> +		clocks = <&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	/* tmu for CPU2 */
> +	tmu@10068000 {
> +		compatible = "samsung,exynos5420-tmu-triminfo";
> +		/* 2nd reg is for the misplaced TRIMINFO register */

Hmm, I'm not convinced about usefulness of this comment. Used compatible
value directly implies the meaning of all reg entries.

Best regards,
Tomasz

