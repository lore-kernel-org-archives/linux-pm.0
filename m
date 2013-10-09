From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] thermal: Kconfig: cosmetic fixes
Date: Wed, 09 Oct 2013 11:52:40 +0800
Message-ID: <1381290760.2133.37.camel@rzhang1-mobl4>
References: <1380306033-20325-1-git-send-email-luka@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6554 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab3JIDwo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Oct 2013 23:52:44 -0400
In-Reply-To: <1380306033-20325-1-git-send-email-luka@openwrt.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luka Perkov <luka@openwrt.org>
Cc: linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>

On Fri, 2013-09-27 at 20:20 +0200, Luka Perkov wrote:
> Fix typo, finish sentence and add missing dots.
> 
> Signed-off-by: Luka Perkov <luka@openwrt.org>
> CC: Randy Dunlap <rdunlap@infradead.org>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> v1 -> v2:
> * address Randy's comment about unfinished sentence
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index dbfc390..3910b09 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -56,7 +56,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  	select THERMAL_GOV_USER_SPACE
>  	help
>  	  Select this if you want to let the user space manage the
> -	  lpatform thermals.
> +	  platform thermals.
>  
>  endchoice
>  
> @@ -69,6 +69,7 @@ config THERMAL_GOV_STEP_WISE
>  	bool "Step_wise thermal governor"
>  	help
>  	  Enable this to manage platform thermals using a simple linear
> +	  governor.
>  
>  config THERMAL_GOV_USER_SPACE
>  	bool "User_space thermal governor"
> @@ -117,14 +118,14 @@ config SPEAR_THERMAL
>  	depends on OF
>  	help
>  	  Enable this to plug the SPEAr thermal sensor driver into the Linux
> -	  thermal framework
> +	  thermal framework.
>  
>  config RCAR_THERMAL
>  	tristate "Renesas R-Car thermal driver"
>  	depends on ARCH_SHMOBILE
>  	help
>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
> -	  thermal framework
> +	  thermal framework.
>  
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"


