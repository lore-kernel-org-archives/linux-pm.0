From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 3/6] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Wed, 12 Nov 2014 16:29:47 +0100
Message-ID: <CAPDyKFoJFGhyNSqrie9TddBOTvZ2-RVqvET9Y6JCvJqh+FMgww@mail.gmail.com>
References: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
	<1415802748-30530-4-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:53656 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaKLP3s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 10:29:48 -0500
Received: by mail-qa0-f51.google.com with SMTP id f12so8403636qad.38
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2014 07:29:47 -0800 (PST)
In-Reply-To: <1415802748-30530-4-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 12 November 2014 15:32, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> The AMBA bus driver defines runtime Power Management functions which
> disable and unprepare AMBA bus clock. This is problematic for runtime PM
> because unpreparing a clock might sleep so it is not interrupt safe.
>
> However some drivers may want to implement runtime PM functions in
> interrupt-safe way (see pm_runtime_irq_safe()). In such case the AMBA
> bus driver should only disable/enable the clock in runtime suspend and
> resume callbacks.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/amba/bus.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index a4ac490dd784..c2153a1d1981 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -95,8 +95,12 @@ static int amba_pm_runtime_suspend(struct device *dev)
>         struct amba_device *pcdev = to_amba_device(dev);
>         int ret = pm_generic_runtime_suspend(dev);
>
> -       if (ret == 0 && dev->driver)
> -               clk_disable_unprepare(pcdev->pclk);
> +       if (ret == 0 && dev->driver) {
> +               if (pm_runtime_is_irq_safe(dev))
> +                       clk_disable(pcdev->pclk);
> +               else
> +                       clk_disable_unprepare(pcdev->pclk);
> +       }
>
>         return ret;
>  }
> @@ -107,7 +111,10 @@ static int amba_pm_runtime_resume(struct device *dev)
>         int ret;
>
>         if (dev->driver) {
> -               ret = clk_prepare_enable(pcdev->pclk);
> +               if (pm_runtime_is_irq_safe(dev))
> +                       ret = clk_enable(pcdev->pclk);
> +               else
> +                       ret = clk_prepare_enable(pcdev->pclk);
>                 /* Failure is probably fatal to the system, but... */
>                 if (ret)
>                         return ret;
> @@ -115,7 +122,7 @@ static int amba_pm_runtime_resume(struct device *dev)
>
>         return pm_generic_runtime_resume(dev);
>  }
> -#endif
> +#endif /* CONFIG_PM */
>
>  static const struct dev_pm_ops amba_pm = {
>         .suspend        = pm_generic_suspend,
> --
> 1.9.1
>
