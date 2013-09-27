From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] thermal: Kconfig: cosmetic fixes
Date: Fri, 27 Sep 2013 07:30:39 -0700
Message-ID: <5245968F.2020502@infradead.org>
References: <1380270220-32147-1-git-send-email-luka@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54710 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab3I0ObB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 10:31:01 -0400
In-Reply-To: <1380270220-32147-1-git-send-email-luka@openwrt.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luka Perkov <luka@openwrt.org>
Cc: linux-pm@vger.kernel.org

On 09/27/13 01:23, Luka Perkov wrote:
> Fix typo and add missing dots.
> 
> Signed-off-by: Luka Perkov <luka@openwrt.org>
> ---
>  drivers/thermal/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index dbfc390..ea74abb 100644
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
> @@ -68,7 +68,7 @@ config THERMAL_GOV_FAIR_SHARE
>  config THERMAL_GOV_STEP_WISE
>  	bool "Step_wise thermal governor"
>  	help
> -	  Enable this to manage platform thermals using a simple linear
> +	  Enable this to manage platform thermals using a simple linear.

Missing some ending word?  maybe:
	                                          using a simple linear governor.

>  
>  config THERMAL_GOV_USER_SPACE
>  	bool "User_space thermal governor"
> @@ -117,14 +117,14 @@ config SPEAR_THERMAL
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
> 


-- 
~Randy
