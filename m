From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] exynos: config: Enable thermal emulation for Exynos
 TMU (exynos_defconfig)
Date: Thu, 29 Jan 2015 18:58:27 -0400
Message-ID: <20150129225825.GG29837@developer.amazonguestwifi.org>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
 <1422458920-14555-2-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49586 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbA2W6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 17:58:32 -0500
Content-Disposition: inline
In-Reply-To: <1422458920-14555-2-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Wed, Jan 28, 2015 at 04:28:39PM +0100, Lukasz Majewski wrote:
> Enabling thermal emulation on Exynos SoCs. New sysfs attribute - emul_temp
> is created.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

I dont see problems with this patch:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 3691a68..376dbf4 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -88,6 +88,7 @@ CONFIG_HWMON=y
>  CONFIG_SENSORS_LM90=y
>  CONFIG_THERMAL=y
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_THERMAL_EMULATION=y
>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MFD_CROS_EC=y
> -- 
> 2.0.0.rc2
> 
