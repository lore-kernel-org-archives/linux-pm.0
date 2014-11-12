From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 5/6] dmaengine: pl330: Add PM sleep support
Date: Wed, 12 Nov 2014 16:28:16 +0100
Message-ID: <CAPDyKFoBdq0Vdh-RELGMX_oud2PaDofqBHgc-ViReYwP9-=y2w@mail.gmail.com>
References: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
	<1415802748-30530-6-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:54964 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbaKLP2R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 10:28:17 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so9002886qgd.36
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2014 07:28:17 -0800 (PST)
In-Reply-To: <1415802748-30530-6-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 12 November 2014 15:32, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> Add system suspend/resume capabilities to the pl330 driver so the amba
> bus clock could be also unprepared to conserve energy.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/dma/pl330.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index c3bd3584f261..fd71777fc565 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2627,6 +2627,42 @@ static int pl330_dma_device_slave_caps(struct dma_chan *dchan,
>         return 0;
>  }
>
> +/*
> + * Runtime PM callbacks are provided by amba/bus.c driver.
> + *
> + * It is assumed here that IRQ safe runtime PM is chosen in probe and amba
> + * bus driver will only disable/enable the clock in runtime PM callbacks.
> + */
> +static int __maybe_unused pl330_suspend(struct device *dev)
> +{
> +       struct amba_device *pcdev = to_amba_device(dev);
> +
> +       if (!pm_runtime_status_suspended(dev)) {

No, this wont work. Consider this scenario:

pm_runtime_status_suspended() returns "true", which means you consider
the device to be runtime PM suspended, thus you will unprepare the
clock below.

Later, a call to pm_runtime_get_sync() is invoked from "somewhere" and
before this driver's system PM resume callback has been invoked. That
will trigger the runtime PM resume callback to be invoked, causing
clock unbalance issues.

You need a pm_runtime_disable() prior checking the runtime PM status
using pm_runtime_status_suspended(). That will prevent this from
happen.

I guess you may see where this is leading. I think
pm_runtime_force_suspend|resume() is well suited for this situation.

> +               /* amba did not disable the clock */
> +               amba_pclk_disable(pcdev);
> +       }
> +       amba_pclk_unprepare(pcdev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused pl330_resume(struct device *dev)
> +{
> +       struct amba_device *pcdev = to_amba_device(dev);
> +       int ret;
> +
> +       ret = amba_pclk_prepare(pcdev);
> +       if (ret)
> +               return ret;
> +
> +       if (!pm_runtime_status_suspended(dev))
> +               ret = amba_pclk_enable(pcdev);
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pl330_pm, pl330_suspend, pl330_resume);
> +
>  static int
>  pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  {
> @@ -2853,6 +2889,7 @@ static struct amba_driver pl330_driver = {
>         .drv = {
>                 .owner = THIS_MODULE,
>                 .name = "dma-pl330",
> +               .pm = &pl330_pm,
>         },
>         .id_table = pl330_ids,
>         .probe = pl330_probe,
> --
> 1.9.1
>

Kind regards
Uffe
