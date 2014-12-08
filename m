From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: Remove ARCH_HAS_BANDGAP selection
Date: Mon, 08 Dec 2014 10:44:12 +0100
Message-ID: <20141208104412.76c3023d@amdc2363>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
 <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59910 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbaLHJof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 04:44:35 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NG900ACXCEA99C0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 08 Dec 2014 18:44:34 +0900 (KST)
In-reply-to: <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Hi Abhilash,

> On removing the samsung thermal driver dependency on ARCH_HAS_BANDGAP,
> selection of this symbol becomes redundant.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig
> b/arch/arm/mach-exynos/Kconfig index e4a00ba..6ddfce7 100644
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

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
