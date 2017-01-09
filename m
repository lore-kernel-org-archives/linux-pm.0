From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/4] dmaengine: pl330: Don't require irq-safe runtime
 PM
Date: Mon, 9 Jan 2017 20:47:59 +0200
Message-ID: <20170109184759.3jijirfunhimqogt@kozik-lap>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140327eucas1p20df21c98a5744003cd2687162f35ec10@eucas1p2.samsung.com>
 <1483970598-6191-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483970598-6191-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 09, 2017 at 03:03:18PM +0100, Marek Szyprowski wrote:
> This patch replaces irq-safe runtime PM with non-irq-safe version based on
> the new approach. Existing, irq-safe runtime PM implementation for PL330 was
> not bringing much benefits of its own - only clocks were enabled/disabled.
> 
> Till now non-irq-safe runtime PM implementation was only possible by calling
> pm_runtime_get/put functions from alloc/free_chan_resources. All other DMA
> engine API functions cannot be called from a context, which permits sleeping.
> Such implementation, in practice would result in keeping DMA controller's
> device active almost all the time, because most of the slave device drivers
> (DMA engine clients) acquire DMA channel in their probe() function and
> released it during driver removal.
> 
> This patch provides a new, different approach. It is based on an observation
> that there can be only one slave device using each DMA channel. PL330 hardware
> always has dedicated channels for each peripheral device. Using recently
> introduced device dependencies (links) infrastructure one can ensure proper
> runtime PM state of PL330 DMA controller basing on the runtime PM state of
> the slave device.
> 
> In this approach in pl330_alloc_chan_resources() function a new dependency
> is being created between PL330 DMA controller device (as a supplier) and
> given slave device (as a consumer). This way PL330 DMA controller device
> runtime active counter is increased when the slave device is resumed and
> decreased the same time when given slave device is put to suspend. This way
> it has been ensured to keep PL330 DMA controller runtime active if there is
> an active used of any of its DMA channels. Slave device pointer is initially
> stored in per-channel data in of_dma_xlate callback. This is similar to what
> has been already implemented in Exynos IOMMU driver in commit 2f5f44f205cc95
> ("iommu/exynos: Use device dependency links to control runtime pm").
> 
> If slave device doesn't implement runtime PM or keeps device runtime active
> all the time, then PL330 DMA controller will be runtime active all the time
> when channel is being allocated. The goal is however to have runtime PM
> added to all devices in the system, because it lets respective power
> domains to be turned off, what gives the best results in terms of power
> saving.
> 
> If one requests memory-to-memory channel, runtime active counter is
> increased unconditionally. This might be a drawback of this approach, but
> PL330 is not really used for memory-to-memory operations due to poor
> performance in such operations compared to the CPU.
> 
> Introducing non-irq-safe runtime power management finally allows to turn off
> audio power domain on Exynos5 SoCs.
> 
> Removal of irq-safe runtime PM is based on the revert of the following
> commits:
> 1. "dmaengine: pl330: fix runtime pm support" commit
>    5c9e6c2b2ba3ec3a442e2fb5b4286498f8b4dcb7
> 2. "dmaengine: pl330: Fix hang on dmaengine_terminate_all on certain boards"
>    commit 81cc6edc08705ac0146fe6ac14a0982a31ce6f3d
> 3. "ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12"
>    commit ae43b3289186480f81c78bb63d788a85a3631f47

Checkpatch will complain here. I think following standard pattern of
'commit XYZ ("abc")' makes sense.

Beside that, one not important remark below.

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/pl330.c | 124 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 61 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 9c72f535739c..2cffbb44b09e 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -268,9 +268,6 @@ enum pl330_byteswap {
>  
>  #define NR_DEFAULT_DESC	16
>  
> -/* Delay for runtime PM autosuspend, ms */
> -#define PL330_AUTOSUSPEND_DELAY 20
> -
>  /* Populated by the PL330 core driver for DMA API driver's info */
>  struct pl330_config {
>  	u32	periph_id;
> @@ -449,8 +446,8 @@ struct dma_pl330_chan {
>  	bool cyclic;
>  
>  	/* for runtime pm tracking */
> -	bool active;
>  	struct device *slave;
> +	struct device_link *slave_link;
>  };
>  
>  struct pl330_dmac {
> @@ -2016,7 +2013,6 @@ static void pl330_tasklet(unsigned long data)
>  	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
>  	struct dma_pl330_desc *desc, *_dt;
>  	unsigned long flags;
> -	bool power_down = false;
>  
>  	spin_lock_irqsave(&pch->lock, flags);
>  
> @@ -2031,18 +2027,10 @@ static void pl330_tasklet(unsigned long data)
>  	/* Try to submit a req imm. next to the last completed cookie */
>  	fill_queue(pch);
>  
> -	if (list_empty(&pch->work_list)) {
> -		spin_lock(&pch->thread->dmac->lock);
> -		_stop(pch->thread);
> -		spin_unlock(&pch->thread->dmac->lock);
> -		power_down = true;
> -		pch->active = false;
> -	} else {
> -		/* Make sure the PL330 Channel thread is active */
> -		spin_lock(&pch->thread->dmac->lock);
> -		_start(pch->thread);
> -		spin_unlock(&pch->thread->dmac->lock);
> -	}
> +	/* Make sure the PL330 Channel thread is active */
> +	spin_lock(&pch->thread->dmac->lock);
> +	_start(pch->thread);
> +	spin_unlock(&pch->thread->dmac->lock);
>  
>  	while (!list_empty(&pch->completed_list)) {
>  		struct dmaengine_desc_callback cb;
> @@ -2055,13 +2043,6 @@ static void pl330_tasklet(unsigned long data)
>  		if (pch->cyclic) {
>  			desc->status = PREP;
>  			list_move_tail(&desc->node, &pch->work_list);
> -			if (power_down) {
> -				pch->active = true;
> -				spin_lock(&pch->thread->dmac->lock);
> -				_start(pch->thread);
> -				spin_unlock(&pch->thread->dmac->lock);
> -				power_down = false;
> -			}
>  		} else {
>  			desc->status = FREE;
>  			list_move_tail(&desc->node, &pch->dmac->desc_pool);
> @@ -2076,12 +2057,6 @@ static void pl330_tasklet(unsigned long data)
>  		}
>  	}
>  	spin_unlock_irqrestore(&pch->lock, flags);
> -
> -	/* If work list empty, power down */
> -	if (power_down) {
> -		pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
> -		pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
> -	}
>  }
>  
>  bool pl330_filter(struct dma_chan *chan, void *param)
> @@ -2125,11 +2100,52 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
>  	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
>  }
>  
> +static int pl330_add_slave_link(struct pl330_dmac *pl330,
> +				struct dma_pl330_chan *pch)
> +{
> +	struct device_link *link;
> +	int i;
> +
> +	if (pch->slave_link)
> +		return 0;
> +
> +	link = device_link_add(pch->slave, pl330->ddma.dev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

Align the arguments with open parenthesis?

Anyway, nice job!
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
