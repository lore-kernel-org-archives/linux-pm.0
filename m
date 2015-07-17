From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 7/8] dmaengine: add a driver for Intel integrated DMA
 64-bit
Date: Fri, 17 Jul 2015 10:08:03 +0530
Message-ID: <20150717043803.GE5086@localhost>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1436185334-34275-8-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33659 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbbGQEgZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jul 2015 00:36:25 -0400
Content-Disposition: inline
In-Reply-To: <1436185334-34275-8-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com

On Mon, Jul 06, 2015 at 03:22:13PM +0300, Andy Shevchenko wrote:
> +config IDMA64
> +	tristate "Intel integrated DMA 64-bit support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
no help text?

> +static void idma64_chan_init(struct idma64 *idma64, struct idma64_chan *idma64c)
> +{
> +	u32 cfghi = IDMA64C_CFGH_SRC_PER(1) | IDMA64C_CFGH_DST_PER(0);
> +	u32 cfglo = 0;
> +
> +	/* Enforce FIFO drain when channel is suspended */
> +	cfglo |= IDMA64C_CFGL_CH_DRAIN;
> +
> +	/* Set default burst alignment */
> +	cfglo |= IDMA64C_CFGL_DST_BURST_ALIGN | IDMA64C_CFGL_SRC_BURST_ALIGN;
> +
> +	channel_writel(idma64c, CFG_LO, cfglo);
> +	channel_writel(idma64c, CFG_HI, cfghi);
> +
> +	/* Enable interrupts */
> +	channel_set_bit(idma64, MASK(XFER), idma64c->mask);
> +	channel_set_bit(idma64, MASK(ERROR), idma64c->mask);
> +
> +	/*
> +	 * Enforce the controller to be turned on.
> +	 *
> +	 * The iDMA is turned off in ->probe() and looses context during system
> +	 * suspend / resume cycle. That's why we have to enable it each time we
> +	 * use it.
> +	 */
> +	idma64_on(idma64);
would it be better that you do this in resume and runtime_resume cycle. That
way it need not be called for every channel init

> +static size_t idma64_desc_size(struct idma64_desc *desc, unsigned int active)
> +{
> +	size_t bytes = 0;
> +	unsigned int i;
> +
> +	for (i = active; i < desc->ndesc; i++)
> +		bytes += desc->hw[i].len;
it can help for the non active case to have this size stored in desc while
preparing, that gets rid of runtime calculation for that case
> +
> +	return bytes;
> +}
> +
> +static size_t idma64_pending_desc_size(struct idma64_desc *desc)
> +{
> +	return idma64_desc_size(desc, 0);
> +}
why not invoke with 0 arg from caller?

> +static int idma64_terminate_all(struct dma_chan *chan)
> +{
> +	struct idma64_chan *idma64c = to_idma64_chan(chan);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&idma64c->vchan.lock, flags);
> +	idma64_stop_transfer(idma64c);
I dont think this is the right method for terminate. Can you check, it
might be that we have to suspend the channel before terminating an active
one. For non active case this should be okay

> +static int idma64_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct idma64_chan *idma64c = to_idma64_chan(chan);
> +
> +	/* Create a pool of consistent memory blocks for hardware descriptors */
> +	idma64c->pool = dma_pool_create(dev_name(chan2dev(chan)),
> +					chan->device->dev,
> +					sizeof(struct idma64_lli), 8, 0);
> +	if (!idma64c->pool) {
> +		dev_err(chan2dev(chan), "No memory for descriptors\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
this should return the number descriptors you allocated for the pool

> +
> +static const struct dev_pm_ops idma64_dev_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(idma64_suspend_late, idma64_resume_early)
any reason why late ops?

-- 
~Vinod

