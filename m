From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 3/4 v9] thermal: samsung: Add TMU support for Exynos5420
 SoCs
Date: Mon, 09 Dec 2013 13:43:18 +0100
Message-ID: <1424435.eCnbAs4DIp@amdc1227>
References: <1378268629-2886-3-git-send-email-ch.naveen@samsung.com>
 <1384238225-24632-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:17051 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060Ab3LIMnb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2013 07:43:31 -0500
In-reply-to: <1384238225-24632-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com

Hi Naveen, Andrew,

Please see my comments inline.

On Tuesday 12 of November 2013 12:07:05 Naveen Krishna Chatradhi wrote:
> Exynos5420 has 5 TMU channels, the TRIMINFO register is
> misplaced for TMU channels 2, 3 and 4
> TRIMINFO at 0x1006c000 contains data for TMU channel 3
> TRIMINFO at 0x100a0000 contains data for TMU channel 4
> TRIMINFO at 0x10068000 contains data for TMU channel 2
> 
> This patch
> 1 Adds the neccessary register changes and arch information
>    to support Exynos5420 SoCs.
> 2. Handles the gate clock for misplaced TRIMINFO register
> 3. Updates the Documentation at
>    Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes since v8:
> 1. rewrote the Documentation for device tree bindings
> 2. Merged the https://lkml.org/lkml/2013/11/7/262 (as this is a fix)
> 3. introduces "samsung,exynos5420-tmu-triminfo" and 
>    "samsung,exynos5420-tmu-triminfo-clk" to handle the TMU channels on
>    Exynos5420 more appropriately
> 
>  .../devicetree/bindings/thermal/exynos-thermal.txt |   45 +++++++++
>  drivers/thermal/samsung/exynos_tmu.c               |   58 ++++++++++-
>  drivers/thermal/samsung/exynos_tmu.h               |    2 +
>  drivers/thermal/samsung/exynos_tmu_data.c          |  106 ++++++++++++++++++++
>  drivers/thermal/samsung/exynos_tmu_data.h          |    8 ++
>  5 files changed, 215 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index 116cca0..5055b31 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -6,6 +6,11 @@
>  	       "samsung,exynos4412-tmu"
>  	       "samsung,exynos4210-tmu"
>  	       "samsung,exynos5250-tmu"
> +	       "samsung,exynos5420-tmu" for TMU channel 0, 1 on Exynos5420
> +	       "samsung,exynos5420-tmu-triminfo" for TMU channel 2 Exynos5420
> +			(Must pass triminfo base)
> +	       "samsung,exynos5420-tmu-triminfo-clk" for TMU channel 3 and 4
> +			Exynos5420 (Must pass triminfo base and triminfo clock)

I don't think you need those two separate compatible values. Instead you
can keep only the one that requires clock and specify the same base clock
as triminfo clock. Also IMHO "samsung,exynos5420-tmu-ext-triminfo" would
be a better name, as it describes the hardware better (TMU with external
triminfo block, as opposed to normal TMU that has it internally).

Otherwise the patch looks fine.

Best regards,
Tomasz

