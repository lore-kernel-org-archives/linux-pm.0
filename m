From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 1/3] dmaengine: Add new device_{set,release}_slave
 callbacks
Date: Mon, 13 Feb 2017 07:12:29 +0530
Message-ID: <20170213014229.GG2843@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142307eucas1p180323d005f524760913b8d04ac966423@eucas1p1.samsung.com>
 <1486650171-20598-2-git-send-email-m.szyprowski@samsung.com>
 <20170210043442.GM19244@localhost>
 <05d42359-1e72-3ec1-7d86-86135a8f013e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:4872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbdBMBl4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Feb 2017 20:41:56 -0500
Content-Disposition: inline
In-Reply-To: <05d42359-1e72-3ec1-7d86-86135a8f013e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>

On Fri, Feb 10, 2017 at 01:07:41PM +0100, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 2017-02-10 05:34, Vinod Koul wrote:
> >On Thu, Feb 09, 2017 at 03:22:49PM +0100, Marek Szyprowski wrote:
> >>Add two new callbacks to DMA engine device. They will used to provide
> >>access to slave device (the device which requested given DMA channel)
> >You mean access to client devices?
> 
> Yes. It looks that I was confused by the code, where the term 'slave'
> appears a few times. 'Client' is a bit more appropriate then.
> 
> >>for DMA engine driver. Access to slave device might be useful for example
> >>for implementing advanced runtime power management.
> >>
> >>DMA slave channels are exclusive, so only one slave device can be set
> >>for a given DMA slave channel.
> >That is not a right assumption and my worry here. With virt-dma we don't
> >really assume a hardware channel and exclusive. Certain implementation may
> >do that but from framework we cannot assume that.
> 
> Okay, I came to such conclusion basing one the dma engine code, but maybe
> I missed something. However in such case such callback will be called for
> each client device and it will be up to the driver to handle that.

Thats right, but the assumption that we will have once physical channel
maynot be true.

> >>device_set_slave() will be called after the device_alloc_chan_resources()
> >>and device_release_slave() before the device_free_chan_resources().
> >Okay, I had to relook at the series to get around this part. Sorry but we
> >can't call it set_slave, it is actually set_client/consumer
> 
> That's okay, the name of the callbacks should be changed.
> 
> >In our context slaves means dmaengine slave devices aka provider.
> >Client would be the consumer and not slave.
> 
> I'm a new to the DMA engine framework, I'm sorry for using wrong terms.

That's fine :-) we all learn incrementally.

> 
> >>Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>---
> >>  drivers/dma/dmaengine.c   | 27 ++++++++++++++++++++++++---
> >>  include/linux/dmaengine.h | 10 ++++++++++
> >>  2 files changed, 34 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> >>index 24e0221fd66d..5b7089d8be4d 100644
> >>--- a/drivers/dma/dmaengine.c
> >>+++ b/drivers/dma/dmaengine.c
> >>@@ -705,6 +705,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >>  {
> >>  	struct dma_device *d, *_d;
> >>  	struct dma_chan *chan = NULL;
> >>+	int ret;
> >>  	/* If device-tree is present get slave info from here */
> >>  	if (dev->of_node)
> >>@@ -715,8 +716,9 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >>  		chan = acpi_dma_request_slave_chan_by_name(dev, name);
> >>  	if (chan) {
> >>-		/* Valid channel found or requester need to be deferred */
> >>-		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> >>+		if (!IS_ERR(chan))
> >>+			goto found;
> >>+		if (PTR_ERR(chan) == -EPROBE_DEFER)
> >>  			return chan;
> >>  	}
> >>@@ -738,7 +740,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >>  	}
> >>  	mutex_unlock(&dma_list_mutex);
> >>-	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> >>+	if (!chan)
> >>+		return ERR_PTR(-EPROBE_DEFER);
> >>+	if (IS_ERR(chan))
> >>+		return chan;
> >>+found:
> >>+	if (chan->device->device_set_slave) {
> >>+		chan->slave = dev;
> >>+		ret = chan->device->device_set_slave(chan, dev);
> >>+		if (ret) {
> >>+			chan->slave = NULL;
> >>+			dma_release_channel(chan);
> >>+			chan = ERR_PTR(ret);
> >>+		}
> >>+	}
> >>+	return chan;
> >>  }
> >>  EXPORT_SYMBOL_GPL(dma_request_chan);
> >>@@ -786,6 +802,11 @@ void dma_release_channel(struct dma_chan *chan)
> >>  	mutex_lock(&dma_list_mutex);
> >>  	WARN_ONCE(chan->client_count != 1,
> >>  		  "chan reference count %d != 1\n", chan->client_count);
> >>+	if (chan->slave) {
> >>+		if (chan->device->device_release_slave)
> >>+			chan->device->device_release_slave(chan);
> >>+		chan->slave = NULL;
> >>+	}
> >>  	dma_chan_put(chan);
> >>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
> >>  	if (--chan->device->privatecnt == 0)
> >>diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >>index 533680860865..d22299e37e69 100644
> >>--- a/include/linux/dmaengine.h
> >>+++ b/include/linux/dmaengine.h
> >>@@ -277,6 +277,9 @@ struct dma_chan {
> >>  	struct dma_router *router;
> >>  	void *route_data;
> >>+	/* Only for SLAVE channels */
> >>+	struct device *slave;
> >so assuming you refer to consumer aka client here, why do we need set if we
> >store it here.
> 
> DMA engine driver might need to do something with it (like setting up a pm
> link for example) before starting any operations. It would be great if the
> pointer to client device is available in device_alloc_chan_resources(), but
> propagating it there is not possible without significant changes. That's why
> I came with this a separate callback.

But then it gets the client device using the callback as well. So if we
retain that, this should go away.

> Maybe the client device shouldn't be stored in the dma_chan structure at all
> and left to the drivers to use or manage it if really needed. This will also
> solve the issue with virt-dma you have mentioned.
> 
> In the previous version I managed to pass client device pointer to
> device_alloc_chan_resources() via of_xlate callback (please take a look into
> v7), but that approach was rejected by Lars-Peter Clausen.

I feel this is better approach, perhaps we don't need the client pointer
here..

-- 
~Vinod
