From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal:samsung: fix compilation warning
Date: Thu, 02 Jan 2014 10:27:37 +0800
Message-ID: <1388629657.3739.69.camel@rzhang1-mobl4>
References: <1387541527-4762-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387541527-4762-1-git-send-email-ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eduardo.valentin-l0cyMroinI0@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-12-20 at 17:42 +0530, Naveen Krishna Chatradhi wrote:
> This patch fixes a compilation warning.
> 
> warning: passing argument 5 of 'thermal_zone_device_register' discards 'const'
> qualifier from pointer target type [enabled by default]
> include/linux/thermal.h:270:29: note: expected 'struct thermal_zone_device_ops *'
> but argument is of type 'const struct thermal_zone_device_ops *'
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

applied.

thanks,
rui
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
> index c2301da..3f5ad25 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -280,7 +280,7 @@ static int exynos_get_trend(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  /* Operation callback functions for thermal zone */
> -static struct thermal_zone_device_ops const exynos_dev_ops = {
> +static struct thermal_zone_device_ops exynos_dev_ops = {
>  	.bind = exynos_bind,
>  	.unbind = exynos_unbind,
>  	.get_temp = exynos_get_temp,


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
