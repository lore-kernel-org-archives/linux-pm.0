From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: Remove ARCH_HAS_BANDGAP selection
Date: Tue, 02 Dec 2014 15:23:10 +0100
Message-ID: <4437134.0jfvIRYXSu@amdc1032>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
 <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14617 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbaLBOXT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 09:23:19 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NFY00HR9LAUWR70@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 02 Dec 2014 23:23:18 +0900 (KST)
In-reply-to: <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com


Hi,

On Tuesday, December 02, 2014 12:04:33 PM Abhilash Kesavan wrote:
> On removing the samsung thermal driver dependency on ARCH_HAS_BANDGAP,
> selection of this symbol becomes redundant.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

This has also a nice side-effect of removing TI_SOC_THERMAL availability
from Exynos only kernel configurations.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index e4a00ba..6ddfce7 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -9,7 +9,6 @@
>  
>  menuconfig ARCH_EXYNOS
>  	bool "Samsung EXYNOS" if ARCH_MULTI_V7
> -	select ARCH_HAS_BANDGAP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA

