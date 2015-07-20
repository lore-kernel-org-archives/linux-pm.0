From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 7/8] dmaengine: add a driver for Intel integrated DMA 64-bit
Date: Mon, 20 Jul 2015 11:46:28 +0300
Message-ID: <CAHp75VcMej=a0pLT61hbnHmTvY7Mn_aBrrk0Rq0nYbU7e_C67A@mail.gmail.com>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1436185334-34275-8-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150717043803.GE5086@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33127 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbbGTIq3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 04:46:29 -0400
In-Reply-To: <20150717043803.GE5086@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com

On Fri, Jul 17, 2015 at 7:38 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Jul 06, 2015 at 03:22:13PM +0300, Andy Shevchenko wrote:
>> +config IDMA64
>> +     tristate "Intel integrated DMA 64-bit support"
>> +     select DMA_ENGINE
>> +     select DMA_VIRTUAL_CHANNELS
> no help text?

Will fix.

>
>> +static void idma64_chan_init(struct idma64 *idma64, struct idma64_chan *idma64c)
>> +{
>> +     u32 cfghi = IDMA64C_CFGH_SRC_PER(1) | IDMA64C_CFGH_DST_PER(0);
>> +     u32 cfglo = 0;
>> +
>> +     /* Enforce FIFO drain when channel is suspended */
>> +     cfglo |= IDMA64C_CFGL_CH_DRAIN;
>> +
>> +     /* Set default burst alignment */
>> +     cfglo |= IDMA64C_CFGL_DST_BURST_ALIGN | IDMA64C_CFGL_SRC_BURST_ALIGN;
>> +
>> +     channel_writel(idma64c, CFG_LO, cfglo);
>> +     channel_writel(idma64c, CFG_HI, cfghi);
>> +
>> +     /* Enable interrupts */
>> +     channel_set_bit(idma64, MASK(XFER), idma64c->mask);
>> +     channel_set_bit(idma64, MASK(ERROR), idma64c->mask);
>> +
>> +     /*
>> +      * Enforce the controller to be turned on.
>> +      *
>> +      * The iDMA is turned off in ->probe() and looses context during system
>> +      * suspend / resume cycle. That's why we have to enable it each time we
>> +      * use it.
>> +      */
>> +     idma64_on(idma64);
> would it be better that you do this in resume and runtime_resume cycle. That
> way it need not be called for every channel init

Mika, I don't remember details here, but this piece came from you. Can
you shed a light?

My understanding that DMA IP is private to the host controller and has
the same power rail. Thus, there is no need to do separate power
management for it, which makes things more complicated for no profit.
It is also needed for time period from probe till first transfer
(otherwise we have to check the status of DMA anyway and enable it if
required), which currently remains DMA off.

>
>> +static size_t idma64_desc_size(struct idma64_desc *desc, unsigned int active)
>> +{
>> +     size_t bytes = 0;
>> +     unsigned int i;
>> +
>> +     for (i = active; i < desc->ndesc; i++)
>> +             bytes += desc->hw[i].len;
> it can help for the non active case to have this size stored in desc while
> preparing, that gets rid of runtime calculation for that case

I don't see much improvement, since it's a rare cases, but waste of
memory. If you consider that should be done I can implement it.

>> +
>> +     return bytes;
>> +}
>> +
>> +static size_t idma64_pending_desc_size(struct idma64_desc *desc)
>> +{
>> +     return idma64_desc_size(desc, 0);
>> +}
> why not invoke with 0 arg from caller?

Just for sake of making neat code. This is really minor and if you
think better to call directly the mentioned function I can do that.

>
>> +static int idma64_terminate_all(struct dma_chan *chan)
>> +{
>> +     struct idma64_chan *idma64c = to_idma64_chan(chan);
>> +     unsigned long flags;
>> +     LIST_HEAD(head);
>> +
>> +     spin_lock_irqsave(&idma64c->vchan.lock, flags);
>> +     idma64_stop_transfer(idma64c);
> I dont think this is the right method for terminate. Can you check, it
> might be that we have to suspend the channel before terminating an active
> one. For non active case this should be okay

Do you mean hardware can become into wrong state?

Only what can actually happen is the data loss which is in DMA FIFO,
but we already know we would like to terminate the transfer we don't
care about any data loss since that.

I didn't see any specifics to that in the public specification (see
cover letter for a link).

>
>> +static int idma64_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct idma64_chan *idma64c = to_idma64_chan(chan);
>> +
>> +     /* Create a pool of consistent memory blocks for hardware descriptors */
>> +     idma64c->pool = dma_pool_create(dev_name(chan2dev(chan)),
>> +                                     chan->device->dev,
>> +                                     sizeof(struct idma64_lli), 8, 0);
>> +     if (!idma64c->pool) {
>> +             dev_err(chan2dev(chan), "No memory for descriptors\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     return 0;
> this should return the number descriptors you allocated for the pool

Yes, which is exactly zero on this stage.

>
>> +
>> +static const struct dev_pm_ops idma64_dev_pm_ops = {
>> +     SET_LATE_SYSTEM_SLEEP_PM_OPS(idma64_suspend_late, idma64_resume_early)
> any reason why late ops?

We already discussed this several times. There is no dependency
between DMA and its users during PM cycles. We have to be sure that
device (host controller) is quiescent before we stop DMA.

>
> --
> ~Vinod
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
