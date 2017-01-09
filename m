From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/4] dmaengine: pl330: Store pointer to slave device
Date: Mon, 9 Jan 2017 20:08:21 +0200
Message-ID: <CAJKOXPeFMpt1nKHD=zqEiFb45Hoxv-=+SHav=8C=KVbYJ0DAbA@mail.gmail.com>
References: <CGME20170109140326eucas1p29d3e54da58845589e2adf70db854d996@eucas1p2.samsung.com>
 <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com> <1483970598-6191-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1483970598-6191-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 9, 2017 at 4:03 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Store the pointer to slave device, which requested our channel. It will be
> later used to implement runtime PM of PL330 DMA controller. Although
> DMA channels might be requested many times, each DMA peripheral channel is
> physically dedicated only for specific hardware, so there should be only
> one slave device for each channel.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/pl330.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 3c80e71271a2..9c72f535739c 100644
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
> @@ -2113,6 +2114,14 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
>         if (chan_id >= pl330->num_peripherals)
>                 return NULL;
>
> +       if (!pl330->peripherals[chan_id].slave)
> +               pl330->peripherals[chan_id].slave = slave;

Following coding style, this should be inside {} because the other
branch has them. Beside that:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> +       else if (pl330->peripherals[chan_id].slave != slave) {
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
