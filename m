From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/3 v8] thermal: samsung: add intclr_fall_shift bit in
 exynos_tmu_register struct
Date: Thu, 07 Nov 2013 11:48:42 +0100
Message-ID: <1864683.tCrpAXuim8@amdc1032>
References: <1381979473-7079-1-git-send-email-ch.naveen@samsung.com>
 <1383803562-31752-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1383803562-31752-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org


Hi,

On Thursday, November 07, 2013 11:22:42 AM Naveen Krishna Chatradhi wrote:
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

Thanks for fixing this.  All three patches look good to me now.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
