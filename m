From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] PM / Domains: Remove redundant pm_runtime_get|put*()
 in pm_genpd_prepare()
Date: Tue, 26 Apr 2016 09:08:22 +0200
Message-ID: <CAPDyKFq_6ZFt6W5wkYzpw2tq=-9496e00TkspRL4U8-P+239Aw@mail.gmail.com>
References: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org>
	<1461653238-3891-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37303 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcDZHIX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 03:08:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so18115435wmn.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 00:08:22 -0700 (PDT)
In-Reply-To: <1461653238-3891-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 26 April 2016 at 08:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The PM core increases and decreases the runtime PM usage count in the
> system PM prepare phase. This makes some of the pm_runtime_get|put*()
> calls in pm_gendp_prepare() redundant, so let's remove them.

Huh, I noticed I missed to update pm_gendp_prepare() to pm_genpd_prepare().

Rafael, can you amend the patch or you want me to send a v3?

Kind regards
Uffe

>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> ---
>
> Changes in v2:
>         Updated changlog and added Kevin's reviewed by.
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
>          * at this point and a system wakeup event should be reported if it's
>          * set up to wake up the system from sleep states.
>          */
> -       pm_runtime_get_noresume(dev);
>         if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
>                 pm_wakeup_event(dev, 0);
>
> -       if (pm_wakeup_pending()) {
> -               pm_runtime_put(dev);
> +       if (pm_wakeup_pending())
>                 return -EBUSY;
> -       }
>
>         if (resume_needed(dev, genpd))
>                 pm_runtime_resume(dev);
> @@ -751,10 +748,8 @@ static int pm_genpd_prepare(struct device *dev)
>
>         mutex_unlock(&genpd->lock);
>
> -       if (genpd->suspend_power_off) {
> -               pm_runtime_put_noidle(dev);
> +       if (genpd->suspend_power_off)
>                 return 0;
> -       }
>
>         /*
>          * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
> @@ -776,7 +771,6 @@ static int pm_genpd_prepare(struct device *dev)
>                 pm_runtime_enable(dev);
>         }
>
> -       pm_runtime_put(dev);
>         return ret;
>  }
>
> --
> 1.9.1
>
