From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 2/2] PM / Domains: Drop unnecessary wakeup code from pm_genpd_prepare()
Date: Tue, 26 Apr 2016 10:31:37 +0300
Message-ID: <4471844.9GATtWcZMn@avalon>
References: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org> <1461653238-3891-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:37711 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbcDZHbN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 03:31:13 -0400
In-Reply-To: <1461653238-3891-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>

Hi Ulf,

Thank you for the patch.

On Tuesday 26 Apr 2016 08:47:18 Ulf Hansson wrote:
> As the PM core already have wakeup management during the system PM phase,
> it seems reasonable that genpd and its users should be able to rely on
> that. Therefore let's remove this from pm_genpd_prepare().

It's probably because I'm not familiar enough with the PM implementation, but 
I haven't been able to locate the wakeup management code in the PM core.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	None.
> 
> ---
>  drivers/base/power/domain.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 60a3573..de23b64 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -730,12 +730,6 @@ static int pm_genpd_prepare(struct device *dev)
>  	 * at this point and a system wakeup event should be reported if it's
>  	 * set up to wake up the system from sleep states.
>  	 */
> -	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> -		pm_wakeup_event(dev, 0);
> -
> -	if (pm_wakeup_pending())
> -		return -EBUSY;
> -
>  	if (resume_needed(dev, genpd))
>  		pm_runtime_resume(dev);

-- 
Regards,

Laurent Pinchart

