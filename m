From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/4 v10] thermal: samsung: replace inten_ bit fields with
 intclr_
Date: Mon, 09 Dec 2013 13:51:35 +0100
Message-ID: <4489646.QoKFUWLh9W@amdc1227>
References: <1384238168-24561-1-git-send-email-ch.naveen@samsung.com>
 <1384866259-15983-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1384866259-15983-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Naveen,

On Tuesday 19 of November 2013 18:34:19 Naveen Krishna Chatradhi wrote:
> This patch replaces the inten_rise_shift/mask and inten_fall_shift/mask
> with intclr_rise_shift/mask and intclr_fall_shift/mask respectively.
> Currently, inten_rise_shift/mask and inten_fall_shift/mask bits are only used
> to configure intclr related registers.
> 
> Description of H/W:
> The offset for the bits in the CLEAR register are not consistent across TMU
> modules in Exynso5250, 5420 and 5440.
> 
> On Exynos5250, the FALL interrupt related en, status and clear bits are
> available at an offset of
> 16 in INTEN, INTSTAT registers and at an offset of
> 12 in INTCLEAR register.
> 
> On Exynos5420, the FALL interrupt related en, status and clear bits are
> available at an offset of
> 16 in INTEN, INTSTAT and INTCLEAR registers.
> 
> On Exynos5440,
> the FALL_IRQEN bits are at an offset of 4
> and the RISE_IRQEN bits are at an offset of 0
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Changes since v9:
> Just respinning
> 
> Changes since v8:
> 1. Modified the patch description,
> 2. replaces the inten_rise/fall_shift/mask with intclr_rise/fall_shift/mask
> 
>  drivers/thermal/samsung/exynos_tmu.c      |    6 +++---
>  drivers/thermal/samsung/exynos_tmu.h      |   16 ++++++++--------
>  drivers/thermal/samsung/exynos_tmu_data.c |   18 +++++++++---------
>  drivers/thermal/samsung/exynos_tmu_data.h |    4 ++--
>  4 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
