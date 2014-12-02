From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency
 for samsung
Date: Tue, 02 Dec 2014 15:17:31 +0100
Message-ID: <2381774.pu2QYzQvZt@amdc1032>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35550 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaLBORi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 09:17:38 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NFY007E9L1BKR70@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 02 Dec 2014 23:17:35 +0900 (KST)
In-reply-to: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com


Hi,

On Tuesday, December 02, 2014 12:04:32 PM Abhilash Kesavan wrote:
> As samsung thermal support is enabled only for ARCH_EXYNOS, there is no
> need to select ARCH_HAS_BANDGAP from the arch-specific code. Removing this
> dependency will also allow the driver to be enabled on 64-bit SoCs.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
> This was based on the discussion regarding adding ARCH_HAS_BANDGAP symbol for
> arm64 here: http://www.spinics.net/lists/arm-kernel/msg377560.html

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  drivers/thermal/samsung/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
> index f760389..c43306e 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -1,6 +1,6 @@
>  config EXYNOS_THERMAL
>  	tristate "Exynos thermal management unit driver"
> -	depends on ARCH_HAS_BANDGAP && OF
> +	depends on OF
>  	help
>  	  If you say yes here you get support for the TMU (Thermal Management
>  	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises

