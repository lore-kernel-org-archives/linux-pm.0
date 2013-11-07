From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3 v8] thermal: samsung: add intclr_fall_shift bit in
 exynos_tmu_register struct
Date: Thu, 07 Nov 2013 15:47:45 +0100
Message-ID: <1458475.5nSWLtVcXi@amdc1227>
References: <1381979473-7079-1-git-send-email-ch.naveen@samsung.com>
 <1383803562-31752-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1383803562-31752-1-git-send-email-ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, eduardo.valentin-l0cyMroinI0@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Naveen,

On Thursday 07 of November 2013 11:22:42 Naveen Krishna Chatradhi wrote:
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
> This patch introduces a new bit field intclr_fall_shift to handle the
> offset for exyns5250 and exynos5440
> Also removes the unused macros EXYNOS_TMU_FALL_INT_SHIFT and
> EXYNOS5440_TMU_FALL_INT_SHIFT, inten_fall_shift field

>From what I can see in this patch, the field intclr_fall_shift is not
really introduced, but rather inten_fall_shift is renamed to it. Please
match patch description with what the patch actually does.

I believe this patch is also touches code and data related to Exynos 4x12
SoCs, but the description only covers Exynos 5 SoCs.

In addition, if this patch does not introduce any functional changes,
but only refactors some code, the description should say so.

Also, please see my comment below.

> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since v1:
> Changes since v2:
> Changes since v3:
>   None
> Changes since v4:
>  Correct the CLEAR_FALL_INT_SHIFT for Exynos5250/Exynos5440
> Changes since v5:
>  Modify the commit message
> Changes since v6:
>  - Use EXYNOS_TMU_CLEAR_FALL_INT_SHIFT instead of EXYNOS5250_TMU_CLEAR_FALL_INT_SHIFT
>  as the same is being used for Exynos4412
> Changes since v7:
>  - also removes the unused macros EXYNOS_TMU_FALL_INT_SHIFT and
>  EXYNOS5440_TMU_FALL_INT_SHIFT, inten_fall_shift field
> 
>  
>  drivers/thermal/samsung/exynos_tmu.c      |    2 +-
>  drivers/thermal/samsung/exynos_tmu.h      |    4 ++--
>  drivers/thermal/samsung/exynos_tmu_data.c |    4 ++--
>  drivers/thermal/samsung/exynos_tmu_data.h |    4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 32f38b9..b2202fa 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -265,7 +265,7 @@ skip_calib_data:
>  				data->base + reg->threshold_th1);
>  
>  		writel((reg->inten_rise_mask << reg->inten_rise_shift) |
> -			(reg->inten_fall_mask << reg->inten_fall_shift),
> +			(reg->inten_fall_mask << reg->intclr_fall_shift),

Shouldn't also the mask values be called intclr_*_mask? They seem to
be used only with tmu_intclear register. Same goes for inten_fall_shift,

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
