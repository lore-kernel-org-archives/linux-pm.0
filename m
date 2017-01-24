From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 3/4] dmaengine: pl330: Store pointer to slave device
Date: Tue, 24 Jan 2017 16:13:02 +0100
Message-ID: <CAPDyKFrxJYhxq64L0syeqXRkBBhf+u7V7PR9oTBF8z3GpgVo7g@mail.gmail.com>
References: <CGME20170124092751eucas1p2807f068bdbcd695d0bec355e6b509d6c@eucas1p2.samsung.com>
 <1485250055-22137-1-git-send-email-m.szyprowski@samsung.com> <1485250055-22137-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32973 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdAXPNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 10:13:05 -0500
Received: by mail-wm0-f52.google.com with SMTP id d140so43629068wmd.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2017 07:13:04 -0800 (PST)
In-Reply-To: <1485250055-22137-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

On 24 January 2017 at 10:27, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Store the pointer to slave device, which requested our channel. It will be
> later used to implement runtime PM of PL330 DMA controller. Although
> DMA channels might be requested many times, each DMA peripheral channel is
> physically dedicated only for specific hardware, so there should be only
> one slave device for each channel.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/dma/pl330.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index b6b2cc912380..c77a3494659c 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -450,6 +450,7 @@ struct dma_pl330_chan {
>
>         /* for runtime pm tracking */
>         bool active;
> +       struct device *slave;
>  };
>
>  struct pl330_dmac {
> @@ -2093,6 +2094,14 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
>         if (chan_id >= pl330->num_peripherals)
>                 return NULL;
>
> +       if (!pl330->peripherals[chan_id].slave) {
> +               pl330->peripherals[chan_id].slave = slave;
> +       } else if (pl330->peripherals[chan_id].slave != slave) {
> +               dev_err(pl330->ddma.dev,
> +                       "Can't use same channel with multiple slave devices!\n");
> +               return NULL;
> +       }
> +
>         return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
>  }
>
> --
> 1.9.1
>
