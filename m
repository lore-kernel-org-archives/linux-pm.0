From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v11 2/4] thermal: samsung: change base_common to more
 meaningful base_second
Date: Wed, 18 Dec 2013 16:51:37 +0100
Message-ID: <2079238.D0LMFQmTKa@amdc1227>
References: <1378268629-2886-2-git-send-email-ch.naveen@samsung.com>
 <1386657716-21572-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:18837 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab3LRPvz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 10:51:55 -0500
In-reply-to: <1386657716-21572-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com

On Tuesday 10 of December 2013 12:11:56 Naveen Krishna Chatradhi wrote:
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
> Changes since v10:
> Documentation rephrased as per comments from Tomasz Figa
> 
>  .../devicetree/bindings/thermal/exynos-thermal.txt       |    4 ++--
>  drivers/thermal/samsung/exynos_tmu.c                     |   14 +++++++-------
>  drivers/thermal/samsung/exynos_tmu.h                     |    4 ++--
>  drivers/thermal/samsung/exynos_tmu_data.c                |    2 +-
>  4 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

