From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2] thermal: allow building dove_thermal with mvebu
Date: Sat, 31 May 2014 14:54:40 +0200
Message-ID: <5389D110.8020606@gmail.com>
References: <1401452899-13952-1-git-send-email-riku.voipio@linaro.org> <1401537027-32291-1-git-send-email-riku.voipio@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:39540 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbaEaMyo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 May 2014 08:54:44 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so3121368wgh.23
        for <linux-pm@vger.kernel.org>; Sat, 31 May 2014 05:54:43 -0700 (PDT)
In-Reply-To: <1401537027-32291-1-git-send-email-riku.voipio@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Riku Voipio <riku.voipio@linaro.org>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-arm-kernel@lists.infradead.org

On 05/31/2014 01:50 PM, Riku Voipio wrote:
> DT-enabled Dove has moved from ARCH_DOVE in mach-dove to MACH_DOVE
> in mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE to thermal Kconfig.
> 
> This was originally supposed to go in via "ARM: dove: prepare new Dove DT Kconfig"
> patch from Sebastian Hesselbarth for 3.15, but slipped through the cracks.
> 
> I've tested on CuBox that without this patch you can't compile
> dove_thermal into a mach-mvebu based kernel, and with this patch I can
> build the driver and it works as expected run-time.

Riku,

looking through my mails, the corresponding patch should have
already been applied [1].

If not, you get my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

[1] https://lkml.kernel.org/r/1395295065.3571.10.camel@rzhang1-mobl4

> v2: non-ascii char creeped in somehow
> 
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d51912..5783c72 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -151,7 +151,7 @@ config KIRKWOOD_THERMAL
>  
>  config DOVE_THERMAL
>  	tristate "Temperature sensor on Marvell Dove SoCs"
> -	depends on ARCH_DOVE
> +	depends on ARCH_DOVE || MACH_DOVE
>  	depends on OF
>  	help
>  	  Support for the Dove thermal sensor driver in the Linux thermal
> 

