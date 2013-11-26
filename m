From: Amit Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH] thermal: offer Samsung thermal support only when
 ARCH_EXYNOS is defined
Date: Tue, 26 Nov 2013 11:37:28 +0530
Message-ID: <CADGdYn4YQL9-8WCDNWP8x9Gec9sMV09q3OsYPz3tTdMxDGnyvg@mail.gmail.com>
References: <2958660.aJeCDrTTOe@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45989 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3KZGHa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 01:07:30 -0500
In-Reply-To: <2958660.aJeCDrTTOe@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

On 10/4/13, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> Menu for Samsung thermal support is visible on all Samsung
> platforms while thermal drivers are currently available only
> for EXYNOS SoCs. Fix it by replacing PLAT_SAMSUNG dependency
> with ARCH_EXYNOS one.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Looks good, so
Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a709c63..05cf95c 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -198,7 +198,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
>  endmenu
>
>  menu "Samsung thermal drivers"
> -depends on PLAT_SAMSUNG
> +depends on ARCH_EXYNOS
>  source "drivers/thermal/samsung/Kconfig"
>  endmenu
>
> --
> 1.8.2.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
