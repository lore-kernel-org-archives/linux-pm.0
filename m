From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 2/4 v10] thermal: samsung: change base_common to more
 meaningful base_second
Date: Mon, 09 Dec 2013 13:48:13 +0100
Message-ID: <2699941.H5LXh5yo1R@amdc1227>
References: <1378268629-2886-2-git-send-email-ch.naveen@samsung.com>
 <1384866291-16034-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1384866291-16034-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Naveen,

On Tuesday 19 of November 2013 18:34:51 Naveen Krishna Chatradhi wrote:
> On Exynos5440 and Exynos5420 there are registers common
> across the TMU channels.
> 
> To support that, we introduced a ADDRESS_MULTIPLE flag in the
> driver and the 2nd set of register base and size are provided
> in the "reg" property of the node.
> 
> As per Amit's suggestion, this patch changes the base_common
> to base_second and SHARED_MEMORY to ADDRESS_MULTIPLE.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Changes since v9:
> Just respinning
> 
> Changes since v8:
>  None
>  .../devicetree/bindings/thermal/exynos-thermal.txt       |    4 ++--
>  drivers/thermal/samsung/exynos_tmu.c                     |   14 +++++++-------
>  drivers/thermal/samsung/exynos_tmu.h                     |    4 ++--
>  drivers/thermal/samsung/exynos_tmu_data.c                |    2 +-
>  4 files changed, 12 insertions(+), 12 deletions(-)

Please see my comments inline.

> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index 284f530..116cca0 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -11,8 +11,8 @@
>  - reg : Address range of the thermal registers. For soc's which has multiple
>  	instances of TMU and some registers are shared across all TMU's like
>  	interrupt related then 2 set of register has to supplied. First set
> -	belongs	to each instance of TMU and second set belongs to common TMU
> -	registers.
> +	belongs	to each instance of TMU and second set belongs to second set
> +	of common TMU registers.

Just a wording issue, I think: If this is "second set of common TMU
registers", then where is the first set of common TMU registers?

Otherwise the patch looks fine.

Best regards,
Tomasz
