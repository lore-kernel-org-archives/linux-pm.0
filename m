From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()
Date: Tue, 26 Apr 2016 10:27:31 +0300
Message-ID: <3028151.zbjnfJOmjv@avalon>
References: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org> <1461653238-3891-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:37697 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbcDZH1I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 03:27:08 -0400
In-Reply-To: <1461653238-3891-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>

Hi Ulf,

Thank you for the patch.

On Tuesday 26 Apr 2016 08:47:17 Ulf Hansson wrote:
> The PM core increases and decreases the runtime PM usage count in the
> system PM prepare phase. This makes some of the pm_runtime_get|put*()
> calls in pm_gendp_prepare() redundant, so let's remove them.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Apart from the gendp typo,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2:
> 	Updated changlog and added Kevin's reviewed by.
> 
> ---
>  drivers/base/power/domain.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4ce4ce0..60a3573 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -730,14 +730,11 @@ static int pm_genpd_prepare(struct device *dev)
>  	 * at this point and a system wakeup event should be reported if it's
>  	 * set up to wake up the system from sleep states.
>  	 */
> -	pm_runtime_get_noresume(dev);
>  	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
>  		pm_wakeup_event(dev, 0);
> 
> -	if (pm_wakeup_pending()) {
> -		pm_runtime_put(dev);
> +	if (pm_wakeup_pending())
>  		return -EBUSY;
> -	}
> 
>  	if (resume_needed(dev, genpd))
>  		pm_runtime_resume(dev);
> @@ -751,10 +748,8 @@ static int pm_genpd_prepare(struct device *dev)
> 
>  	mutex_unlock(&genpd->lock);
> 
> -	if (genpd->suspend_power_off) {
> -		pm_runtime_put_noidle(dev);
> +	if (genpd->suspend_power_off)
>  		return 0;
> -	}
> 
>  	/*
>  	 * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
> @@ -776,7 +771,6 @@ static int pm_genpd_prepare(struct device *dev)
>  		pm_runtime_enable(dev);
>  	}
> 
> -	pm_runtime_put(dev);
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart
