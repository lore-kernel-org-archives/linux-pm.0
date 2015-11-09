From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: rockchip: fix compile error
Date: Mon, 9 Nov 2015 11:36:39 -0800
Message-ID: <20151109193638.GB10824@localhost.localdomain>
References: <1446990043-8096-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446990043-8096-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, lkp@intel.com
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 08, 2015 at 09:40:43PM +0800, Caesar Wang wrote:
> Missing a include file caused compile error.
> 
> drivers/thermal/rockchip_thermal.c:
> In function 'rockchip_thermal_suspend':
> drivers/thermal/rockchip_thermal.c:720:2: error: implicit
> declaration of function 'pinctrl_pm_select_sleep_state'
> [-Werror=implicit-function-declaration]
> pinctrl_pm_select_sleep_state(dev);
>                  ^
> drivers/thermal/rockchip_thermal.c:
> In function 'rockchip_thermal_resume':
> drivers/thermal/rockchip_thermal.c:759:2: error: implicit
> declaration of function 'pinctrl_pm_select_default_state'
> [-Werror=implicit-function-declaration]
> ^pinctrl_pm_select_default_state(dev);
> cc1: some warnings being treated as errors
> 
> Fixes: 7e38a5b1daa1 ("thermal: rockchip: support the sleep pinctrl state
> to avoid glitches")


Adding this to my tree and sending to ruis too.


Thanks

> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index df28049..8928d67 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/thermal.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /**
>   * If the temperature over a period of time High,
> -- 
> 1.9.1
> 
