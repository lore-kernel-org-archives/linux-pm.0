From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency
 for samsung
Date: Mon, 08 Dec 2014 10:43:33 +0100
Message-ID: <20141208104333.0e044c58@amdc2363>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59845 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbaLHJoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 04:44:06 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NG90093NCD5LND0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 08 Dec 2014 18:43:53 +0900 (KST)
In-reply-to: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Hi Abhilash,

> As samsung thermal support is enabled only for ARCH_EXYNOS, there is
> no need to select ARCH_HAS_BANDGAP from the arch-specific code.
> Removing this dependency will also allow the driver to be enabled on
> 64-bit SoCs.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
> This was based on the discussion regarding adding ARCH_HAS_BANDGAP
> symbol for arm64 here:
> http://www.spinics.net/lists/arm-kernel/msg377560.html
> 
>  drivers/thermal/samsung/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/Kconfig
> b/drivers/thermal/samsung/Kconfig index f760389..c43306e 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -1,6 +1,6 @@
>  config EXYNOS_THERMAL
>  	tristate "Exynos thermal management unit driver"
> -	depends on ARCH_HAS_BANDGAP && OF
> +	depends on OF
>  	help
>  	  If you say yes here you get support for the TMU (Thermal
> Management Unit) driver for SAMSUNG EXYNOS series of SoCs. This
> driver initialises

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
