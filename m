From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v12 3/4] thermal: samsung: Add TMU support for Exynos5420
 SoCs
Date: Thu, 19 Dec 2013 12:34:03 +0100
Message-ID: <3663519.7JfYNffMTG@amdc1227>
References: <1378268629-2886-3-git-send-email-ch.naveen@samsung.com>
 <1387433191-7861-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1387433191-7861-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

On Thursday 19 of December 2013 11:36:31 Naveen Krishna Chatradhi wrote:
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
> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Changes since v11:
> 1. Added description for clocks in the Documentation
> 2. corrected the clock name in clk_get() function as per description
> 
> Changes since v10:
> 1. using renamed compatible "samsung,exynos5420-tmu-ext-triminfo"
>    and passing same clock as triminfo_apbif clock for channel 2
> 2. removed the "exynos5420-tmu-triminfo-clk" compatible
>  .../devicetree/bindings/thermal/exynos-thermal.txt |   45 ++++++++-
>  drivers/thermal/samsung/exynos_tmu.c               |   52 +++++++++-
>  drivers/thermal/samsung/exynos_tmu.h               |    1 +
>  drivers/thermal/samsung/exynos_tmu_data.c          |   99 ++++++++++++++++++++
>  drivers/thermal/samsung/exynos_tmu_data.h          |    8 ++
>  5 files changed, 200 insertions(+), 5 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
