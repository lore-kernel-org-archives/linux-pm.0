From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] typo in drivers/thermal/Kconfig: lpatform instead of
 platform
Date: Wed, 25 Sep 2013 22:25:26 +0800
Message-ID: <1380119126.4879.0.camel@rzhang1-mobl4>
References: <20130908215853.GD8821@nt1.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130908215853.GD8821@nt1.in>
Sender: linux-kernel-owner@vger.kernel.org
To: Regid Ichira <regid23@nt1.in>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2013-09-09 at 00:58 +0300, Regid Ichira wrote:
> Applied to the HEAD of linux.git,
>                        VERSION = 3 PATCHLEVEL = 11 SUBLEVEL = 0
> Signed-off-by: Regid Ichira <regid23@nt1.in>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e988c81..3f99f79 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -47,7 +47,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  	select THERMAL_GOV_USER_SPACE
>  	help
>  	  Select this if you want to let the user space manage the
> -	  lpatform thermals.
> +	  platform thermals.
>  
>  endchoice
>  
