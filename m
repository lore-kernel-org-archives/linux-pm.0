From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 1/3] dmaengine: Add new device_{set,release}_slave
 callbacks
Date: Fri, 10 Feb 2017 10:04:42 +0530
Message-ID: <20170210043442.GM19244@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142307eucas1p180323d005f524760913b8d04ac966423@eucas1p1.samsung.com>
 <1486650171-20598-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486650171-20598-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 09, 2017 at 03:22:49PM +0100, Marek Szyprowski wrote:
> Add two new callbacks to DMA engine device. They will used to provide
> access to slave device (the device which requested given DMA channel)

You mean access to client devices?

> for DMA engine driver. Access to slave device might be useful for example
> for implementing advanced runtime power management.
> 
> DMA slave channels are exclusive, so only one slave device can be set
> for a given DMA slave channel.

That is not a right assumption and my worry here. With virt-dma we don't
really assume a hardware channel and exclusive. Certain implementation may
do that but from framework we cannot assume that.

> device_set_slave() will be called after the device_alloc_chan_resources()
> and device_release_slave() before the device_free_chan_resources().

Okay, I had to relook at the series to get around this part. Sorry but we
can't call it set_slave, it is actually set_client/consumer

In our context slaves means dmaengine slave devices aka provider.
Client would be the consumer and not slave.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/dmaengine.c   | 27 ++++++++++++++++++++++++---
>  include/linux/dmaengine.h | 10 ++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 24e0221fd66d..5b7089d8be4d 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -705,6 +705,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  {
>  	struct dma_device *d, *_d;
>  	struct dma_chan *chan = NULL;
> +	int ret;
>  
>  	/* If device-tree is present get slave info from here */
>  	if (dev->of_node)
> @@ -715,8 +716,9 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  		chan = acpi_dma_request_slave_chan_by_name(dev, name);
>  
>  	if (chan) {
> -		/* Valid channel found or requester need to be deferred */
> -		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> +		if (!IS_ERR(chan))
> +			goto found;
> +		if (PTR_ERR(chan) == -EPROBE_DEFER)
>  			return chan;
>  	}
>  
> @@ -738,7 +740,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	}
>  	mutex_unlock(&dma_list_mutex);
>  
> -	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> +	if (!chan)
> +		return ERR_PTR(-EPROBE_DEFER);
> +	if (IS_ERR(chan))
> +		return chan;
> +found:
> +	if (chan->device->device_set_slave) {
> +		chan->slave = dev;
> +		ret = chan->device->device_set_slave(chan, dev);
> +		if (ret) {
> +			chan->slave = NULL;
> +			dma_release_channel(chan);
> +			chan = ERR_PTR(ret);
> +		}
> +	}
> +	return chan;
>  }
>  EXPORT_SYMBOL_GPL(dma_request_chan);
>  
> @@ -786,6 +802,11 @@ void dma_release_channel(struct dma_chan *chan)
>  	mutex_lock(&dma_list_mutex);
>  	WARN_ONCE(chan->client_count != 1,
>  		  "chan reference count %d != 1\n", chan->client_count);
> +	if (chan->slave) {
> +		if (chan->device->device_release_slave)
> +			chan->device->device_release_slave(chan);
> +		chan->slave = NULL;
> +	}
>  	dma_chan_put(chan);
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 533680860865..d22299e37e69 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -277,6 +277,9 @@ struct dma_chan {
>  	struct dma_router *router;
>  	void *route_data;
>  
> +	/* Only for SLAVE channels */
> +	struct device *slave;

so assuming you refer to consumer aka client here, why do we need set if we
store it here.

> +
>  	void *private;
>  };
>  
> @@ -686,6 +689,10 @@ struct dma_filter {
>   * @device_alloc_chan_resources: allocate resources and return the
>   *	number of allocated descriptors
>   * @device_free_chan_resources: release DMA channel's resources
> + * @device_set_slave: provide access to the slave device, which requested
> + *	given DMA channel, called after @device_alloc_chan_resources
> + * @device_release_slave: finishes access to the slave device, called
> + *	before @device_free_chan_resources
>   * @device_prep_dma_memcpy: prepares a memcpy operation
>   * @device_prep_dma_xor: prepares a xor operation
>   * @device_prep_dma_xor_val: prepares a xor validation operation
> @@ -746,6 +753,9 @@ struct dma_device {
>  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
>  	void (*device_free_chan_resources)(struct dma_chan *chan);
>  
> +	int (*device_set_slave)(struct dma_chan *chan, struct device *slave);
> +	void (*device_release_slave)(struct dma_chan *chan);
> +
>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
>  		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  		size_t len, unsigned long flags);
> -- 
> 1.9.1
> 

-- 
~Vinod
