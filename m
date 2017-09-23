From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] thermal: enable broadcom menu for arm64 bcm2835
Date: Sat, 23 Sep 2017 13:22:52 +0200 (CEST)
Message-ID: <743012766.209822.1506165772416@email.1und1.de>
References: <20170902033639.26774-1-allenwild93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60726 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdIWLXU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Sep 2017 07:23:20 -0400
In-Reply-To: <20170902033639.26774-1-allenwild93@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Allen Wild <allenwild93@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

Hi Allen,

> Allen Wild <allenwild93@gmail.com> hat am 2. September 2017 um 05:36 geschrieben:
> 
> 
> Moving the bcm2835 thermal driver to the broadcom directory prevented it
> from getting enabled for arm64 builds, since the broadcom directory is only
> available when 32-bit specific ARCH_BCM is set.
> 
> Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.
> 
> Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
> Cc: linux-rpi-kernel@lists.infradead.org
> Signed-off-by: Allen Wild <allenwild93@gmail.com>

could you please resend your patch with thermal maintainers in CC?

Thanks
Stefan

> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b5b5facb8747..962620925878 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -408,7 +408,7 @@ config MTK_THERMAL
>  	  controller present in Mediatek SoCs
>  
>  menu "Broadcom thermal drivers"
> -depends on ARCH_BCM || COMPILE_TEST
> +depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
>  source "drivers/thermal/broadcom/Kconfig"
>  endmenu
>  
> -- 
> 2.14.1
> 
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
