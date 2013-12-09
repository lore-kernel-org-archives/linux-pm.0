From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 3/4 v10] thermal: samsung: Add TMU support for Exynos5420
 SoCs
Date: Mon, 09 Dec 2013 13:46:13 +0100
Message-ID: <1731208.TRZ1kkpdkM@amdc1227>
References: <1378268629-2886-3-git-send-email-ch.naveen@samsung.com>
 <1384866325-16110-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:17220 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944Ab3LIMqZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2013 07:46:25 -0500
In-reply-to: <1384866325-16110-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com

Hi Naveen,

On Tuesday 19 of November 2013 18:35:25 Naveen Krishna Chatradhi wrote:
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
> Changes since v9:
> Just respinning
> 
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

I have replied to previous version by mistake, but since this is just
a respin, same comments apply.

Best regards,
Tomasz

