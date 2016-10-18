From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
Date: Tue, 18 Oct 2016 17:08:35 +0530
Message-ID: <20161018113835.GB11471@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476561450-28407-2-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 15-10-16, 21:57, Robert Jarzmik wrote:
> For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
> doing the job as well as pxa2xx-cpufreq, so add these platforms to the
> compatibility list.
> 
> This won't work for legacy non device-tree platforms where
> pxa2xx-cpufreq is still required.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 0bb44d5b5df4..356825b5c9b8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -32,6 +32,8 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "fsl,imx7d", },
>  
>  	{ .compatible = "marvell,berlin", },
> +	{ .compatible = "marvell,pxa250", },
> +	{ .compatible = "marvell,pxa270", },
>  
>  	{ .compatible = "samsung,exynos3250", },
>  	{ .compatible = "samsung,exynos4210", },

Isn't there a race between cpufreq-dt and the platform driver to
register first ?

Also, it seems that atleast the next two patches are required before
applying this? You need to fix the order if that is the case.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
